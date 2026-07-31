<#
.SYNOPSIS
    Verifies that a numbered modernization step has the upstream artifacts it needs (inputs)
    and has produced the artifacts that later steps consume (outputs), independent of QA.

.DESCRIPTION
    Reads the per-step artifact contract at .github/instructions/AppMod-Artifact-Contract.json,
    resolves the current application name from .modernization/.readme/kit-params.md (or the
    -AppName override), and checks presence and non-emptiness of each declared artifact for the
    requested step.

    This is the deterministic, QA-independent self-check surface for the workflow. Every numbered
    prompt can call it at entry (-Mode Input) to confirm it ingested what it needs, and at closeout
    (-Mode Output) to confirm it produced what later prompts consume. Running with QA disabled never
    changes the result, because the contract only depends on DEV-authored and DEV-script artifacts.

.PARAMETER Step
    The numbered step (1-24) to verify. Provide either -Step or -StepId, not both.

.PARAMETER StepId
    6-char lowercase hex ID from .github/instructions/step-registry.json (e.g. '26b4e1').
    Resolved to the numeric step number at runtime. Provide either -StepId or -Step, not both.

.PARAMETER Mode
    Input  - verify required upstream inputs only.
    Output - verify produced outputs only.
    Both   - verify inputs then outputs (default).

.PARAMETER AppName
    Optional application name. When omitted, it is read from kit-params.md.

