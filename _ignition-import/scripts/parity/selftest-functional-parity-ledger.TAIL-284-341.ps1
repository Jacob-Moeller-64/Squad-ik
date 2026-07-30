# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 284-341 (the tail) of selftest-functional-parity-ledger.ps1.
# Lines 122-283 are NOT transcribed, so this cannot be spliced into
# selftest-functional-parity-ledger.PARTIAL.ps1 (which holds lines 1-121).
# Line numbers within this fragment are as photographed; the case-block
# boundaries were read directly, individual assert lines are +/-1.
# ===========================================================================

# ---------------------------------------------------------------
# Case 3: Phase 1 schema + mutate entry + backend has 0 missing mutations -> PASS
# ---------------------------------------------------------------
Write-Host "  Case 3: Phase-1 schema, mutate entry, backend fully ported -> PASS" -ForegroundColor DarkCyan
$c3 = Invoke-LedgerCase -LedgerJson $mutateSchemaLedger -BackendScanJson $backendNoGaps -UiScanJson $uiNoPlaceholders -ControllerContent $implementedController
Assert-That 'case3: exits 0 (pass)' ($c3.ExitCode -eq 0)
Assert-That 'case3: mutate entry is implemented' ($c3.Result -and [int]$c3.Result.byEffectClass.mutate.implemented -eq 1)
Assert-That 'case3: majorGaps is 0' ($c3.Result -and [int]$c3.Result.majorGaps -eq 0)
Write-Host ""

# ---------------------------------------------------------------
# Case 4: Phase 1 schema + filter entry + UI scan has PlaceholderActions -> BLOCKED
# ---------------------------------------------------------------
Write-Host "  Case 4: Phase-1 schema, filter entry, UI scan has PlaceholderAction -> BLOCKED" -ForegroundColor DarkCyan
$c4 = Invoke-LedgerCase -LedgerJson $filterSchemaLedger -BackendScanJson $backendNoGaps -UiScanJson $uiWithPlaceholders
Assert-That 'case4: exits 2 (blocked)' ($c4.ExitCode -eq 2)
Assert-That 'case4: filter entry is unimplemented' ($c4.Result -and [int]$c4.Result.byEffectClass.filter.unimplemented -eq 1)
Assert-That 'case4: majorGaps includes filter' ($c4.Result -and [int]$c4.Result.majorGaps -ge 1)
Write-Host ""

# ---------------------------------------------------------------
# Case 5: Blocking mutate entry with a registry waiver -> PASS (waiver respected)
# ---------------------------------------------------------------
Write-Host "  Case 5: mutate entry blocked, registry waiver present -> PASS (waiver respected)" -ForegroundColor DarkCyan
$c5 = Invoke-LedgerCase -LedgerJson $mutateSchemaLedger -BackendScanJson $backendWithGaps -UiScanJson $uiNoPlaceholders -RegistryJson $waiverForAddRow
Assert-That 'case5: exits 0 (waiver clears block)' ($c5.ExitCode -eq 0)
Assert-That 'case5: mutate entry counted as waived' ($c5.Result -and [int]$c5.Result.byEffectClass.mutate.waived -eq 1)
Assert-That 'case5: majorGaps is 0' ($c5.Result -and [int]$c5.Result.majorGaps -eq 0)
Write-Host ""

# ---------------------------------------------------------------
# Case 6: navigate entry whose route is NOT in modern routes.config.ts -> Minor (non-blocking)
# ---------------------------------------------------------------
Write-Host "  Case 6: navigate entry, target route not in routes.config.ts -> Minor gap only (non-blocking)" -ForegroundColor DarkCyan
$c6 = Invoke-LedgerCase -LedgerJson $navigateMissingLedger -BackendScanJson $backendNoGaps -UiScanJson $uiNoPlaceholders -ModernRoutes @('file-keys','spec-book')
Assert-That 'case6: exits 0 (navigate gap is minor, not blocking)' ($c6.ExitCode -eq 0)
Assert-That 'case6: navigate entry is unimplemented' ($c6.Result -and [int]$c6.Result.byEffectClass.navigate.unimplemented -eq 1)
Assert-That 'case6: majorGaps is 0' ($c6.Result -and [int]$c6.Result.majorGaps -eq 0)
Assert-That 'case6: minorGaps is 1' ($c6.Result -and [int]$c6.Result.minorGaps -eq 1)
Write-Host ""

# ---------------------------------------------------------------
# Summary
# ---------------------------------------------------------------
if ($script:failures.Count -eq 0) {
    Write-Host ("PARITY-LEDGER SELF-TEST: all {0} assertions passed." -f $script:passCount) -ForegroundColor Green
    exit 0
} else {
    Write-Host ("PARITY-LEDGER SELF-TEST: {0} assertion(s) FAILED:" -f $script:failures.Count) -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host ("  - {0}" -f $_) -ForegroundColor Red }
    exit 2
}
