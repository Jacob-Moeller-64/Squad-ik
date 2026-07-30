# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 951-1017 (the tail) of verify-step-artifacts.ps1.
# The file is ~1017 content lines. Ranges 67-290, 354-609 and 670-950 are NOT
# transcribed. See verify-step-artifacts.PARTIAL.ps1 (1-66) and the
# FRAGMENT-291-353 / FRAGMENT-610-669 files.
# ===========================================================================

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
