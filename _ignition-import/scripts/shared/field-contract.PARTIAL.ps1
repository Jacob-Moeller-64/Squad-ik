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

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-63 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be dot-sourced.
# ---------------------------------------------------------------------------
