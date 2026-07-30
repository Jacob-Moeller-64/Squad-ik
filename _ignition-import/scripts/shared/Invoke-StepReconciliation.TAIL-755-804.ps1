# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 755-804 (the tail) of Invoke-StepReconciliation.ps1.
# The file is 803 content lines. Held separately: 68-273 and 337-754 are not
# transcribed. See Invoke-StepReconciliation.PARTIAL.ps1 (1-67) and
# Invoke-StepReconciliation.FRAGMENT-274-336.ps1.
# ===========================================================================

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
