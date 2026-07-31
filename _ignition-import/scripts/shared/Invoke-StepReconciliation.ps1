<#
.SYNOPSIS
    Cross-artifact reconciliation for the modernization workflow. Catches "plausible but
    wrong" content that passes shape (schema) checks - for example a well-formed testcase
    catalog that names a test file which does not exist on disk.

.DESCRIPTION
    Field contracts (.github/contracts/schemas/ via verify-step-artifacts.ps1) prove an
    artifact is well FORMED. Reconciliation proves it is TRUE against the rest of the
    workspace. This is the second half of the artifact-reliability story: it is the only
    layer that catches a hallucinated-but-believable entry, because such an entry is valid
    JSON and passes every schema check.

    Rules are registered per numbered step. The engine loads the rules for the requested
    step, runs them, and prints DEVELOPER-GUIDING remediation for every violation - so when
    a step cannot self-heal, the developer is still told exactly how to finish the step by
    hand and proceed. A step with no registered rules reconciles to OK (nothing to check).

    This self-check is QA-independent and safe on `No QA` runs: it reads only DEV-authored
    artifacts and the source tree.

.PARAMETER Step
    The numbered step (1-24) whose reconciliation rules should run. Provide either -Step or -StepId, not both.

.PARAMETER StepId
    6-char lowercase hex ID from .github/instructions/step-registry.json (e.g. '26b4e1').
    Resolved to the numeric step number at runtime. Provide either -StepId or -Step, not both.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.OUTPUTS
    Exit code 0 when every registered rule passes (or the step has no rules).
    Exit code 2 when any rule raises a blocking violation.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -Step 17

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -StepId '0576c8'

.NOTES
    Add a rule:
      1. Write a function Invoke-Recon-<Name> that takes -RepoRoot and -Violations (a
         System.Collections.Generic.List[object]) and calls Add-Violation for each problem.
      2. Register it in $RuleRegistry under the step(s) it applies to.
    Each violation should carry actionable remediation text, not just a description.
