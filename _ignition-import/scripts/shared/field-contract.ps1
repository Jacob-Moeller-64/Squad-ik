<#
.SYNOPSIS
    Dependency-free field-contract validator for modernization JSON artifacts.

.DESCRIPTION
    Validates a parsed JSON value against a lightweight "opx-field-contract/v1" schema
    dialect that lives under .github/contracts/schemas/. This is intentionally NOT JSON
    Schema (Draft 7+): the kit must run on Windows PowerShell 5.1, where `Test-Json -Schema`
    is unavailable. The dialect is deliberately small - presence (required), type,
    non-emptiness, enums, nested fields, and array-element contracts - so a junior maintainer
    can read and extend it without learning a large spec.

    Authoring rule (important): a field contract MUST pass on a legitimately INITIALIZED
    artifact. Many state and control-plane files are created with empty strings or empty
    arrays before any step enriches them. Only mark `notEmpty` on a field that is non-empty
    even at init, or the gate will false-positive on a valid, freshly-reset workspace.

    Dot-source this file to import its functions:
      . (Join-Path $PSScriptRoot 'field-contract.ps1')

    Dialect keys understood by this validator (everything else is ignored metadata):
      type       : one of object | array | string | number | boolean | any
      required   : array of property names that MUST be present (object nodes only)
      fields     : map of propertyName -> child contract (object nodes only)
      notEmpty   : true => string not whitespace, array length > 0, object has >= 1 property
      enum       : array of allowed scalar values
      minItems   : minimum element count (array nodes only)
      arrayOf    : a child contract applied to every array element (array nodes only)
      rootPath   : optional label used as the root of violation messages (top-level only)

.NOTES
    Exposed functions: Get-JsonKind, Test-ArtifactFieldContract, Test-JsonFileAgainstContract.
    Pure functions only - dot-sourcing this file has no side effects.
#>

Set-StrictMode -Version Latest

function Get-JsonKind {
  # Maps a PowerShell value (as produced by ConvertFrom-Json) to a JSON kind string.
  # Order matters: scalar checks first, then dictionary/object, then generic enumerable.
  [CmdletBinding()]
  param([Parameter(Mandatory = $false)] $Value)

  if ($null -eq $Value) { return 'null' }
  if ($Value -is [string]) { return 'string' }
  if ($Value -is [bool]) { return 'boolean' }
  if ($Value -is [int] -or $Value -is [long] -or $Value -is [double] -or
    $Value -is [decimal] -or $Value -is [single] -or $Value -is [int16] -or
    $Value -is [byte] -or $Value -is [uint16] -or $Value -is [uint32] -or
    $Value -is [uint64]) { return 'number' }
  if ($Value -is [System.Management.Automation.PSCustomObject]) { return 'object' }
  if ($Value -is [System.Collections.IDictionary]) { return 'object' }
  if ($Value -is [System.Collections.IEnumerable]) { return 'array' }
  # Anything else (rare) is treated as an object so nested checks can still run safely.
  return 'object'
}

function Test-HasJsonProperty {
  # StrictMode-safe property probe. Returns $true only when $Object exposes $Name.
  # Uses the PSObject.Properties indexer (not `.Name -contains`) so an EMPTY object
  # ({} from ConvertFrom-Json) does not throw PropertyNotFoundStrict under StrictMode.
  [CmdletBinding()]
  param([Parameter(Mandatory = $false)] $Object, [Parameter(Mandatory = $true)][string]$Name)

  if ($null -eq $Object) { return $false }
  $props = $Object.PSObject.Properties
  if ($null -eq $props) { return $false }
  return ($null -ne $props[$Name])
}

