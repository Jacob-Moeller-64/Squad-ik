# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 248-291 (the tail) of audit-step-number-drift.ps1.
# The file is 290 content lines. Lines 68-247 are NOT transcribed.
# See audit-step-number-drift.PARTIAL.ps1 for lines 1-67.
# ===========================================================================

  [pscustomobject]@{
    repoRoot       = $root
    filesScanned   = $targets.Count
    violationCount = $violations.Count
    violations     = $violations
    enumeration    = if ($IncludeEnumeration) { $enumeration } else { @() }
    blocked        = $hasViolations
  } | ConvertTo-Json -Depth 6
  exit $(if ($hasViolations) { 2 } else { 0 })
}

Write-Host ""
Write-Host ("Step-number drift audit  (scanned {0} files)" -f $targets.Count) -ForegroundColor Cyan

if ($violations.Count -eq 0) {
  Write-Host "  No deterministic drift violations found (Checks A, B, C clean)." -ForegroundColor Green
}
else {
  foreach ($grp in ($violations | Group-Object Check | Sort-Object Name)) {
    Write-Host ""
    Write-Host ("  [{0}]  {1} issue(s)" -f $grp.Name, $grp.Count) -ForegroundColor Yellow
    foreach ($v in $grp.Group) {
      Write-Host ("    {0}:{1}  {2}" -f $v.File, $v.Line, $v.Message) -ForegroundColor Red
    }
  }
}

if ($IncludeEnumeration) {
  $review = @($enumeration | Where-Object { $_.Tag -eq 'review' })
  Write-Host ""
  Write-Host ("  Enumeration: {0} total 'Step N' references; {1} carry no title and need human review." -f $enumeration.Count, $review.Count) -ForegroundColor Gray
  foreach ($r in $review) {
    Write-Host ("    review  {0}:{1}   Step {2}" -f $r.File, $r.Line, $r.Cited) -ForegroundColor DarkGray
  }
}

Write-Host ""
if ($hasViolations) {
  Write-Host ("RESULT: DRIFT FOUND - {0} deterministic violation(s). Fix from the list above." -f $violations.Count) -ForegroundColor Red
  exit 2
}
Write-Host "RESULT: OK - no deterministic step-number drift." -ForegroundColor Green
exit 0
