# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 274-336 of Invoke-StepReconciliation.ps1.
# Lines 68-273 are NOT transcribed, so this cannot be spliced into
# Invoke-StepReconciliation.PARTIAL.ps1 (which holds lines 1-67).
# The enclosing function Invoke-Recon-TestcaseFilesResolve begins at line 244.
# ===========================================================================

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
  if (-not (Test-Path -LiteralPath $planPath)) { return }   # presence owned by the verifier

  try {
    $plan = Get-Content -LiteralPath $planPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
  }