.PARAMETER EnsureControlPlane
    When set, deterministically materializes a generic, app-agnostic skeleton for any missing
    control-plane JSON (modernization-execution-contract.json, modernization-phase-assessment.json,
    modernization-solution-design.json) so a No QA run is never blocked by a missing control file.
    The skeleton is a placeholder the owning step enriches; it never fabricates application routes.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.OUTPUTS
    Exit code 0 when all checked artifacts are present and non-empty.
    Exit code 2 when a required input or a declared output is missing or empty.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 8 -Mode Input

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 5 -Mode Output

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -StepId '26b4e1' -Mode Input
#>
[CmdletBinding()]
param(
  # Numeric step (1-24). Provide either -Step or -StepId, not both.
  [int]$Step = 0,

  # 6-char hex token from step-registry.json. Resolved to a numeric step at runtime.
  [string]$StepId = '',

  [ValidateSet('Input', 'Output', 'Both')]
  [string]$Mode = 'Both',

  [string]$AppName,

  [switch]$EnsureControlPlane,

  [string]$RepoRoot,

  [switch]$AsJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Import the dependency-free field-contract validator (Windows PowerShell 5.1 safe).
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

function Resolve-RepoRoot {
  param([string]$Override)
  if (-not [string]::IsNullOrWhiteSpace($Override)) {
    return (Resolve-Path -LiteralPath $Override).Path
  }
  # This script lives at .github/scripts/shared/ ; repo root is three levels up.
  $candidate = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath '..' | Join-Path -ChildPath '..'
  return (Resolve-Path -LiteralPath $candidate).Path
}

function Get-AppName {
  param([string]$RepoRoot, [string]$Override)
  if (-not [string]::IsNullOrWhiteSpace($Override)) { return $Override.Trim() }
  $paramsPath = Join-Path $RepoRoot '.modernization/.readme/kit-params.md'
  if (Test-Path -LiteralPath $paramsPath) {
    $match = Select-String -LiteralPath $paramsPath -Pattern '(?im)^\s*[-*]?\s*appName\s*[:=]\s*(.+?)\s*$' | Select-Object -First 1
    if ($match) {
      $value = $match.Matches[0].Groups[1].Value.Trim().Trim('`', '"', "'")
      if (-not [string]::IsNullOrWhiteSpace($value)) { return $value }
    }
  }
  return '<AppName>'
}

function Test-ArtifactPresent {
  param([string]$FullPath)
  # Returns: Missing | Hollow | Present
  if (-not (Test-Path -LiteralPath $FullPath)) { return 'Missing' }
  if (Test-Path -LiteralPath $FullPath -PathType Container) {
    $hasChild = @(Get-ChildItem -LiteralPath $FullPath -Force -ErrorAction SilentlyContinue | Select-Object -First 1).Count -gt 0
    return $(if ($hasChild) { 'Present' } else { 'Hollow' })
  }
  $raw = ''
  try { $raw = Get-Content -LiteralPath $FullPath -Raw -ErrorAction Stop } catch { $raw = '' }
  $trimmed = ($raw -replace '\s', '')
  if ([string]::IsNullOrEmpty($trimmed) -or $trimmed -eq '{}' -or $trimmed -eq '[]') { return 'Hollow' }
  return 'Present'
}

function New-ControlPlaneSkeleton {
  param([string]$RepoRoot, [string]$AppName, [string]$FileName)
  $jsonDir = Join-Path $RepoRoot '.modernization/portal/data/json'
  if (-not (Test-Path -LiteralPath $jsonDir)) { New-Item -ItemType Directory -Path $jsonDir -Force | Out-Null }
  $target = Join-Path $jsonDir $FileName
  $status = Test-ArtifactPresent -FullPath $target
  if ($status -eq 'Present') { return $false }

  $generatedAt = (Get-Date).ToUniversalTime().ToString('o')
  $common = [ordered]@{
    generatedAt         = $generatedAt
    sourcePhase         = 'verify-step-artifacts:EnsureControlPlane'
    pendingEnrichment   = $true
    authoritativeSource = '.modernization/ignition-artifacts/' + ($FileName -replace '\.json$', '' -replace 'modernization-', 'Modernization-') + '.md'
    note                = 'Generic placeholder so No QA runs are not blocked. The owning step (Step 5) enriches this from the application''s real evidence. No application routes are fabricated here.'
  }
  switch ($FileName) {
    'modernization-execution-contract.json' {
      $doc = [ordered]@{
        reportId                   = 'modernization-execution-contract'
        title                      = 'Modernization Execution Contract'
        modernizationWorkspaceRoot = 'src'
        targetBackendRoot          = @('src/' + $AppName + '.Library', 'src/' + $AppName + '.Web.Api')
        targetClientRoot           = 'src/' + $AppName + '.Web.Client'
        step7BackendPort           = 5100
        step9BackendPort           = 5100
        step7FrontendPort          = 5200
        step9FrontendPort          = 5200
        orderedSlices              = @()
      }
    }
    'modernization-phase-assessment.json' {
      $doc = [ordered]@{
        reportId = 'modernization-phase-assessment'
        title    = 'Modernization Phase Assessment'
        phases   = @()
      }
    }
    default {
      $doc = [ordered]@{
        reportId = 'modernization-solution-design-plan'
        title    = 'Modernization Solution Design'
        sections = @()
      }
    }
  }
  foreach ($key in $common.Keys) { $doc[$key] = $common[$key] }
  $doc | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $target -Encoding UTF8
  return $true
}

function Get-CatalogCaseSet {
  param([Parameter(Mandatory = $true)] $CatalogObj)

  foreach ($key in @('entries', 'testCases')) {
    if ($CatalogObj.PSObject.Properties.Name -contains $key) {
      $val = $CatalogObj.$key
      if ($null -ne $val) { return @{ Cases = @($val); RootKey = $key } }
    }
  }

  if ($CatalogObj.PSObject.Properties.Name -contains 'suites' -and $null -ne $CatalogObj.suites) {
    $suiteCases = New-Object System.Collections.Generic.List[object]
    foreach ($suite in @($CatalogObj.suites)) {
      if ($null -eq $suite) { continue }
      $suiteType = if ($suite.PSObject.Properties.Name -contains 'suiteType') { [string]$suite.suiteType } else { '' }
      foreach ($case in @($suite.testCases)) {
        if ($null -eq $case) { continue }

        if (-not ($case.PSObject.Properties.Name -contains 'suiteType') -and -not [string]::IsNullOrWhiteSpace($suiteType)) {
          try { $case | Add-Member -NotePropertyName suiteType -NotePropertyValue $suiteType -Force } catch {}
        }
        if (-not ($case.PSObject.Properties.Name -contains 'materializationPhase') -and ($suite.PSObject.Properties.Name -contains 'materializationPhase')) {
          try { $case | Add-Member -NotePropertyName materializationPhase -NotePropertyValue ([string]$suite.materializationPhase) -Force } catch {}
        }
        if (-not ($case.PSObject.Properties.Name -contains 'ownerPhase') -and ($suite.PSObject.Properties.Name -contains 'ownerPhase')) {
          try { $case | Add-Member -NotePropertyName ownerPhase -NotePropertyValue ([string]$suite.ownerPhase) -Force } catch {}
        }

        $suiteCases.Add($case) | Out-Null
      }
    }

    if ($suiteCases.Count -gt 0) {
      return @{ Cases = @($suiteCases.ToArray()); RootKey = 'suites[].testCases' }
    }
  }

  return @{ Cases = @(); RootKey = '(none)' }
}

function Get-StepSemanticReadinessFindings {
  param(
    [Parameter(Mandatory = $true)][int]$Step,
    [Parameter(Mandatory = $true)][string]$RepoRoot,
    [Parameter(Mandatory = $false)][string]$VerificationMode = 'Output'
  )

  $findings = @()
  $catalogPath = Join-Path $RepoRoot '.modernization/portal/data/json/executable-testcase-catalog.json'
  $qaPlanPath = Join-Path $RepoRoot '.modernization/portal/data/json/qa-test-plan.json'
  $workflowStatePath = Join-Path $RepoRoot '.modernization/portal/data/json/step-workflow-state.json'

  function Add-ReadinessFinding {
    param(
      [string]$Message,
      [string]$Remediation,
      [bool]$IsBlocker = $true
    )

    $script:semanticFindingBuffer += [pscustomobject]@{
      Message     = [string]$Message
      Remediation = [string]$Remediation
      IsBlocker   = [bool]$IsBlocker
    }
  }

  $script:semanticFindingBuffer = @()

  function Resolve-CaseOwnerStepNumber {
    param([Parameter(Mandatory = $true)]$Case)

    $ownerStepValue = ''
    if ($Case.PSObject.Properties.Name -contains 'owningStep') { $ownerStepValue = [string]$Case.owningStep }
    elseif ($Case.PSObject.Properties.Name -contains 'ownerStep') { $ownerStepValue = [string]$Case.ownerStep }
    if (-not [string]::IsNullOrWhiteSpace($ownerStepValue)) {
      try {
        $parsedFromField = [int]($ownerStepValue -replace '[^0-9]', '')
        if ($parsedFromField -gt 0) { return $parsedFromField }
      }
      catch {}
    }

    $phaseCandidate = ''
    if ($Case.PSObject.Properties.Name -contains 'ownerPhase') { $phaseCandidate = [string]$Case.ownerPhase }
    if ([string]::IsNullOrWhiteSpace($phaseCandidate) -and $Case.PSObject.Properties.Name -contains 'materializationPhase') {
      $phaseCandidate = [string]$Case.materializationPhase
    }
    if (-not [string]::IsNullOrWhiteSpace($phaseCandidate)) {
      $stepMatch = [regex]::Match($phaseCandidate, '(?i)Step\s*(\d+)')
      if ($stepMatch.Success) {
        try {
          $parsedFromPhase = [int]$stepMatch.Groups[1].Value
          if ($parsedFromPhase -gt 0) { return $parsedFromPhase }
        }
        catch {}
      }
    }

    return 0
  }

  function Resolve-CaseOwnerStepNumbers {
    # Returns ALL step numbers a case covers. Handles range notation like "Step10-13" -> [10,11,12,13].
    # Used by the Step 6 downstream coverage check so a catalog entry with a phase range
    # credits every step in that range, not just the first one.
    param([Parameter(Mandatory = $true)]$Case)

    $result = New-Object System.Collections.Generic.List[int]

    # If the case has an explicit owningStep or ownerStep field, that is the one and only step.
    $ownerStepValue = ''
    if ($Case.PSObject.Properties.Name -contains 'owningStep') { $ownerStepValue = [string]$Case.owningStep }
    elseif ($Case.PSObject.Properties.Name -contains 'ownerStep') { $ownerStepValue = [string]$Case.ownerStep }
    if (-not [string]::IsNullOrWhiteSpace($ownerStepValue)) {
      try {
        $parsedFromField = [int]($ownerStepValue -replace '[^0-9]', '')
        if ($parsedFromField -gt 0) {
          $result.Add($parsedFromField)
          return @($result.ToArray())
        }
      }
      catch {}
    }

    # Fall back to phase string. Parse a range like "Step10-13" into [10, 11, 12, 13].
    # Try ownerPhase first; if it contains no step number, also try materializationPhase.
    # This is needed when ownerPhase is a human-readable name like "Backend - Modernization Formation"
    # while materializationPhase holds the explicit step notation like "Step 7 then carry-forward...".
    $phaseCandidate = ''
    if ($Case.PSObject.Properties.Name -contains 'ownerPhase') { $phaseCandidate = [string]$Case.ownerPhase }
    $matPhaseCandidate = ''
    if ($Case.PSObject.Properties.Name -contains 'materializationPhase') { $matPhaseCandidate = [string]$Case.materializationPhase }

    # Helper closure to try resolving step numbers from a given phase string.
    # Returns a non-empty list when it finds step numbers; empty list otherwise.
    function TryResolveFromPhase([string]$ph) {
      $r = New-Object System.Collections.Generic.List[int]
      $rm = [regex]::Match($ph, '(?i)Step\s*(\d+)\s*[-]+\s*(\d+)')
      if ($rm.Success) {
        try {
          $s1 = [int]$rm.Groups[1].Value; $s2 = [int]$rm.Groups[2].Value
          for ($sv = $s1; $sv -le $s2; $sv++) { if ($sv -gt 0) { $r.Add($sv) } }
          if ($r.Count -gt 0) { return @($r.ToArray()) }
        } catch {}
      }
# ===========================================================================
# TRANSCRIPTION GAP -- NOT PART OF THE SOURCE FILE.
# Source lines 354-398 (45 lines) are not covered by any photo in this batch:
# photo 06-23e594b2 ends at source line 353 and photo 07-4c3ec0a1 begins at
# source line 399. The missing region is inside Get-StepSemanticReadinessFindings
# and, judging from what lines 399+ reference, contains at least:
#   - the remainder of the TryResolveFromPhase helper (single "Step N" match
#     fallback and closing braces) and the tail of Resolve-CaseOwnerStepNumbers
#     (calls of TryResolveFromPhase on ownerPhase / materializationPhase and
#     the final return),
#   - the Test-CaseIsUnitType helper referenced at lines 425 and 448,
#   - the loading of $catalogCases (via Get-CatalogCaseSet) referenced at
#     lines 408 and 447,
#   - whatever block the closing brace on line 399 terminates.
# These lines are NOT reconstructed here; inventing them would violate the
# verbatim transcription rules for this import. This placeholder block is
# exactly 45 lines (354-398) so every later line keeps its true source line
# number. NOTE: braces opened in the missing region are not closed by this
# block, so the file does not parse as-is; re-photograph source lines
# 354-398 and replace this block to complete the import.
# ===========================================================================
# (untranscribed source line 375)
# (untranscribed source line 376)
# (untranscribed source line 377)
# (untranscribed source line 378)
# (untranscribed source line 379)
# (untranscribed source line 380)
# (untranscribed source line 381)
# (untranscribed source line 382)
# (untranscribed source line 383)
# (untranscribed source line 384)
# (untranscribed source line 385)
# (untranscribed source line 386)
# (untranscribed source line 387)
# (untranscribed source line 388)
# (untranscribed source line 389)
# (untranscribed source line 390)
# (untranscribed source line 391)
# (untranscribed source line 392)
# (untranscribed source line 393)
# (untranscribed source line 394)
# (untranscribed source line 395)
# (untranscribed source line 396)
# (untranscribed source line 397)
# ===========================================================================
  }

  if ($Step -eq 6) {
    $downstreamSteps = 7..18
    $rowsByStep = @{}
    foreach ($downstreamStep in $downstreamSteps) {
      $rowsByStep[$downstreamStep] = New-Object System.Collections.Generic.List[object]
    }

    foreach ($case in $catalogCases) {
      # Use the plural resolver so phase ranges like "Step10-13" credit all steps 10, 11, 12, 13.
      $ownerStepNumbersList = Resolve-CaseOwnerStepNumbers -Case $case
      foreach ($ownerStepNumber in $ownerStepNumbersList) {
        if (-not $rowsByStep.ContainsKey($ownerStepNumber)) { continue }
        $rowsByStep[$ownerStepNumber].Add($case) | Out-Null
      }
    }

    foreach ($downstreamStep in $downstreamSteps) {
      # Note: $rowsByStep values are Generic.List[object]. Do NOT wrap in @() - that throws
      # "Argument types do not match" in PowerShell 5.1. Use .Count directly instead.
      if ($rowsByStep[$downstreamStep].Count -eq 0) {
        Add-ReadinessFinding -Message ("Step 6 does not have any catalog rows for downstream Step {0}." -f $downstreamStep) -Remediation ("Add the missing Step {0} planning rows to the executable testcase catalog, then re-run Step 6 so the later step has something real to materialize." -f $downstreamStep)
      }
    }

    $step8UnitRows = @($rowsByStep[8] | Where-Object { Test-CaseIsUnitType -Case $_ })
    if ($step8UnitRows.Count -eq 0) {
      Add-ReadinessFinding -Message 'Step 6 does not provide any Step 8 unit-test rows.' -Remediation 'Add the backend unit-test rows Step 8 is supposed to create, then re-run Step 6 so the formation step has a real unit-growth target instead of a placeholder catalog.'
    }

    if (Test-Path -LiteralPath $workflowStatePath) {
      try {
        $workflow = Get-Content -LiteralPath $workflowStatePath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        if ($workflow.PSObject.Properties.Name -contains 'stepResponses' -and $workflow.stepResponses -and $workflow.stepResponses.PSObject.Properties.Name -contains 'steps') {
          $step8Entry = @($workflow.stepResponses.steps | Where-Object { [int]$_.step -eq 8 } | Select-Object -First 1)
          if ($step8Entry.Count -gt 0 -and [string]$step8Entry[0].status -eq 'Blocked') {
            Add-ReadinessFinding -Message 'Step 8 is currently blocked in saved workflow state.' -Remediation 'Refresh the Step 6 planning pack so it names the actual backend work and the tests Step 8 is expected to create, then re-run the blocked step gates.'
          }
        }
      }
      catch {
        Add-ReadinessFinding -Message ('Step 8 readiness check could not read workflow state: {0}' -f $_.Exception.Message) -Remediation 'Repair the workflow state JSON and re-run the semantic gate.'
      }
    }
  }

  if ($Step -eq 8) {
    $step8UnitRows = @($catalogCases | Where-Object {
      (Resolve-CaseOwnerStepNumber -Case $_) -eq 8 -and (Test-CaseIsUnitType -Case $_)
    })
    if ($step8UnitRows.Count -eq 0) {
      Add-ReadinessFinding -Message 'The unit-test plan did not include any Step 8 planning rows.' -Remediation 'Refresh Step 6 so the catalog names the backend tests Step 8 is supposed to create, then re-run the Step 8 gate.'
    }

    if ($VerificationMode -eq 'Output' -or $VerificationMode -eq 'Both') {
      $phaseAssessmentPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/Modernization-Phase-Assessment.md'
      $backendFormationReportPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/Backend-Modernization-Formation-Report.md'
      $step8Disposition = ''

      if (Test-Path -LiteralPath $phaseAssessmentPath) {
        try {
          $phaseAssessment = Get-Content -LiteralPath $phaseAssessmentPath -Raw -ErrorAction Stop
          $dispositionTableMatch = [regex]::Match($phaseAssessment, '(?im)^\|\s*Step\s*8\s*Backend\s*Modernization\s*Formation\s*\|\s*([^|]+)\|')
          if ($dispositionTableMatch.Success) {
            $step8Disposition = [string]$dispositionTableMatch.Groups[1].Value.Trim()
          }
          if ([string]::IsNullOrWhiteSpace($step8Disposition)) {
            $dispositionLineMatch = [regex]::Match($phaseAssessment, '(?im)^\-\s*Step\s*8\s*disposition\s*is\s*explicitly\s*([^\.\r\n]+)')
            if ($dispositionLineMatch.Success) {
              $step8Disposition = [string]$dispositionLineMatch.Groups[1].Value.Trim()
            }
          }
        }
        catch {
          Add-ReadinessFinding -Message ('Step 8 semantic gate could not read the phase assessment report: {0}' -f $_.Exception.Message) -Remediation 'Repair or regenerate Modernization-Phase-Assessment.md so the Step 8 disposition can be enforced.'
        }
      }

      if (Test-Path -LiteralPath $backendFormationReportPath) {
        try {
          $backendFormationReport = Get-Content -LiteralPath $backendFormationReportPath -Raw -ErrorAction Stop
          $libraryStatus = [string]([regex]::Match($backendFormationReport, '(?im)^\-\s*libraryFormationStatus:\s*(.+)$').Groups[1].Value.Trim())
          $apiStatus = [string]([regex]::Match($backendFormationReport, '(?im)^\-\s*apiFormationStatus:\s*(.+)$').Groups[1].Value.Trim())
          $handoffStatus = [string]([regex]::Match($backendFormationReport, '(?im)^\-\s*step9HandoffStatus:\s*(.+)$').Groups[1].Value.Trim())
          $movementSummary = [string]([regex]::Match($backendFormationReport, '(?im)^\-\s*Move\-not\-copy\s*or\s*create\-validate\-delete\s*actions\s*executed\s*in\s*this\s*pass:\s*(.+)$').Groups[1].Value.Trim())

          $blockersSectionMatch = [regex]::Match($backendFormationReport, '(?is)##\s*Blockers\s*(?<body>.*?)(?:\r?\n##\s|\z)')
          $blockerLines = @()
          if ($blockersSectionMatch.Success) {
            $blockerLines = @([regex]::Matches([string]$blockersSectionMatch.Groups['body'].Value, '(?im)^\-\s+(.+)$') | ForEach-Object { [string]$_.Groups[1].Value.Trim() })
          }
          $hasConcreteBlockers = @($blockerLines | Where-Object {
            -not [string]::IsNullOrWhiteSpace($_) -and
            $_ -notmatch '^(?i)(none|n/a|no\s+blockers?)$'
          }).Count -gt 0

          $unitProjectPath = Join-Path $RepoRoot ('tests/backend/unit/{0}.Library.Tests/{0}.Library.Tests.csproj' -f $app)
          $hasUnitProject = Test-Path -LiteralPath $unitProjectPath

          if ($libraryStatus -ne 'Validated' -or $apiStatus -ne 'Validated') {
            Add-ReadinessFinding -Message 'Step 8 output is not semantically complete: library/api formation status is not fully Validated.' -Remediation 'Finish backend formation in order (Library then Web.Api), rerun proofs, and update Backend-Modernization-Formation-Report.md with Validated statuses.'
          }

          if ($handoffStatus -ne 'ReadyForHardening') {
            Add-ReadinessFinding -Message ('Step 8 cannot close while step9HandoffStatus is {0}.' -f $(if ([string]::IsNullOrWhiteSpace($handoffStatus)) { '<missing>' } else { $handoffStatus })) -Remediation 'Complete remaining Step 8 backend move and test obligations, then set step9HandoffStatus to ReadyForHardening only when all closeout gates are green.'
          }

          if (-not $hasUnitProject) {
            Add-ReadinessFinding -Message ('Step 8 requires an executable unit lane project at {0}, but it is missing.' -f ($unitProjectPath.Replace($RepoRoot + [System.IO.Path]::DirectorySeparatorChar, '').Replace('\', '/'))) -Remediation 'Materialize the backend unit test project and mapped catalog tests under tests/backend/unit/<AppName>.Library.Tests, then rerun dotnet test and refresh the Step 8 report.'
          }

          if ($hasConcreteBlockers) {
            Add-ReadinessFinding -Message 'Step 8 report still lists concrete blockers in the Blockers section.' -Remediation 'Resolve the listed blockers or truthfully keep Step 8 open; do not close Step 8 while blocker rows remain.'
          }

          if ([string]$step8Disposition -match '^(?i)Execute$' -and [string]$movementSummary -match '^(?i)none$' -and -not $hasConcreteBlockers) {
            Add-ReadinessFinding -Message 'Step 8 disposition is Execute, but the report says no move/create-validate-delete actions were executed and no blockers are recorded.' -Remediation 'Run the planned Step 8 backend extraction slices from the upgrade workspace into src/ (Library first, Web.Api second), validate them, and update movement accounting before closing the step.'
          }
        }
        catch {
          Add-ReadinessFinding -Message ('Step 8 semantic gate could not parse Backend-Modernization-Formation-Report.md: {0}' -f $_.Exception.Message) -Remediation 'Repair the Step 8 report format and rerun Step 8 closeout verification.'
        }
      }
      else {
        Add-ReadinessFinding -Message 'Step 8 semantic gate requires Backend-Modernization-Formation-Report.md, but it is missing.' -Remediation 'Generate the Step 8 backend formation report with ordered formation status, movement accounting, blockers, and handoff readiness fields.'
      }
    }
  }

  if ($Step -eq 9) {
    if (Test-Path -LiteralPath $workflowStatePath) {
      try {
        $workflow = Get-Content -LiteralPath $workflowStatePath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        if ($workflow.PSObject.Properties.Name -contains 'stepResponses' -and $workflow.stepResponses -and $workflow.stepResponses.PSObject.Properties.Name -contains 'steps') {
          $step8Entry = @($workflow.stepResponses.steps | Where-Object { [int]$_.step -eq 8 } | Select-Object -First 1)
          if ($step8Entry.Count -gt 0 -and [string]$step8Entry[0].status -ne 'Completed') {
            Add-ReadinessFinding -Message 'Step 8 is not completed yet.' -Remediation 'Finish the backend formation step before trying to harden it.'
          }
        }
      }
      catch {
        Add-ReadinessFinding -Message ('Step 9 readiness check could not read workflow state: {0}' -f $_.Exception.Message) -Remediation 'Repair the workflow state JSON and re-run the semantic gate.'
      }
    }
  }

  if (($Step -eq 11 -or $Step -eq 12) -and ($VerificationMode -eq 'Output' -or $VerificationMode -eq 'Both')) {
    # UI control-parity + deferral-drain closeout gate. Enforces the parity verdict and the
    # deferral registry MECHANICALLY at step closeout (previously these lived only in prompt
    # prose the agent was asked to honor). The gate fires only when the parity scan artifact
    # already exists, so a modality-exempt run (no managed browser surface) is never falsely
    # blocked - the artifact contract owns presence, this branch owns the verdict.
    $parityScanPath = ''
    foreach ($cand in @(
        '.modernization/ignition-artifacts/discovery/ui-parity-gap-scan.json',
        '.modernization/legacy-analysis/ui-parity-gap-scan.json')) {
      $p = Join-Path $RepoRoot $cand
      if (Test-Path -LiteralPath $p) { $parityScanPath = $p; break }
    }
    if (-not [string]::IsNullOrWhiteSpace($parityScanPath)) {
      try {
        $parity = Get-Content -LiteralPath $parityScanPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $majorGaps = if ($parity.PSObject.Properties.Name -contains 'majorGaps') { [int]$parity.majorGaps } else { 0 }
        $criticalGaps = if ($parity.PSObject.Properties.Name -contains 'criticalGaps') { [int]$parity.criticalGaps } else { 0 }
        if ($criticalGaps -gt 0 -or $majorGaps -gt 0) {
          Add-ReadinessFinding -Message ("Step {0} cannot close: the UI control parity scan reports {1} critical and {2} major gap(s) - missing controls, dropped columns, or inert handlers - against the legacy answer key." -f $Step, $criticalGaps, $majorGaps) -Remediation 'Wire or restore the flagged controls/columns and re-run .github/scripts/parity/scan-ui-parity-gaps.ps1 until majorGaps=0 and criticalGaps=0, or record each remaining gap as an owned waiver. A build or an HTTP 200 is not a substitute.'
        }
        # Deferral-drain gate: any suppressed deferral whose owner step has been reached or
        # passed (ownerStep <= this step) is overdue and must be wired before the step closes.
        $undrained = New-Object System.Collections.Generic.List[string]
        if (($parity.PSObject.Properties.Name -contains 'deferredInertControls') -and $parity.deferredInertControls) {
          foreach ($d in @($parity.deferredInertControls)) {
            if ($null -eq $d) { continue }
            $ownerStep = if (($d.PSObject.Properties.Name -contains 'ownerStep') -and ($null -ne $d.ownerStep)) { [int]$d.ownerStep } else { 0 }
            if ($ownerStep -gt 0 -and $ownerStep -le $Step) {
              $handlerName = if ($d.PSObject.Properties.Name -contains 'handler') { [string]$d.handler } else { '(unnamed)' }
              $undrained.Add($handlerName) | Out-Null
            }
          }
        }
        if ($undrained.Count -gt 0) {
          Add-ReadinessFinding -Message ("Step {0} cannot close: {1} deferred stub handler(s) owned by Step {0} or earlier are still un-drained ({2})." -f $Step, $undrained.Count, ($undrained.ToArray() -join ', ')) -Remediation ("Wire each handler to its real behavior; or, only if it genuinely belongs to a later step whose gate verifies that behavior, re-point its ownerStep in .modernization/ignition-artifacts/discovery/ui-deferral-registry.json with a written reason. Then re-run scan-ui-parity-gaps.ps1 -CurrentStep {0}." -f $Step)
        }
      }
      catch {
        Add-ReadinessFinding -Message ("Step {0} parity gate could not read the UI parity scan: {1}" -f $Step, $_.Exception.Message) -Remediation 'Regenerate it by running .github/scripts/parity/scan-ui-parity-gaps.ps1 from the repo root, then re-run the step gate.'
      }
    }

    # Runtime parity checkpoint: block ONLY on an explicitly recorded fail. An honest
    # blocked / UnverifiedPendingAuth state legitimately keeps the step open elsewhere and
    # must not be double-punished here.
    foreach ($rcRel in @(
        '.modernization/ignition-artifacts/modernize/fusion-restructure/runtime-parity-checkpoint.json',
        '.modernization/fusion-restructure/runtime-parity-checkpoint.json')) {
      $rcPath = Join-Path $RepoRoot $rcRel
      if (Test-Path -LiteralPath $rcPath) {
        try {
          $rc = Get-Content -LiteralPath $rcPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
          $overall = if ($rc.PSObject.Properties.Name -contains 'overall') { [string]$rc.overall } else { '' }
          if ($overall -match '(?i)^fail') {
            Add-ReadinessFinding -Message ("Step {0} cannot close: runtime-parity-checkpoint.json records overall='{1}' - a recorded runtime fail (missing/hidden control, control-type mismatch, column collapse, inert handler, or data-binding fault) is closure-blocking." -f $Step, $overall) -Remediation 'Fix the failing route behavior against the running legacy and re-run the runtime parity checkpoint until overall=pass, or record each gap as an owned waiver.'
          }
        }
        catch {
          Write-Verbose ("Step {0} runtime-checkpoint read issue: {1}" -f $Step, $_.Exception.Message)
        }
        break
      }
    }

    # Behavioral-parity checkpoint: block only on an explicitly recorded overall=fail.
    # Emitted by behavioral-parity.journey.spec.ts when E2E_BEHAVIORAL_PARITY_ENABLED=1.
    # When the spec hasn't run yet (no file) this gate is skipped, not blocked — the spec
    # is an opt-in runtime proof, not a mandatory artifact. An overall=fail means at least
    # one registered interactive element produced no behavioral effect at runtime: filter
    # did not filter, dropdown had no options, command triggered nothing, or grid was empty.
    $behavioralCheckpointPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/behavioral-parity-checkpoint.json'
    if (Test-Path -LiteralPath $behavioralCheckpointPath) {
      try {
        $bc = Get-Content -LiteralPath $behavioralCheckpointPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $bcOverall = if ($bc.PSObject.Properties.Name -contains 'overall') { [string]$bc.overall } else { '' }
        if ($bcOverall -match '(?i)^fail') {
          $bcFail = if ($bc.PSObject.Properties.Name -contains 'fail') { [int]$bc.fail } else { 0 }
          Add-ReadinessFinding -Message ("Step {0} cannot close: behavioral-parity-checkpoint.json records overall='{1}' ({2} behavioral assertion failure(s)). A runtime behavioral effect was promised by the behavior plan but not observed — filter did not change rows, dropdown had no options, command triggered no effect, or grid showed no real rows. This is the failure mode static gates cannot see." -f $Step, $bcOverall, $bcFail) -Remediation 'Fix the failing behavioral binding and re-run the behavioral-parity spec (E2E_BEHAVIORAL_PARITY_ENABLED=1) until overall=pass. See tests/frontend/e2e/journeys/behavioral-parity.journey.spec.ts.'
        }
      }
      catch {
        Write-Verbose ("Step {0} behavioral-checkpoint read issue: {1}" -f $Step, $_.Exception.Message)
      }
    }

    # Scaffold-debt drain gate: surviving deferral markers ("Step N wires ...", "wired in a
    # later step", placeholder bodies) whose owning step has been reached must not ship. This
    # is the class that let a from-memory scaffold pass with its behavior announced-but-unwired
    # in comments no gate ever scanned. Fires only when the scaffold-debt scan artifact exists.
    $scaffoldScanPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/scaffold-debt-scan.json'
    if (Test-Path -LiteralPath $scaffoldScanPath) {
      try {
        $debt = Get-Content -LiteralPath $scaffoldScanPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $overdueDebt = New-Object System.Collections.Generic.List[string]
        if (($debt.PSObject.Properties.Name -contains 'findings') -and $debt.findings) {
          foreach ($d in @($debt.findings)) {
            if ($null -eq $d) { continue }
            $sev = if ($d.PSObject.Properties.Name -contains 'severity') { [string]$d.severity } else { '' }
            if ($sev -eq 'accepted') { continue }
            $impliedStep = if (($d.PSObject.Properties.Name -contains 'impliedStep') -and ($null -ne $d.impliedStep)) { [int]$d.impliedStep } else { 0 }
            if ($impliedStep -gt 0 -and $impliedStep -le $Step) {
              $overdueDebt.Add(("{0}:{1}" -f ([string]$d.file), ([string]$d.line))) | Out-Null
            }
          }
        }
        if ($overdueDebt.Count -gt 0) {
          $sample = (($overdueDebt | Select-Object -First 5) -join ', ')
          Add-ReadinessFinding -Message ("Step {0} cannot close: {1} scaffold-debt marker(s) owned by Step {0} or earlier still survive in src (e.g. {2}). A 'Step N wires this' / 'wired in a later step' note that outlives its step means the behavior was announced but not finished, or a stale scaffold note was never cleaned." -f $Step, $overdueDebt.Count, $sample) -Remediation 'Finish the announced behavior against the legacy answer key and remove the now-inaccurate scaffold marker; or, only if the note is genuinely intentional, accept it in .modernization/ignition-artifacts/discovery/scaffold-debt-registry.json with a reason. Then re-run scan-scaffold-debt.ps1 -CurrentStep <n>.'
        }
      }
      catch {
        Add-ReadinessFinding -Message ("Step {0} scaffold-debt gate could not read the scan: {1}" -f $Step, $_.Exception.Message) -Remediation 'Regenerate it by running .github/scripts/parity/scan-scaffold-debt.ps1 from the repo root, then re-run the step gate.'
      }
    }
  }

  if (($Step -eq 9 -or $Step -eq 12) -and ($VerificationMode -eq 'Output' -or $VerificationMode -eq 'Both')) {
    # Legacy-anchored backend functionality-parity gate. Every OTHER gate verifies "what EXISTS
    # in modern is wired"; none verified "everything in LEGACY was carried over". That let a
    # modernization port only the READ path (GET) and silently drop the entire WRITE path
    # (POST/PUT/DELETE - Add/Edit/Delete/Link/Export), while the UI still showed the buttons
    # (opening placeholder modals) so the UI parity + UI->API wiring gates both reported green.
    # This gate blocks closure when a legacy MUTATION endpoint has no modern counterpart and no
    # accepted waiver. Fires only when the scan artifact exists (run scan-backend-parity.ps1).
    $backendScanPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/backend-parity-scan.json'
    if (Test-Path -LiteralPath $backendScanPath) {
      try {
        $bp = Get-Content -LiteralPath $backendScanPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $missingMut = if ($bp.PSObject.Properties.Name -contains 'missingMutationCount') { [int]$bp.missingMutationCount } else { 0 }
        if ($missingMut -gt 0) {
          $sample = ''
          if (($bp.PSObject.Properties.Name -contains 'gaps') -and $bp.gaps) {
            $sample = (@($bp.gaps | Where-Object { $_.severity -eq 'Major' } | ForEach-Object { "{0} {1}Controller.{2}" -f $_.verb, $_.controller, $_.method } | Select-Object -First 6) -join '; ')
          }
          Add-ReadinessFinding -Message ("Step {0} cannot close: {1} legacy mutation endpoint(s) (POST/PUT/DELETE/PATCH) have NO modern counterpart - dropped WRITE functionality the legacy app shipped (e.g. {2}). A modernization that ports only the read path while the UI still shows Add/Edit/Delete buttons over placeholder modals is a functionality-parity failure, not a complete modernization." -f $Step, $missingMut, $sample) -Remediation 'Port the missing legacy mutation endpoints into the modern API (with modern architecture + auth) and wire their UI actions; or, only for genuinely out-of-scope operations, record each in .modernization/ignition-artifacts/discovery/backend-parity-registry.json (acceptedDrops[] with a written reason). Then re-run .github/scripts/parity/scan-backend-parity.ps1.'
        }
      }
      catch {
        Add-ReadinessFinding -Message ("Step {0} backend-parity gate could not read the scan: {1}" -f $Step, $_.Exception.Message) -Remediation 'Regenerate it by running .github/scripts/parity/scan-backend-parity.ps1 from the repo root, then re-run the step gate.'
      }
    }

    # Legacy-anchored API DTO field coverage gate. A modern API DTO that maps fewer fields than
    # its legacy View counterpart means the API never returns those fields - grid column headers
    # render but cells show empty data silently (the exact failure where File Log showed Drawing No.
    # only while File Type, Title, Posting/Rev Date, File Name stayed blank because the SQL query
    # only fetched 3 of 10 columns). Fires only when the scan artifact exists (run scan-api-dto-coverage.ps1).
    $dtoCoveragePath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/api-dto-coverage-scan.json'
    if (Test-Path -LiteralPath $dtoCoveragePath) {
      try {
        $dc = Get-Content -LiteralPath $dtoCoveragePath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $dtoGaps = if ($dc.PSObject.Properties.Name -contains 'majorGaps') { [int]$dc.majorGaps } else { 0 }
        if ($dtoGaps -gt 0) {
          $sample = ''
          if (($dc.PSObject.Properties.Name -contains 'gaps') -and $dc.gaps) {
            $sample = (@($dc.gaps | ForEach-Object { "{0} missing '{1}'" -f $_.modernDto, $_.property } | Select-Object -First 5) -join '; ')
          }
          Add-ReadinessFinding -Message ("Step {0} cannot close: {1} modern API DTO(s) map fewer fields than their legacy View counterpart - the API never sends those fields so grid columns render headers but show empty cells silently (e.g. {2}). The column is declared in the frontend but the backend strips the data before it reaches the client." -f $Step, $dtoGaps, $sample) -Remediation 'Add the missing fields to the modern API DTO record, the domain entry model, and the SQL query; then update the controller mapping. For fields that are intentionally excluded (internal IDs, audit columns), record each in .modernization/ignition-artifacts/discovery/api-dto-coverage-registry.json (acceptedDrops[] with a reason). Re-run .github/scripts/parity/scan-api-dto-coverage.ps1.'
        }
      }
      catch {
        Add-ReadinessFinding -Message ("Step {0} API DTO coverage gate could not read the scan: {1}" -f $Step, $_.Exception.Message) -Remediation 'Regenerate it by running .github/scripts/parity/scan-api-dto-coverage.ps1 from the repo root, then re-run the step gate.'
      }
    }

    # Functional Parity Ledger gate (Steps 9 and 12). The ledger scanner cross-references the
    # Step 3 interaction-wiring-inventory (every legacy control with its effectClass) against
    # modern src/ to compute which behaviors are still unimplemented. A non-zero majorGaps count
    # means legacy mutate, read, or filter functionality was inventoried but never ported —
    # exactly the class of miss (Add/Edit/Delete, filter-has-no-effect) that shipped silently
    # through all prior steps before this gate existed.
    # Fires only when the scan artifact exists (run scan-functional-parity-ledger.ps1).
    $fplScanPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/functional-parity-ledger-scan.json'
    if (Test-Path -LiteralPath $fplScanPath) {
      try {
        $fpl = Get-Content -LiteralPath $fplScanPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
        $fplMajor = if ($fpl.PSObject.Properties.Name -contains 'majorGaps') { [int]$fpl.majorGaps } else { 0 }
        $fplHasSchema = if ($fpl.PSObject.Properties.Name -contains 'hasEffectClassSchema') { [bool]$fpl.hasEffectClassSchema } else { $false }
        if (-not $fplHasSchema) {
          Add-ReadinessFinding -Message ("Step {0} functional parity ledger gate: the ledger was not generated with the Phase 1 effectClass schema. All controls appear as ui-only so mutate/filter/read gaps are invisible. Re-run Step 3 to regenerate the inventory, then re-run scan-functional-parity-ledger.ps1." -f $Step) -Remediation 'Re-run 03-P1-generate-manifest.ps1 then scan-functional-parity-ledger.ps1 from the repo root.'
        } elseif ($fplMajor -gt 0) {
          $detail = ''
          if ($fpl.PSObject.Properties.Name -contains 'byEffectClass') {
            $ec = $fpl.byEffectClass
            $parts = @()
            foreach ($cls in @('mutate','read','filter')) {
              $s = if ($ec.PSObject.Properties.Name -contains $cls) { $ec.$cls } else { $null }
              if ($s -and [int]$s.unimplemented -gt 0) { $parts += ("{0}: {1} unimplemented" -f $cls, [int]$s.unimplemented) }
            }
            $detail = $parts -join ', '
          }
          Add-ReadinessFinding -Message ("Step {0} cannot close: Functional Parity Ledger reports {1} major gap(s) - legacy behaviors inventoried at Step 3 have no modern implementation ({2}). These are Add/Edit/Delete operations or filter/search behaviors that the legacy app had but src/ does not. The user sees missing buttons, dead filters, or identical data in sibling lists." -f $Step, $fplMajor, $detail) -Remediation 'Port the missing functionality: implement the unimplemented mutate endpoints and wire their UI forms, fix filter handlers so they call real query endpoints, and re-run scan-functional-parity-ledger.ps1. For genuinely out-of-scope behaviors, record each in functional-parity-registry.json (acceptedDrops[] with a written reason and owning step).'
        }
      }
      catch {
        Add-ReadinessFinding -Message ("Step {0} functional parity ledger gate could not read the scan: {1}" -f $Step, $_.Exception.Message) -Remediation 'Regenerate it by running .github/scripts/parity/scan-functional-parity-ledger.ps1 from the repo root, then re-run the step gate.'
      }
    }
  }

  $findings = @($script:semanticFindingBuffer)
  $script:semanticFindingBuffer = @()
  # Return findings individually so @() in the caller collects PSCustomObjects, not a wrapped array.
  # Do NOT use 'return ,$findings' - that wraps in an extra layer causing IsBlocker lookup to fail.
  return $findings
}

function Write-SchemaResult {
  # Print the per-artifact content-validation outcome beneath its status line.
  param([Parameter(Mandatory = $true)] $Result)
  switch ($Result.SchemaStatus) {
    'Invalid' {
      Write-Host "        schema: INVALID" -ForegroundColor Red
      foreach ($v in @($Result.Violations)) { Write-Host ("          - {0}" -f $v) -ForegroundColor Red }
    }
    'SchemaError' {
      Write-Host ("        schema: ERROR (validation skipped) - {0}" -f (@($Result.Violations) -join '; ')) -ForegroundColor DarkYellow
    }
    'Valid' {
      Write-Host "        schema: valid" -ForegroundColor DarkGreen
    }
    default { }
  }
}

function Write-SemanticReadinessResult {
  param([Parameter(Mandatory = $true)] $Finding)

  Write-Host "        semantic: BLOCKED" -ForegroundColor Red
  Write-Host ("          - {0}" -f $Finding.Message) -ForegroundColor Red
  Write-Host ("          fix: {0}" -f $Finding.Remediation) -ForegroundColor DarkYellow
}

function Get-BlockerFriendlyMessage {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [Parameter(Mandatory = $true)][string]$Gate,
    [Parameter(Mandatory = $true)][string]$Status,
    [Parameter(Mandatory = $true)][string]$SchemaStatus,
    [Parameter(Mandatory = $true)][int]$Step
  )

  if ($Step -eq 6 -and $Path -like '*.modernization/portal/data/json/qa-test-plan.json') {
    return 'Step 6 needs to spell out the tests and screenshots later steps depend on, not just list the files that exist. If those planning details are missing, Step 8 cannot know what backend unit tests to create or what screenshots to refresh.'
  }

  if ($Step -eq 6 -and $Path -like '*.modernization/portal/data/json/executable-testcase-catalog.json') {
    return 'Step 6 needs a catalog that names the actual tests the next steps will run. If the catalog only says the artifact exists, Step 8 and Step 9 still do not know what to build.'
  }

  if ($Step -eq 8 -and $Path -like '*.modernization/portal/data/json/executable-testcase-catalog.json') {
    return 'Step 8 depends on the planning pack naming the backend unit tests it must create. If the plan does not include those tests, Step 8 cannot finish backend formation cleanly.'
  }

  if ($Step -eq 8 -and $Path -like '*.modernization/ignition-artifacts/Modernization-Phase-Assessment.md') {
    return 'Step 8 needs the phase assessment to tell it whether backend formation is allowed and what downstream readiness is still open. If the assessment is stale or blocked, Step 8 should stop before doing backend moves.'
  }

  if ($Step -eq 9 -and $Path -like '*.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json') {
    return 'Step 9 depends on the control-point inventory to know how auth, config, logging, and protected endpoints must behave. If that inventory is incomplete, hardening would guess at platform behavior.'
  }

  if ($Step -eq 10 -and $Path -like '*.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json') {
    return 'Step 10 needs the backend and browser decisions to know what the front-end shell should connect to. If those decisions are missing or stale, the modern client scaffold cannot be trusted.'
  }

  return ''
}

$root = Resolve-RepoRoot -Override $RepoRoot
$app = Get-AppName -RepoRoot $root -Override $AppName
$contractPath = Join-Path $root '.github/instructions/AppMod-Artifact-Contract.json'
if (-not (Test-Path -LiteralPath $contractPath)) {
  Write-Error "Artifact contract not found at $contractPath"
  exit 2
}

$contract = Get-Content -LiteralPath $contractPath -Raw | ConvertFrom-Json
$stepEntry = $contract.steps | Where-Object { $_.step -eq $Step } | Select-Object -First 1
if (-not $stepEntry) {
  Write-Error "Step $Step not found in artifact contract."
  exit 2
}

# Build a path -> schema map from EVERY entry in the contract. A schema is an intrinsic
# property of the artifact path, so the same file is validated wherever it is checked
# (any step, as an input or an output), even though the schema is declared on just one
# entry (normally the producer's output). A per-entry 'schema' still wins when present.
$schemaByPath = @{}
foreach ($s in $contract.steps) {
  foreach ($coll in @($s.requiredInputs, $s.producedOutputs)) {
    foreach ($e in @($coll)) {
      if ($null -eq $e) { continue }
      if (($e.PSObject.Properties['schema']) -and ($e.PSObject.Properties['path'])) {
        $p = [string]$e.path
        $sc = [string]$e.schema
        if (-not [string]::IsNullOrWhiteSpace($p) -and -not [string]::IsNullOrWhiteSpace($sc) -and -not $schemaByPath.ContainsKey($p)) {
          $schemaByPath[$p] = $sc
        }
      }
    }
  }
}

# Optional No-QA safety net: materialize generic control-plane skeletons before checking inputs.
$ensured = @()
if ($EnsureControlPlane) {
  foreach ($cp in @('modernization-execution-contract.json', 'modernization-phase-assessment.json', 'modernization-solution-design.json')) {
    if (New-ControlPlaneSkeleton -RepoRoot $root -AppName $app -FileName $cp) { $ensured += $cp }
  }
}

$results = New-Object System.Collections.Generic.List[object]
$hasBlocker = $false

function Add-Checks {
  param([object[]]$Entries, [string]$Kind)
  foreach ($entry in $Entries) {
    if ($null -eq $entry) { continue }
    $doVerify = $true
    if ($entry.PSObject.Properties.Name -contains 'verify' -and $entry.verify -eq $false) { $doVerify = $false }
    $rel = [string]$entry.path
    $resolvedRel = $rel.Replace('<AppName>', $app)
    $full = Join-Path $root $resolvedRel
    $status = if ($doVerify) { Test-ArtifactPresent -FullPath $full } else { 'Skipped' }

    $gate = if ($entry.PSObject.Properties.Name -contains 'gate') { [string]$entry.gate } else { '' }
    $producer = if ($entry.PSObject.Properties.Name -contains 'producer') { [string]$entry.producer } else { '' }
    $selfHeal = if ($entry.PSObject.Properties.Name -contains 'selfHeal') { [string]$entry.selfHeal } else { '' }
    # Resolve the schema: explicit per-entry 'schema' wins; otherwise inherit by raw path
    # so this artifact is validated consistently wherever the contract references it.
    $schemaRel = if ($entry.PSObject.Properties.Name -contains 'schema') { [string]$entry.schema } elseif ($schemaByPath.ContainsKey($rel)) { [string]$schemaByPath[$rel] } else { '' }

    # Content validation runs only when the artifact is actually present and declares a schema.
    #   None        - no schema declared, or nothing present to validate.
    #   Valid       - artifact satisfies its field contract.
    #   Invalid     - artifact is present but violates its field contract (a content defect).
    #   SchemaError - the contract itself could not be loaded (a kit-authoring problem).
    $schemaStatus = 'None'
    $violations = @()
    if ($doVerify -and $status -eq 'Present' -and -not [string]::IsNullOrWhiteSpace($schemaRel)) {
      $schemaFull = Join-Path $root $schemaRel
      $check = Test-JsonFileAgainstContract -JsonPath $full -ContractPath $schemaFull
      if (-not [string]::IsNullOrWhiteSpace($check.Error)) {
        $schemaStatus = 'SchemaError'
        $violations = @($check.Error)
      }
      elseif ($check.Ok) {
        $schemaStatus = 'Valid'
      }
      else {
        $schemaStatus = 'Invalid'
        $violations = @($check.Violations)
      }
    }

    # A required artifact blocks when it is absent (Missing/Hollow) OR present-but-invalid.
    # Inputs only block on the hardStop gate; every produced output blocks. A SchemaError is a
    # loud warning, never a hard block, so a registry mistake cannot halt a developer mid-run.
    $isBlocker = $false
    if ($doVerify) {
      $presenceBad = ($status -eq 'Missing' -or $status -eq 'Hollow')
      $contentBad = ($schemaStatus -eq 'Invalid')
      if ($Kind -eq 'Input') {
        if ($gate -eq 'hardStop' -and ($presenceBad -or $contentBad)) { $isBlocker = $true }
      }
      else {
        if ($presenceBad -or $contentBad) { $isBlocker = $true }
      }
    }
    if ($isBlocker) { $script:hasBlocker = $true }

    $results.Add([pscustomobject]@{
        Kind         = $Kind
        Path         = $resolvedRel
        Status       = $status
        Gate         = $gate
        Producer     = $producer
        Blocker      = $isBlocker
        SelfHeal     = $selfHeal
        SchemaStatus = $schemaStatus
        Violations   = $violations
      }) | Out-Null
  }

  $semanticFindings = @()
  if ($Kind -eq 'Output' -or $Kind -eq 'Both') {
    $semanticFindings = @(Get-StepSemanticReadinessFindings -Step $Step -RepoRoot $root -VerificationMode $Mode)
    foreach ($finding in $semanticFindings) {
      if ($null -eq $finding) { continue }
      if ([bool]$finding.IsBlocker) { $script:hasBlocker = $true }
      $results.Add([pscustomobject]@{
          Kind         = 'Semantic'
          Path         = ('step-{0}-semantic-readiness' -f $Step)
          Status       = $(if ([bool]$finding.IsBlocker) { 'Blocked' } else { 'Ready' })
          Gate         = 'semantic'
          Producer     = 'shared-verifier'
          Blocker      = [bool]$finding.IsBlocker
          SelfHeal     = [string]$finding.Remediation
          SchemaStatus = 'None'
          Violations   = @($finding.Message)
        }) | Out-Null
    }
  }
}

if ($Mode -eq 'Input' -or $Mode -eq 'Both') {
  Add-Checks -Entries @($stepEntry.requiredInputs) -Kind 'Input'
}
if ($Mode -eq 'Output' -or $Mode -eq 'Both') {
  Add-Checks -Entries @($stepEntry.producedOutputs) -Kind 'Output'
}

if ($AsJson) {
  [pscustomobject]@{
    step      = $Step
    name      = $stepEntry.readableName
    appName   = $app
    mode      = $Mode
    ensured   = $ensured
    blocked   = $hasBlocker
    artifacts = $results
  } | ConvertTo-Json -Depth 8
  exit $(if ($hasBlocker) { 2 } else { 0 })
}

Write-Host ""
Write-Host ("Step {0} - {1}  (app: {2})" -f $Step, $stepEntry.readableName, $app) -ForegroundColor Cyan
if ($ensured.Count -gt 0) {
  Write-Host ("  Ensured control-plane skeletons: {0}" -f ($ensured -join ', ')) -ForegroundColor DarkYellow
}

$inputs = $results | Where-Object { $_.Kind -eq 'Input' }
$outputs = $results | Where-Object { $_.Kind -eq 'Output' }

if (($Mode -eq 'Input' -or $Mode -eq 'Both')) {
  Write-Host "  Required inputs (artifacts this step ingests):" -ForegroundColor Gray
  if (@($inputs).Count -eq 0) { Write-Host "    (none)" -ForegroundColor DarkGray }
  foreach ($r in $inputs) {
    $color = switch ($r.Status) { 'Present' { 'Green' } 'Skipped' { 'DarkGray' } default { if ($r.Blocker) { 'Red' } else { 'Yellow' } } }
    Write-Host ("    [{0}] {1} ({2})" -f $r.Status, $r.Path, $r.Gate) -ForegroundColor $color
    Write-SchemaResult -Result $r
    if ($r.Blocker -and -not [string]::IsNullOrWhiteSpace($r.SelfHeal)) {
      Write-Host ("        self-heal: {0}" -f $r.SelfHeal) -ForegroundColor DarkYellow
    }
  }
}

if (($Mode -eq 'Output' -or $Mode -eq 'Both')) {
  Write-Host "  Produced outputs (artifacts later steps consume):" -ForegroundColor Gray
  if (@($outputs).Count -eq 0) { Write-Host "    (none)" -ForegroundColor DarkGray }
  foreach ($r in $outputs) {
    $color = switch ($r.Status) { 'Present' { 'Green' } 'Skipped' { 'DarkGray' } default { 'Red' } }
    Write-Host ("    [{0}] {1} (producer: {2})" -f $r.Status, $r.Path, $r.Producer) -ForegroundColor $color
    Write-SchemaResult -Result $r
  }
  $semanticRows = $results | Where-Object { $_.Kind -eq 'Semantic' }
  foreach ($semantic in $semanticRows) {
    Write-Host ("    [{0}] {1} (producer: {2})" -f $semantic.Status, $semantic.Path, $semantic.Producer) -ForegroundColor $(if ($semantic.Blocker) { 'Red' } else { 'Green' })
    Write-SemanticReadinessResult -Finding ([pscustomobject]@{ Message = $semantic.Violations[0]; Remediation = $semantic.SelfHeal })
  }
}

Write-Host ""
if ($hasBlocker) {
  Write-Host "RESULT: BLOCKED - one or more required artifacts or semantic downstream checks failed (see above)." -ForegroundColor Red
  exit 2
}
Write-Host "RESULT: OK - all checked artifacts are present, non-empty, and semantically ready." -ForegroundColor Green
exit 0

