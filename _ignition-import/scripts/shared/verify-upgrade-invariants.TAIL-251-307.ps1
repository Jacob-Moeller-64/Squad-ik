# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 251-307 (the tail) of verify-upgrade-invariants.ps1.
# The file is 306 content lines. Lines 67-250 are NOT transcribed.
# See verify-upgrade-invariants.PARTIAL.ps1 for lines 1-66.
# ===========================================================================

# --- Decide result ---------------------------------------------------------
$blocked = ($productSplits.Count -gt 0) -or ($shippedMismatches.Count -gt 0)
$result = if ($blocked) { 'BLOCKED' } else { 'OK' }

if ($AsJson) {
  [pscustomobject]@{
    result              = $result
    workspaceRoot       = $workspaceResolved
    publishDir          = $publishResolved
    productProjectCount = $productCount
    testProjectCount    = $testCount
    productSplits       = @($productSplits)
    testOnlyDifferences = @($testOnlyDifferences)
    shippedMismatches   = @($shippedMismatches)
  } | ConvertTo-Json -Depth 6
  if ($blocked) { exit 2 } else { exit 0 }
}

Write-Host "Single-version invariant"
Write-Host ("  Workspace: {0}" -f $workspaceResolved)
Write-Host ("  Scanned {0} project(s): {1} product, {2} test." -f $projectFiles.Count, $productCount, $testCount)

if ($productSplits.Count -gt 0) {
  Write-Host "  [SPLIT] One or more product packages are referenced at more than one version:"
  foreach ($split in $productSplits) {
    Write-Host ("    {0}: {1}" -f $split.Package, $split.Detail)
  }
}
else {
  Write-Host "  [OK] No product package is split across versions."
}

if ($testOnlyDifferences.Count -gt 0) {
  Write-Host "  Test-only version differences (non-blocking; carried forward per Step 7 policy):"
  foreach ($diff in $testOnlyDifferences) {
    Write-Host ("    {0}: {1}" -f $diff.Package, $diff.Versions)
  }
}

if (-not [string]::IsNullOrWhiteSpace($PublishDir)) {
  if ($null -eq $publishResolved) {
    Write-Host ("  [PublishDir] Not found, shipped-vs-compiled cross-check skipped: {0}" -f $PublishDir)
  }
  elseif ($shippedMismatches.Count -gt 0) {
    Write-Host "  [SHIPPED MISMATCH] A shipped assembly major does not match the compiled package major:"
    foreach ($mismatch in $shippedMismatches) {
      Write-Host ("    {0}: referenced {1}, shipped {2}" -f $mismatch.Package, $mismatch.ReferencedVersion, $mismatch.ShippedVersion)
    }
  }
  else {
    Write-Host "  [OK] Shipped assemblies match the compiled package majors."
  }
}

Write-Host ("RESULT: {0}" -f $result)
if ($blocked) { exit 2 } else { exit 0 }
