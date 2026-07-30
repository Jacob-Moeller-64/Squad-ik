<#
.SYNOPSIS
    Single gate-integrity runner: discovers and executes every gate self-test in the kit and
    reports one aggregate pass/fail. This is the standing "are the parity/scaffold/deferral gates
    still correct?" check - one command instead of an ad-hoc memory of which scripts to run.

.DESCRIPTION
    The kit's functional-parity gates (scan-ui-parity-gaps.ps1, scan-scaffold-debt.ps1, and the
    verify-step-artifacts deferral-drain / parity / scaffold gates) are only trustworthy if their
    DECISION LOGIC is continuously verified. Each gate ships a selftest-*.ps1 that runs the REAL
    gate against synthetic KNOWN-GOOD and KNOWN-BAD fixtures and asserts the verdicts (fires on
    bad, stays silent on good, drains overdue deferrals, honors registries). This runner finds and
    runs all of them.

    Run it after ANY edit to a gate script or its rules. A failing self-test means the gate no
    longer discriminates correctly - either a real defect would ship (false negative) or correct
    code would be blocked (false positive) - so the edit must not land until the self-test is green.

    This verifies gate LOGIC. It does not, and cannot, prove a specific app is behaviorally correct
    at runtime; that is the runtime interact-and-assert checkpoint's job. See the repo's
    functional-parity guidance for the static-vs-runtime split.

.OUTPUTS
    Exit 0 when every discovered self-test passes; exit 2 when any self-test fails or none are found.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/verify-gate-integrity.ps1
#>
[CmdletBinding()]
param(
    # Root to search for selftest-*.ps1. Defaults to .github/scripts so every gate self-test
    # anywhere in the kit is auto-included as it is added - no registration step to forget.
    [string]$ScriptsRoot,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

if (-not $ScriptsRoot -or [string]::IsNullOrWhiteSpace($ScriptsRoot)) {
    $ScriptsRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path   # .github/scripts
}

$selfTests = @(Get-ChildItem -Path $ScriptsRoot -Recurse -Filter 'selftest-*.ps1' -ErrorAction SilentlyContinue |
    Sort-Object FullName)

Write-Host "Gate-integrity runner" -ForegroundColor Cyan
Write-Host ("  Discovered {0} gate self-test(s) under {1}" -f $selfTests.Count, $ScriptsRoot)
Write-Host ""

if ($selfTests.Count -eq 0) {
    Write-Host "  No gate self-tests found - nothing to verify (expected selftest-*.ps1)." -ForegroundColor Red
    exit 2
}

$results = New-Object System.Collections.Generic.List[object]
foreach ($st in $selfTests) {
    # Run each self-test as a child process so its exit code is the reliable process exit code.
    # Do NOT forward -Quiet: the runner needs the child's [PASS]/[FAIL] lines to count assertions;
    # -Quiet controls only the runner's own summary verbosity, captured output is not displayed
    # unless the self-test fails.
    $psArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $st.FullName)
    $out = & powershell @psArgs 2>&1
    $code = $LASTEXITCODE
    $passCount = @($out | Select-String -Pattern '\[PASS\]').Count
    $failCount = @($out | Select-String -Pattern '\[FAIL\]').Count
    $ok = ($code -eq 0)
    $results.Add([pscustomobject]@{ Name = $st.Name; Ok = $ok; Pass = $passCount; Fail = $failCount; Exit = $code }) | Out-Null
    $tag = if ($ok) { 'OK  ' } else { 'FAIL' }
    Write-Host ("  [{0}] {1}  (pass={2} fail={3})" -f $tag, $st.Name, $passCount, $failCount) -ForegroundColor $(if ($ok) { 'Green' } else { 'Red' })
    if (-not $ok -and -not $Quiet) {
        @($out | Select-String -Pattern '\[FAIL\]') | ForEach-Object { Write-Host ("        {0}" -f $_.Line.Trim()) -ForegroundColor Red }
    }
}

$failed = @($results | Where-Object { -not $_.Ok })
$totalPass = ($results | Measure-Object -Property Pass -Sum).Sum
Write-Host ""
if ($failed.Count -eq 0) {
    Write-Host ("GATE INTEGRITY: all {0} gate self-test(s) passed ({1} assertions)." -f $results.Count, $totalPass) -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("GATE INTEGRITY: {0} of {1} gate self-test(s) FAILED." -f $failed.Count, $results.Count) -ForegroundColor Red
    $failed | ForEach-Object { Write-Host ("   - {0} (exit {1})" -f $_.Name, $_.Exit) -ForegroundColor Red }
    exit 2
}