function Invoke-FieldContractNode {
  # Recursive worker. Appends human-readable violation strings to $Violations.
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)] $Data,
    [Parameter(Mandatory = $true)] $Node,
    [Parameter(Mandatory = $true)][string]$NodePath,
    [Parameter(Mandatory = $true)] $Violations
  )

  if ($null -eq $Node) { return }

  $kind = Get-JsonKind -Value $Data

  # 1) Type check. A mismatch is reported and stops deeper checks for this node
  #    (deeper checks against the wrong kind would only produce confusing noise).
  if (Test-HasJsonProperty -Object $Node -Name 'type') {
    $declared = [string]$Node.type
    if ($declared -and $declared -ne 'any' -and $kind -ne $declared) {
      $Violations.Add(("{0}: expected type '{1}' but found '{2}'" -f $NodePath, $declared, $kind)) | Out-Null
      return
    }
  }

  # 2) Non-emptiness.
  if ((Test-HasJsonProperty -Object $Node -Name 'notEmpty') -and [bool]$Node.notEmpty) {
    switch ($kind) {
      'string' { if ([string]::IsNullOrWhiteSpace([string]$Data)) { $Violations.Add(("{0}: must not be empty" -f $NodePath)) | Out-Null } }
      'array' { if (@($Data).Count -eq 0) { $Violations.Add(("{0}: array must contain at least one item" -f $NodePath)) | Out-Null } }
      'object' { if (@($Data.PSObject.Properties).Count -eq 0) { $Violations.Add(("{0}: object must contain at least one property" -f $NodePath)) | Out-Null } }
      'null' { $Violations.Add(("{0}: must not be null" -f $NodePath)) | Out-Null }
    }
  }

  # 3) Enum membership (scalars only; null is handled by required/notEmpty elsewhere).
  if (Test-HasJsonProperty -Object $Node -Name 'enum') {
    $allowed = @($Node.enum)
    if (($kind -ne 'null') -and ($allowed -notcontains $Data)) {
      $Violations.Add(("{0}: value '{1}' is not one of [{2}]" -f $NodePath, $Data, ($allowed -join ', '))) | Out-Null
    }
  }

  if ($kind -eq 'object') {
    # 4) Required properties.
    if (Test-HasJsonProperty -Object $Node -Name 'required') {
      foreach ($req in @($Node.required)) {
        if (-not (Test-HasJsonProperty -Object $Data -Name ([string]$req))) {
          $Violations.Add(("{0}.{1}: required field is missing" -f $NodePath, $req)) | Out-Null
        }
      }
    }
    # 5) Recurse into declared child fields that are present.
    if (Test-HasJsonProperty -Object $Node -Name 'fields') {
      foreach ($fieldProp in $Node.fields.PSObject.Properties) {
        $fname = $fieldProp.Name
        if (Test-HasJsonProperty -Object $Data -Name $fname) {
          Invoke-FieldContractNode -Data $Data.$fname -Node $fieldProp.Value -NodePath ("{0}.{1}" -f $NodePath, $fname) -Violations $Violations
        }
      }
    }
  }
  elseif ($kind -eq 'array') {
    # 6) Minimum item count.
    if (Test-HasJsonProperty -Object $Node -Name 'minItems') {
      $min = [int]$Node.minItems
      if (@($Data).Count -lt $min) {
        $Violations.Add(("{0}: expected at least {1} item(s) but found {2}" -f $NodePath, $min, @($Data).Count)) | Out-Null
      }
    }
    # 7) Per-element contract.
    if (Test-HasJsonProperty -Object $Node -Name 'arrayOf') {
      $idx = 0
      foreach ($elem in @($Data)) {
        Invoke-FieldContractNode -Data $elem -Node $Node.arrayOf -NodePath ("{0}[{1}]" -f $NodePath, $idx) -Violations $Violations
        $idx++
      }
    }
  }
}

function Test-ArtifactFieldContract {
  <#
    .SYNOPSIS
      Validate an already-parsed JSON value against a parsed field contract.
    .OUTPUTS
      [string[]] of violation messages. An empty array means the value satisfies the contract.
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $false)] $Data,
    [Parameter(Mandatory = $true)] $Contract,
    [string]$Path = '$'
  )

  $violations = New-Object System.Collections.Generic.List[string]
  Invoke-FieldContractNode -Data $Data -Node $Contract -NodePath $Path -Violations $violations
  return , $violations.ToArray()
}

function Test-JsonFileAgainstContract {
  <#
    .SYNOPSIS
      Read a JSON artifact and a field-contract file, then validate one against the other.
    .OUTPUTS
      [pscustomobject] with:
        Ok         [bool]     - $true when the artifact satisfies the contract.
        Violations [string[]] - field-level violation messages (empty when Ok).
        Error      [string]   - tooling problem (missing/corrupt contract); '' when none.
      A populated Error means "could not validate", which callers should treat as a loud
      warning rather than a content defect, so a registry mistake never silently passes
      and never hard-blocks a developer mid-run.
  #>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)][string]$JsonPath,
    [Parameter(Mandatory = $true)][string]$ContractPath
  )

  $result = [pscustomobject]@{
    Ok         = $false
    Violations = @()
    Error      = ''
  }

  if (-not (Test-Path -LiteralPath $ContractPath)) {
    $result.Error = "Field contract not found: $ContractPath"
    return $result
  }
  if (-not (Test-Path -LiteralPath $JsonPath)) {
    $result.Error = "JSON artifact not found: $JsonPath"
    return $result
  }

  try {
    $contractObj = Get-Content -LiteralPath $ContractPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    $result.Error = "Field contract is not valid JSON: $($_.Exception.Message)"
    return $result
  }

  try {
    $raw = Get-Content -LiteralPath $JsonPath -Raw -ErrorAction Stop
  }
  catch {
    $result.Error = "Unable to read JSON artifact: $($_.Exception.Message)"
    return $result
  }

  if ([string]::IsNullOrWhiteSpace($raw)) {
    $result.Violations = @('$: file is empty')
    return $result
  }

  try {
    $dataObj = $raw | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    $result.Violations = @(('$: file is not valid JSON ({0})' -f $_.Exception.Message))
    return $result
  }

  $rootPath = if (Test-HasJsonProperty -Object $contractObj -Name 'rootPath') { [string]$contractObj.rootPath } else { '$' }
  $violations = Test-ArtifactFieldContract -Data $dataObj -Contract $contractObj -Path $rootPath
  $result.Violations = @($violations)
  $result.Ok = (@($violations).Count -eq 0)
  return $result
}
