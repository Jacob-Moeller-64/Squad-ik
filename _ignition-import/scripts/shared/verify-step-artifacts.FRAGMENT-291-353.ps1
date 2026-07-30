# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 291-353 of verify-step-artifacts.ps1. Lines 67-290 are NOT
# transcribed. Enclosing scopes per the editor breadcrumb:
#   function Get-StepSemanticReadinessFindings  begins at line 249
#   function Resolve-CaseOwnerStepNumber        begins at line 277
# See verify-step-artifacts.PARTIAL.ps1 for lines 1-66.
# ===========================================================================

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