#>
[CmdletBinding()]
param(
  # Numeric step (1-24). Provide either -Step or -StepId, not both.
  [int]$Step = 0,

  # 6-char hex token from step-registry.json. Resolved to a numeric step at runtime.
  [string]$StepId = '',

  [string]$RepoRoot,

  [string]$StepSummaryPath,

  [switch]$AsJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Reuse the StrictMode-safe property probe from the field-contract validator so JSON
# access behaves identically across the two self-check surfaces.
. (Join-Path $PSScriptRoot 'field-contract.ps1')

# --- Step resolution: accept -Step <n> (numeric) or -StepId <hex> (registry lookup) ---
function Resolve-StepFromRegistry {
  # Reads step-registry.json and translates a 6-char hex stepId to its numeric step number.
  # The registry lives at .github/instructions/step-registry.json (three levels up from /shared/).
  param(
    [Parameter(Mandatory = $true)][string]$StepId,
    [Parameter(Mandatory = $true)][string]$ScriptRoot
  )
  $regPath = Join-Path $ScriptRoot '..' |
    Join-Path -ChildPath '..' |
    Join-Path -ChildPath '..' |
    Join-Path -ChildPath '.github' |
    Join-Path -ChildPath 'instructions' |
    Join-Path -ChildPath 'step-registry.json'
  $regPath = (Resolve-Path -LiteralPath $regPath).Path
  if (-not (Test-Path -LiteralPath $regPath)) {
    throw "step-registry.json not found at '$regPath'. Cannot resolve -StepId '$StepId'."
  }
  $registry = Get-Content -LiteralPath $regPath -Raw -Encoding UTF8 | ConvertFrom-Json
  $entry = $registry.steps | Where-Object { $_.stepId -eq $StepId } | Select-Object -First 1
  if ($null -eq $entry) {
    throw "StepId '$StepId' was not found in step-registry.json. Verify the ID is correct and the registry is up to date."
  }
  return [int]$entry.step
}

if (-not [string]::IsNullOrWhiteSpace($StepId)) {
  if ($Step -gt 0) {
    throw 'Provide either -Step or -StepId, not both.'
  }
  $Step = Resolve-StepFromRegistry -StepId $StepId -ScriptRoot $PSScriptRoot
}
if ($Step -lt 1 -or $Step -gt 24) {
  throw 'Provide a valid -Step (1-24) or -StepId (6-char hex from step-registry.json).'
}

function Resolve-ReconRepoRoot {
  param([string]$Override)
  if (-not [string]::IsNullOrWhiteSpace($Override)) {
    return (Resolve-Path -LiteralPath $Override).Path
  }
  # This script lives at .github/scripts/shared/ ; repo root is three levels up.
  $candidate = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath '..' | Join-Path -ChildPath '..'
  return (Resolve-Path -LiteralPath $candidate).Path
}

function Add-Violation {
  # Append one reconciliation finding. Severity 'block' fails the run; 'warn' does not.
  param(
    [Parameter(Mandatory = $true)] $Violations,
    [Parameter(Mandatory = $true)][string]$Rule,
    [Parameter(Mandatory = $true)][ValidateSet('block', 'warn')][string]$Severity,
    [Parameter(Mandatory = $true)][string]$Message,
    [Parameter(Mandatory = $true)][string]$Remediation
  )
  $Violations.Add([pscustomobject]@{
      Rule        = $Rule
      Severity    = $Severity
      Message     = $Message
      Remediation = $Remediation
    }) | Out-Null
}

function Format-WorkflowTimestamp {
  param([string]$Value)

  if ([string]::IsNullOrWhiteSpace($Value)) {
    return 'Not recorded yet'
  }

  try {
    return ([datetimeoffset]::Parse($Value)).ToString('h:mm tt MM-dd-yyyy').ToLowerInvariant()
  }
  catch {
    return $Value
  }
}

function Get-ShortStatusText {
  param([object]$State)

  if ($null -eq $State -or $null -eq $State.lastExecutedStep -or [int]$State.lastExecutedStep.step -le 0) {
    return 'Not started yet.'
  }

  $status = [string]$State.lastExecutedStep.status
  $reason = [string]$State.lastExecutedStep.reason
  if ([string]::IsNullOrWhiteSpace($reason)) {
    return $status
  }

  $singleLineReason = (($reason -replace '\s+', ' ').Trim())
  if ($singleLineReason.Length -gt 120) {
    $singleLineReason = $singleLineReason.Substring(0, 117).TrimEnd() + '...'
  }

  if ($status -match '^(Completed|Success)$') {
    return $status
  }

  return "$status due to $singleLineReason"
}

function Get-StepDisplay {
  param(
    [int]$StepNumber,
    [string]$Label,
    [string]$EmptyText
  )

  if ($StepNumber -le 0 -or [string]::IsNullOrWhiteSpace($Label)) {
    return $EmptyText
  }

  return ('Step {0} {1}' -f $StepNumber, $Label)
}

function Split-NonEmptyLines {
  param([string]$Value)

  if ([string]::IsNullOrWhiteSpace($Value)) { return @() }

  return @(
    ($Value -split "`r?`n") |
      ForEach-Object { $_.TrimEnd() } |
      Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
  )
}

# --- Shared catalog helpers (the catalog has two real producers / two root keys) ---

function Get-CatalogCaseSet {
  # Returns @{ Cases = <array>; RootKey = 'entries'|'testCases'|'(none)' }.
  # The deterministic generator (generate-characterization-catalog.ps1) writes 'entries[]';
  # the Step 6 prompt example writes 'testCases[]'. Probe both so neither producer is missed.
  param([Parameter(Mandatory = $true)] $CatalogObj)
  foreach ($key in @('entries', 'testCases')) {
    if (Test-HasJsonProperty -Object $CatalogObj -Name $key) {
      $val = $CatalogObj.$key
      if ($null -ne $val) { return @{ Cases = @($val); RootKey = $key } }
    }
  }
  return @{ Cases = @(); RootKey = '(none)' }
}

function Get-CaseField {
  # First non-empty string among candidate property names, or '' if none.
  param([Parameter(Mandatory = $true)] $Case, [Parameter(Mandatory = $true)][string[]]$Names)
  foreach ($n in $Names) {
    if (Test-HasJsonProperty -Object $Case -Name $n) {
      $v = [string]$Case.$n
      if (-not [string]::IsNullOrWhiteSpace($v)) { return $v }
    }
  }
  return ''
}

function Test-CaseDeferred {
  # A case is "not expected to exist yet" when it is explicitly deferred or excluded.
  param([Parameter(Mandatory = $true)] $Case)
  $deferredStatuses = @('Deferred', 'Defer', 'Excluded', 'Exclude', 'Skip', 'Skipped', 'Retire', 'Retired', 'NotApplicable')
  $status = Get-CaseField -Case $Case -Names @('status', 'Status')
  if ($status -and ($deferredStatuses -contains $status)) { return $true }
  $deferMarker = Get-CaseField -Case $Case -Names @('deferralId', 'deferReason', 'excludeReason', 'exclusionReason')
  if (-not [string]::IsNullOrWhiteSpace($deferMarker)) { return $true }
  return $false
}

# --- Rule: every non-deferred catalog testcase that names a test file must resolve ---

function Invoke-Recon-TestcaseFilesResolve {
  param([Parameter(Mandatory = $true)][string]$RepoRoot, [Parameter(Mandatory = $true)] $Violations)

  $catalogRel = '.modernization/portal/data/json/executable-testcase-catalog.json'
  $catalogPath = Join-Path $RepoRoot $catalogRel

  # Presence/schema is owned by verify-step-artifacts.ps1. If the file is absent,
  # reconciliation stays silent so the two gates never double-report the same problem.
  if (-not (Test-Path -LiteralPath $catalogPath)) { return }

  try {
    $raw = Get-Content -LiteralPath $catalogPath -Raw -ErrorAction Stop
    $catalog = $raw | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    Add-Violation -Violations $Violations -Rule 'TestcaseFilesResolve' -Severity 'block' `
      -Message ("Could not read {0} as JSON ({1})." -f $catalogRel, $_.Exception.Message) `
      -Remediation 'The artifact schema gate (verify-step-artifacts.ps1 -Step 6 -Mode Output) explains the required shape. Fix the file or re-run Step 6 to regenerate it, then re-run this reconciliation.'
    return
  }

  $found = Get-CatalogCaseSet -CatalogObj $catalog
  $cases = @($found.Cases)
  if ($cases.Count -eq 0) {
    Add-Violation -Violations $Violations -Rule 'TestcaseFilesResolve' -Severity 'block' `
      -Message ("{0} contains no testcases under an 'entries' or 'testCases' array." -f $catalogRel) `
      -Remediation 'Re-run Step 6 (Modernization Quality Design) to regenerate the executable testcase catalog from current evidence, then re-run this reconciliation.'
    return
  }

  $checked = 0
  foreach ($case in $cases) {
    if (Test-CaseDeferred -Case $case) { continue }
    $testFile = Get-CaseField -Case $case -Names @('testFile', 'TestFile', 'filePath', 'file')
    if ([string]::IsNullOrWhiteSpace($testFile)) { continue }
    $checked++
    $full = Join-Path $RepoRoot $testFile
    if (-not (Test-Path -LiteralPath $full)) {
      $id = Get-CaseField -Case $case -Names @('caseId', 'id', 'caseID', 'Id')
      if ([string]::IsNullOrWhiteSpace($id)) { $id = '(unnamed case)' }
      $owner = Get-CaseField -Case $case -Names @('owningStep', 'ownerStep', 'OwningStep')
      if ([string]::IsNullOrWhiteSpace($owner)) { $owner = '?' }
      Add-Violation -Violations $Violations -Rule 'TestcaseFilesResolve' -Severity 'block' `
        -Message ("Catalog entry '{0}' (owningStep {1}) names test file '{2}', but that file does not exist." -f $id, $owner, $testFile) `
        -Remediation ("Either implement the test at '{0}' as part of Step {1}, or - if this case is intentionally not built - set its status to 'Deferred' with a deferralId and re-run Step 6 to refresh the catalog. Then re-run this reconciliation." -f $testFile, $owner)
    }
  }

  $script:ReconNotes.Add("Catalog root key '$($found.RootKey)', $checked non-deferred testcase(s) with a concrete test file checked.") | Out-Null
}

# --- Route helpers (per-route-behavior-plan has an unproven root container) ---

function Get-RouteEntrySet {
  # Returns @{ Routes = <array>; RootKey = 'routes'|'entries'|'(array)'|'(none)' }.
  # The plan root is not deterministically proven, so probe a bare array root and the
  # common wrapper keys. This mirrors the catalog's two-producer tolerance.
  param([Parameter(Mandatory = $true)] $PlanObj)
  if ((Get-JsonKind -Value $PlanObj) -eq 'array') { return @{ Routes = @($PlanObj); RootKey = '(array)' } }
  foreach ($key in @('routes', 'entries', 'perRouteBehaviorPlan', 'plan')) {
    if (Test-HasJsonProperty -Object $PlanObj -Name $key) {
      $val = $PlanObj.$key
      if ($null -ne $val) { return @{ Routes = @($val); RootKey = $key } }
    }
  }
  return @{ Routes = @(); RootKey = '(none)' }
}

function ConvertTo-NormalizedRouteToken {
  # Lowercase, unify slashes, strip view extensions and surrounding slashes/whitespace.
  # Used both for the plan's legacyRoute and (lightly) for the legacy corpus so format
  # differences (e.g. 'Views/Home/Index.cshtml' vs '/home/index') still match.
  param([string]$Value)
  if ([string]::IsNullOrWhiteSpace($Value)) { return '' }
  $t = $Value.ToLowerInvariant() -replace '\\', '/'
  $t = $t.Trim().Trim('/')
  $t = $t -replace '\.(cshtml|razor|html?|cs|aspx|ascx)$', ''
  $t = $t -replace '\s+', ''
  return $t
}

# --- Rule: every behavior-plan legacyRoute must appear somewhere in Step 3 evidence ---

function Invoke-Recon-RouteLegacyReferenceResolve {
  param([Parameter(Mandatory = $true)][string]$RepoRoot, [Parameter(Mandatory = $true)] $Violations)

  $planRel = '.modernization/portal/data/json/per-route-behavior-plan.json'
  $planPath = Join-Path $RepoRoot $planRel
  if (-not (Test-Path -LiteralPath $planPath)) { return }  # presence owned by the verifier

  try {
    $plan = Get-Content -LiteralPath $planPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    Add-Violation -Violations $Violations -Rule 'RouteLegacyReferenceResolves' -Severity 'block' `
      -Message ("Could not read {0} as JSON ({1})." -f $planRel, $_.Exception.Message) `
      -Remediation 'Re-run Step 6 (Modernization Quality Design) to regenerate the per-route behavior plan, then re-run this reconciliation.'
    return
  }

  $set = Get-RouteEntrySet -PlanObj $plan
  $routes = @($set.Routes)
  if ($routes.Count -eq 0) { return }  # emptiness is the schema gate's job, not this rule's

  # Build a legacy reference corpus from EVERY available Step 3 source. A legacyRoute that
  # appears in NONE of them is the hallucination signal we want; searching all sources
  # (structured + free-form text) keeps false positives near zero.
  $legacySources = @(
    '.modernization/portal/data/json/legacy-system-analysis-report.json',
    '.modernization/ignition-artifacts/discovery/service-behavior-inventory.json',
    '.modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json',
    '.modernization/ignition-artifacts/discovery/workflow-trace-inventory.json',
    '.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json'
  )
  $corpusParts = New-Object System.Collections.Generic.List[string]
  $sourcesFound = 0
  foreach ($rel in $legacySources) {
    $p = Join-Path $RepoRoot $rel
    if (Test-Path -LiteralPath $p) {
      try {
        $raw = Get-Content -LiteralPath $p -Raw -ErrorAction Stop
        if (-not [string]::IsNullOrWhiteSpace($raw)) {
          $corpusParts.Add(($raw.ToLowerInvariant() -replace '\\', '/')) | Out-Null
          $sourcesFound++
        }
      }
      catch { Write-Verbose ("Skipping unreadable legacy source {0}: {1}" -f $rel, $_.Exception.Message) }
    }
  }

  if ($sourcesFound -eq 0) {
    Add-Violation -Violations $Violations -Rule 'RouteLegacyReferenceResolves' -Severity 'warn' `
      -Message 'Cannot reconcile behavior-plan routes: no Step 3 legacy-analysis evidence was found to compare against.' `
      -Remediation 'Re-run Step 3 (Legacy System Analysis) so the legacy inventories exist, then re-run this reconciliation. (This is a warning, not a block: the route claims simply could not be verified.)'
    return
  }

  $corpus = ($corpusParts -join "`n")
  $checked = 0
  foreach ($entry in $routes) {
    $legacyRoute = Get-CaseField -Case $entry -Names @('legacyRoute', 'legacyView', 'legacyPath', 'legacyScreen')
    if ([string]::IsNullOrWhiteSpace($legacyRoute)) { continue }  # not enumerated; not this rule's concern
    $token = ConvertTo-NormalizedRouteToken -Value $legacyRoute
    if ($token.Length -lt 3) { continue }  # too short/ambiguous (e.g. root '/') to reconcile reliably
    $checked++
    if ($corpus.IndexOf($token, [System.StringComparison]::Ordinal) -lt 0) {
      $modernRoute = Get-CaseField -Case $entry -Names @('route', 'modernRoute', 'path')
      if ([string]::IsNullOrWhiteSpace($modernRoute)) { $modernRoute = '(unnamed route)' }
      Add-Violation -Violations $Violations -Rule 'RouteLegacyReferenceResolves' -Severity 'block' `
        -Message ("Behavior-plan route '{0}' maps to legacyRoute '{1}', but that legacy route/view appears nowhere in the Step 3 legacy analysis." -f $modernRoute, $legacyRoute) `
        -Remediation ("Confirm '{0}' is a real legacy route or view path. If it is real, re-run Step 3 (Legacy System Analysis) so the inventory includes it. If it is wrong or invented, correct this route's legacyRoute by re-running Step 6 (Modernization Quality Design). Then re-run this reconciliation." -f $legacyRoute)
    }
  }

  $script:ReconNotes.Add("Behavior-plan root '$($set.RootKey)', $checked route(s) with a legacyRoute checked against $sourcesFound Step 3 source(s).") | Out-Null
}

# --- Rule: every behavior-plan route must ENUMERATE its behaviors (no hollow checklist) ---
# The dead-shell failure mode is a route migrated with its controls, data calls, and actions
# dropped. The per-route behavior plan is the checklist that prevents it - but a plan that
# lists routes with EMPTY interactiveElements and EMPTY primaryDataCalls is a hollow checklist
# that silently permits the same failure. This rule blocks a hollow plan so Steps 11 and 12
# always receive a real, enumerated behavior contract per route instead of rediscovering the
# missing behaviors mid-migration (or not at all).
function Invoke-Recon-BehaviorPlanDepthEnumerated {
  param([Parameter(Mandatory = $true)][string]$RepoRoot, [Parameter(Mandatory = $true)] $Violations)

  $planRel = '.modernization/portal/data/json/per-route-behavior-plan.json'
  $planPath = Join-Path $RepoRoot $planRel
  if (-not (Test-Path -LiteralPath $planPath)) { return }  # presence owned by the verifier

  try {
    $plan = Get-Content -LiteralPath $planPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    Add-Violation -Violations $Violations -Rule 'BehaviorPlanDepthEnumerated' -Severity 'block' `
      -Message ("Could not read {0} as JSON ({1})." -f $planRel, $_.Exception.Message) `
      -Remediation 'Re-run Step 6 (Modernization Quality Design) to regenerate the per-route behavior plan, then re-run this reconciliation.'
    return
  }

  $set = Get-RouteEntrySet -PlanObj $plan
  $routes = @($set.Routes)
  if ($routes.Count -eq 0) { return }  # emptiness owned by the schema notEmpty gate

  $hollow = New-Object System.Collections.Generic.List[string]
  $checked = 0
  foreach ($entry in $routes) {
    if ($null -eq $entry) { continue }
    $modernRoute = Get-CaseField -Case $entry -Names @('route', 'modernRoute', 'path')
    if ([string]::IsNullOrWhiteSpace($modernRoute)) { $modernRoute = '(unnamed route)' }
    $checked++

    # A genuinely static / behavior-free route may enumerate nothing ONLY when it says so
    # explicitly, so a real static page is not false-blocked while a silent omission is.
    $staticRationale = Get-CaseField -Case $entry -Names @('noBehaviorRationale', 'staticRouteReason')
    $isStatic = $false
    if (Test-HasJsonProperty -Object $entry -Name 'staticRoute') {
      $sv = $entry.staticRoute
      if ($sv -is [bool]) { $isStatic = $sv } elseif ("$sv" -match '(?i)^(true|yes)$') { $isStatic = $true }
    }
    if ($isStatic -or -not [string]::IsNullOrWhiteSpace($staticRationale)) { continue }

    $interactiveCount = 0
    foreach ($n in @('interactiveElements', 'interactiveControls', 'controls')) {
      if ((Test-HasJsonProperty -Object $entry -Name $n) -and ($null -ne $entry.$n)) { $interactiveCount = @($entry.$n).Count; break }
    }
    $dataCallCount = 0
    foreach ($n in @('primaryDataCalls', 'dataCalls', 'apiCalls')) {
      if ((Test-HasJsonProperty -Object $entry -Name $n) -and ($null -ne $entry.$n)) { $dataCallCount = @($entry.$n).Count; break }
    }

    if ($interactiveCount -eq 0 -and $dataCallCount -eq 0) {
      $hollow.Add($modernRoute) | Out-Null
    }
  }

  if ($hollow.Count -gt 0) {
    Add-Violation -Violations $Violations -Rule 'BehaviorPlanDepthEnumerated' -Severity 'block' `
      -Message ("{0} behavior-plan route(s) enumerate NO interactive controls and NO primary data calls ({1}). A hollow entry hands Steps 11 and 12 an empty checklist - exactly how migrated pages ship behaviorally dead." -f $hollow.Count, (($hollow.ToArray()) -join ', ')) `
      -Remediation 'Re-run Step 6 (Modernization Quality Design) and enumerate, per route, the legacy interactive controls (interactiveElements) and primary data calls (primaryDataCalls) that Steps 11 and 12 must preserve. A route that genuinely has neither may set "staticRoute": true or a "noBehaviorRationale" string, but a silent empty entry is not allowed.'
  }

  $script:ReconNotes.Add("Behavior-plan depth: $checked route(s) checked, $($hollow.Count) hollow (no enumerated controls or data calls).") | Out-Null
}

function Get-StepSummaryPath {
  param(
    [Parameter(Mandatory = $true)][string]$RepoRoot,
    [string]$Override
  )

  if (-not [string]::IsNullOrWhiteSpace($Override)) {
    return $Override
  }

  return (Join-Path $RepoRoot '.modernization/.readme/.StepSummary.md')
}

function Build-StepSummaryHistoryEntry {
  param([Parameter(Mandatory = $true)]$StepResponse)

  $stepNumber = [int]$StepResponse.step
  if ($stepNumber -le 0) { return '' }

  $stepLabel = [string]$StepResponse.label
  if ([string]::IsNullOrWhiteSpace($stepLabel)) { $stepLabel = 'Unknown Step' }

  $stepStatus = [string]$StepResponse.status
  if ([string]::IsNullOrWhiteSpace($stepStatus)) { $stepStatus = 'Unknown' }

  $updatedAt = [string]$StepResponse.updatedAt
  $updatedAtDisplay = Format-WorkflowTimestamp -Value $updatedAt

  $latestFullResponse = [string]$StepResponse.latestFullResponse
  $responseSource = [string]$StepResponse.latestFullResponseSource
  $responseLines = Split-NonEmptyLines -Value $latestFullResponse
  $outputSnippetLines = @($responseLines | Select-Object -First 10)
  $artifactOrActionLines = @(
    $responseLines |
      Where-Object {
        $_ -match '(?i)(artifact|report|path|generated|captured|build|runtime|decision|url)' -or
        $_ -match '(?i)(\.json|\.md|\.csproj|\.sln|\.ps1|\.ts|\.cs|\.html|\.scss)'
      } |
      Select-Object -Unique -First 6
  )

  $entryLines = New-Object System.Collections.Generic.List[string]
  $entryLines.Add(('<!-- step-run-entry:step={0}|status={1}|updatedAt={2} -->' -f $stepNumber, $stepStatus, $updatedAt)) | Out-Null
  $entryLines.Add(('### Step {0} {1}' -f $stepNumber, $stepLabel)) | Out-Null
  $entryLines.Add(('- Recorded: {0}' -f $updatedAtDisplay)) | Out-Null
  $entryLines.Add(('- Result: {0}' -f $stepStatus)) | Out-Null

  if (-not [string]::IsNullOrWhiteSpace($responseSource)) {
    $entryLines.Add(('- Latest Response Source: {0}' -f $responseSource)) | Out-Null
  }

  if ($artifactOrActionLines.Count -gt 0) {
    $entryLines.Add('- Files/Artifacts/Actions:') | Out-Null
    foreach ($line in $artifactOrActionLines) {
      $entryLines.Add(('  - {0}' -f $line)) | Out-Null
    }
  }
  else {
    $entryLines.Add('- Files/Artifacts/Actions: Not explicitly captured in the step response.') | Out-Null
  }

  if ($outputSnippetLines.Count -gt 0) {
    $entryLines.Add('- Output snippet:') | Out-Null
    $entryLines.Add('```text') | Out-Null
    foreach ($line in $outputSnippetLines) {
      $entryLines.Add($line) | Out-Null
    }
    $entryLines.Add('```') | Out-Null
  }

  return ($entryLines -join [Environment]::NewLine)
}

function Build-StepSummaryDocument {
  param([Parameter(Mandatory = $true)]$State)

  $updatedAtDisplay = Format-WorkflowTimestamp -Value ([string]$State.updatedAt)
  $lastExecutedStep = $State.lastExecutedStep
  $lastStepNumber = 0
  $lastStepLabel = ''
  if ($null -ne $lastExecutedStep) {
    $lastStepNumber = [int]$lastExecutedStep.step
    $lastStepLabel = [string]$lastExecutedStep.label
  }
  $lastStepDisplay = Get-StepDisplay -StepNumber $lastStepNumber -Label $lastStepLabel -EmptyText 'Not started yet'
  $statusText = Get-ShortStatusText -State $State
  $recommendedStep = $State.recommendedNextStep
  $recommendedStepNumber = 1
  $recommendedStepLabel = 'Workstation Readiness'
  if ($null -ne $recommendedStep) {
    if ([int]$recommendedStep.step -gt 0) { $recommendedStepNumber = [int]$recommendedStep.step }
    if (-not [string]::IsNullOrWhiteSpace([string]$recommendedStep.label)) { $recommendedStepLabel = [string]$recommendedStep.label }
  }
  $recommendedStepDisplay = Get-StepDisplay -StepNumber $recommendedStepNumber -Label $recommendedStepLabel -EmptyText 'Step 1 Workstation Readiness'

  $stepResponseEntries = @()
  if ($State.PSObject.Properties.Name -contains 'stepResponses' -and $null -ne $State.stepResponses -and $State.stepResponses.PSObject.Properties.Name -contains 'steps' -and $null -ne $State.stepResponses.steps) {
    $stepResponseEntries = @(
      $State.stepResponses.steps |
        Where-Object {
          [int]$_.step -gt 0 -and (
            -not [string]::IsNullOrWhiteSpace([string]$_.updatedAt) -or
            -not [string]::IsNullOrWhiteSpace([string]$_.latestFullResponse) -or
            -not [string]::IsNullOrWhiteSpace([string]$_.status)
          )
        } |
        Sort-Object { [int]$_.step }
    )
  }

  $historyLines = New-Object System.Collections.Generic.List[string]
  $historyLines.Add('<!-- step-run-history:start -->') | Out-Null

  if ($stepResponseEntries.Count -eq 0) {
    $historyLines.Add('_No step runs recorded yet._') | Out-Null
  }
  else {
    foreach ($stepResponse in $stepResponseEntries) {
      $historyLines.Add((Build-StepSummaryHistoryEntry -StepResponse $stepResponse)) | Out-Null
      $historyLines.Add('') | Out-Null
    }
    if ($historyLines.Count -gt 1 -and [string]::IsNullOrWhiteSpace($historyLines[$historyLines.Count - 1])) {
      [void]$historyLines.RemoveAt($historyLines.Count - 1)
    }
  }

  $historyLines.Add('<!-- step-run-history:end -->') | Out-Null

  $documentLines = @(
    '# Ignition Kit Step Summary'
    ''
    'Purpose: Track the latest numbered step execution plus lightweight per-step run details (status, notable files/artifacts, and output snippets).'
    'The step summary is regenerated from the saved numbered-step state so each step keeps one current entry and a rerun replaces the existing entry for that step.'
    ''
    '<!-- workflow-status:start -->'
    '_Current workflow snapshot_'
    ('**Updated At:** {0}' -f $updatedAtDisplay)
    ('**Last Step Ran:** {0}' -f $lastStepDisplay)
    ('**Last Step Status:** {0}' -f $statusText)
    ('**Recommended Next Step:** {0}' -f $recommendedStepDisplay)
    '<!-- workflow-status:end -->'
    ''
    '## Step Run History'
    ''
    ($historyLines -join [Environment]::NewLine)
    ''
  )

  return ($documentLines -join [Environment]::NewLine)
}

function Write-StepSummaryDocument {
  param(
    [Parameter(Mandatory = $true)][string]$SummaryPath,
    [Parameter(Mandatory = $true)]$State
  )

  $directory = Split-Path -Path $SummaryPath -Parent
  if (-not [string]::IsNullOrWhiteSpace($directory) -and -not (Test-Path -LiteralPath $directory)) {
    [void](New-Item -Path $directory -ItemType Directory -Force)
  }

  $content = Build-StepSummaryDocument -State $State
  $utf8NoBom = [System.Text.UTF8Encoding]::new($false)
  [System.IO.File]::WriteAllText($SummaryPath, $content, $utf8NoBom)
}

function Update-StepSummaryFromState {
  param(
    [Parameter(Mandatory = $true)][string]$RepoRoot,
    [string]$WorkflowStatePath,
    [string]$SummaryPath
  )

  $resolvedWorkflowStatePath = if ([string]::IsNullOrWhiteSpace($WorkflowStatePath)) { Join-Path $RepoRoot '.modernization/portal/data/json/step-workflow-state.json' } else { $WorkflowStatePath }
  if (-not (Test-Path -LiteralPath $resolvedWorkflowStatePath)) {
    return $false
  }

  $raw = Get-Content -LiteralPath $resolvedWorkflowStatePath -Raw -ErrorAction Stop
  if ([string]::IsNullOrWhiteSpace($raw)) {
    return $false
  }

  $state = $raw | ConvertFrom-Json -ErrorAction Stop
  $resolvedSummaryPath = Get-StepSummaryPath -RepoRoot $RepoRoot -Override $SummaryPath
  Write-StepSummaryDocument -SummaryPath $resolvedSummaryPath -State $state
  return $true
}

# --- Rule: Step 6/8 catalog normalization (testMethod, owningStep, testFile fields) ---

function Invoke-Recon-CatalogNormalizedFields {
  param([Parameter(Mandatory = $true)][string]$RepoRoot, [Parameter(Mandatory = $true)] $Violations)

  $catalogRel = '.modernization/portal/data/json/executable-testcase-catalog.json'
  $catalogPath = Join-Path $RepoRoot $catalogRel

  if (-not (Test-Path -LiteralPath $catalogPath)) { return }

  try {
    $raw = Get-Content -LiteralPath $catalogPath -Raw -ErrorAction Stop
    $catalog = $raw | ConvertFrom-Json -ErrorAction Stop
  }
  catch {
    Add-Violation -Violations $Violations -Rule 'CatalogNormalizedFields' -Severity 'block' `
      -Message ("Could not read {0} as JSON ({1})." -f $catalogRel, $_.Exception.Message) `
      -Remediation 'The artifact schema gate (verify-step-artifacts.ps1 -Step 6 -Mode Output) explains the required shape. Fix the file or re-run Step 6 to regenerate it, then re-run this reconciliation.'
    return
  }

  $found = Get-CatalogCaseSet -CatalogObj $catalog
  $cases = @($found.Cases)
  if ($cases.Count -eq 0) { return }

  # For Step 6, check that normalized fields are present and populated in catalog entries
  # For Step 8, this is even more critical - owningStep=8 entries MUST have testMethod and testFile
  $missingNormalizedCount = 0
  $step8MissingCount = 0
  foreach ($case in $cases) {
    if (Test-CaseDeferred -Case $case) { continue }

    # Check for normalized fields required by Step 8 execution
    $hasOwningStep = Test-HasJsonProperty -Object $case -Name 'owningStep'
    $hasTestMethod = Test-HasJsonProperty -Object $case -Name 'testMethod'
    $hasTestFile = Test-HasJsonProperty -Object $case -Name 'testFile'

    if (-not ($hasOwningStep -and $hasTestMethod -and $hasTestFile)) {
      $missingNormalizedCount++

      # Check if this is a Step 8 entry - those are mandatory
      $owningStep = if ($hasOwningStep) { [string]$case.owningStep } else { '' }
      if ($owningStep -eq '8') {
        $step8MissingCount++
        $caseId = Get-CaseField -Case $case -Names @('caseId', 'id', 'testCaseId')
        if ([string]::IsNullOrWhiteSpace($caseId)) { $caseId = '(unnamed case)' }
        Add-Violation -Violations $Violations -Rule 'CatalogNormalizedFields' -Severity 'block' `
          -Message ("Catalog entry '{0}' is assigned to owningStep 8 but missing required normalized fields: {1}" -f $caseId,
            @(if (-not $hasTestMethod) { 'testMethod' } else { }; if (-not $hasTestFile) { 'testFile' } else { }) -join ', ') `
          -Remediation 'Re-run Step 6 (Modernization Quality Design) to regenerate the executable testcase catalog with normalized fields, then re-run this reconciliation.'
      }
    }
  }

  if ($missingNormalizedCount -gt 0 -and $step8MissingCount -eq 0) {
    # Non-Step-8 entries missing normalized fields is advisory (will be caught when those steps execute)
    $script:ReconNotes.Add("Catalog contains $missingNormalizedCount entries missing normalized fields (owningStep, testMethod, testFile). These entries will be unavailable to their owning steps until the catalog is regenerated.") | Out-Null
  }
}

# --- Rule registry: step number -> ordered list of rule functions ---

$RuleRegistry = @{
  6 = @('Invoke-Recon-CatalogNormalizedFields', 'Invoke-Recon-BehaviorPlanDepthEnumerated')
  8 = @('Invoke-Recon-CatalogNormalizedFields')
  11 = @('Invoke-Recon-RouteLegacyReferenceResolve', 'Invoke-Recon-BehaviorPlanDepthEnumerated')
  17 = @('Invoke-Recon-TestcaseFilesResolve')
}

# --- Engine ---

$root = Resolve-ReconRepoRoot -Override $RepoRoot
$script:ReconNotes = New-Object System.Collections.Generic.List[string]
$violations = New-Object System.Collections.Generic.List[object]

$stepSummaryUpdated = $false
try {
  # Let the summary helper resolve the canonical workflow-state path itself.
  $stepSummaryUpdated = Update-StepSummaryFromState -RepoRoot $root -SummaryPath $StepSummaryPath
}
catch {
  Write-Verbose ("Step summary refresh failed: {0}" -f $_.Exception.Message)
}

$ruleNames = @()
if ($RuleRegistry.ContainsKey($Step)) { $ruleNames = @($RuleRegistry[$Step]) }

foreach ($ruleName in $ruleNames) {
  & $ruleName -RepoRoot $root -Violations $violations
}

$blockers = @($violations | Where-Object { $_.Severity -eq 'block' })
$warnings = @($violations | Where-Object { $_.Severity -eq 'warn' })
$hasBlocker = ($blockers.Count -gt 0)

if ($AsJson) {
  [pscustomobject]@{
    step       = $Step
    rulesRun   = $ruleNames
    note       = ($script:ReconNotes -join ' ')
    blocked    = $hasBlocker
    violations = $violations
  } | ConvertTo-Json -Depth 6
  exit $(if ($hasBlocker) { 2 } else { 0 })
}

Write-Host ""
Write-Host ("Step {0} - Cross-artifact reconciliation" -f $Step) -ForegroundColor Cyan
if ($ruleNames.Count -eq 0) {
  Write-Host "  No reconciliation rules are registered for this step." -ForegroundColor DarkGray
  Write-Host ""
  Write-Host "RESULT: OK - nothing to reconcile for this step." -ForegroundColor Green
  exit 0
}
if (-not [string]::IsNullOrWhiteSpace(($script:ReconNotes -join ' '))) {
  foreach ($n in $script:ReconNotes) { Write-Host ("  {0}" -f $n) -ForegroundColor Gray }
}

foreach ($v in $violations) {
  $tag = if ($v.Severity -eq 'block') { '[BLOCK]' } else { '[warn] ' }
  $color = if ($v.Severity -eq 'block') { 'Red' } else { 'Yellow' }
  Write-Host ("  {0} {1}" -f $tag, $v.Message) -ForegroundColor $color
  Write-Host ("        Fix: {0}" -f $v.Remediation) -ForegroundColor DarkYellow
}

Write-Host ""
if ($hasBlocker) {
  Write-Host ("RESULT: BLOCKED - {0} reconciliation issue(s) need attention (see Fix lines above)." -f $blockers.Count) -ForegroundColor Red
  Write-Host "          These are content-truth problems, not shape problems: the file is valid JSON but disagrees with the workspace." -ForegroundColor DarkGray
  exit 2
}

if ($stepSummaryUpdated) {
  Write-Host ("  Step summary updated: {0}" -f (Resolve-Path -LiteralPath (Get-StepSummaryPath -RepoRoot $root -Override $StepSummaryPath)).Path) -ForegroundColor DarkGray
}

if ($warnings.Count -gt 0) {
  Write-Host ("RESULT: OK (with {0} warning(s)) - no blocking reconciliation issues." -f $warnings.Count) -ForegroundColor Green
}
else {
  Write-Host "RESULT: OK - all reconciliation rules passed." -ForegroundColor Green
}
exit 0

