<#
.SYNOPSIS
    App-agnostic self-test for scan-scaffold-debt.ps1: proves the scaffold-debt detector flags
    surviving deferral markers, extracts owning steps, drains overdue markers, honors -Strict and
    the accepted-marker registry, and does NOT false-flag real code (HTML placeholder attributes
    or comments describing an improvement over an old placeholder).

.OUTPUTS
    Exit code 0 when every assertion passes; exit code 2 when any assertion fails.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/selftest-scaffold-debt.ps1
#>
[CmdletBinding()]
param([switch]$Quiet)

$ErrorActionPreference = 'Stop'
$scanner = Join-Path $PSScriptRoot 'scan-scaffold-debt.ps1'
if (-not (Test-Path -LiteralPath $scanner)) { throw "Scanner not found at $scanner" }

$script:failures = New-Object System.Collections.Generic.List[string]

function Assert-That {
    param([string]$Name, [bool]$Condition, [string]$Detail = '')
    if ($Condition) {
        if (-not $Quiet) { Write-Host ("  [PASS] {0}" -f $Name) -ForegroundColor Green }
    }
    else {
        $script:failures.Add($Name) | Out-Null
        Write-Host ("  [FAIL] {0}{1}" -f $Name, $(if ($Detail) { " - $Detail" } else { '' })) -ForegroundColor Red
    }
}

# Run the scaffold-debt scanner against a synthetic modern tree. Child-process invocation keeps
# the exit code reliable; assertions read the JSON output file, never stdout.
function Invoke-DebtCase {
    param(
        [hashtable]$ModernFiles,
        [int]$CurrentStep = 0,
        [switch]$Strict,
        [string]$RegistryJson = ''
    )
    $root = Join-Path ([System.IO.Path]::GetTempPath()) ("scaffold-selftest-" + [guid]::NewGuid().ToString('N'))
    $mod = Join-Path $root 'client'
    New-Item -ItemType Directory -Force -Path $mod | Out-Null
    try {
        foreach ($name in $ModernFiles.Keys) {
            $fp = Join-Path $mod $name
            $dir = Split-Path $fp -Parent
            if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
            Set-Content -LiteralPath $fp -Value $ModernFiles[$name] -Encoding UTF8
        }
        $reg = Join-Path $root 'registry.json'
        if ([string]::IsNullOrWhiteSpace($RegistryJson)) { $RegistryJson = '{ }' }
        Set-Content -LiteralPath $reg -Value $RegistryJson -Encoding UTF8
        $out = Join-Path $root 'scan.json'
        $psArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $scanner,
            '-ModernClientRoot', $mod, '-OutputPath', $out, '-RegistryPath', $reg, '-CurrentStep', $CurrentStep, '-Quiet')
        if ($Strict) { $psArgs += '-Strict' }
        $null = & powershell @psArgs 2>&1
        $code = $LASTEXITCODE
        $json = $null
        if (Test-Path -LiteralPath $out) { $json = Get-Content -LiteralPath $out -Raw | ConvertFrom-Json }
        return [pscustomobject]@{ Result = $json; ExitCode = $code }
    }
    finally {
        Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Scaffold-debt self-test" -ForegroundColor Cyan

$stepMarkerFile = @{ 'demo.component.ts' = 'export class Demo { /* Step 11 wires the real service here. */ load() {} }' }

# T1: a "Step 11 wires ..." marker is OVERDUE once step 11 is reached.
$t1 = Invoke-DebtCase -ModernFiles $stepMarkerFile -CurrentStep 11
Assert-That 'T1 owning-step marker is overdue at its step (overdue >= 1)' ([int]$t1.Result.overdueMarkers -ge 1) ("got {0}" -f $t1.Result.overdueMarkers)
Assert-That 'T1 owning step is extracted (impliedStep = 11)' (([int]($t1.Result.findings | Select-Object -First 1 -ExpandProperty impliedStep)) -eq 11)
Assert-That 'T1 overdue marker exits 2 (blocking)' ($t1.ExitCode -eq 2) ("exit {0}" -f $t1.ExitCode)

# T2: the same marker is only tracked before its owning step is reached.
$t2 = Invoke-DebtCase -ModernFiles $stepMarkerFile -CurrentStep 10
Assert-That 'T2 owning-step marker is not overdue before its step (overdue = 0)' ([int]$t2.Result.overdueMarkers -eq 0) ("got {0}" -f $t2.Result.overdueMarkers)
Assert-That 'T2 marker is still surfaced as tracked (tracked >= 1)' ([int]$t2.Result.trackedMarkers -ge 1) ("got {0}" -f $t2.Result.trackedMarkers)
Assert-That 'T2 not-yet-due marker exits 0' ($t2.ExitCode -eq 0) ("exit {0}" -f $t2.ExitCode)

# T3: a marker with NO owning step is tracked but does not block by default.
$laterFile = @{ 'later.component.html' = '<!-- the full form is wired in a later step -->' }
$t3 = Invoke-DebtCase -ModernFiles $laterFile -CurrentStep 12
Assert-That 'T3 stepless "later step" marker is tracked, not overdue' (([int]$t3.Result.trackedMarkers -ge 1) -and ([int]$t3.Result.overdueMarkers -eq 0)) ("tracked={0} overdue={1}" -f $t3.Result.trackedMarkers, $t3.Result.overdueMarkers)

# T4: -Strict makes any surviving marker overdue (Phase-2 close).
$t4 = Invoke-DebtCase -ModernFiles $laterFile -CurrentStep 0 -Strict
Assert-That 'T4 -Strict escalates a stepless marker to overdue' ([int]$t4.Result.overdueMarkers -ge 1) ("got {0}" -f $t4.Result.overdueMarkers)

# T5: clean code produces no markers.
$t5 = Invoke-DebtCase -ModernFiles @{ 'clean.component.ts' = 'export class Clean { doWork() { return 1; } }' } -CurrentStep 12
Assert-That 'T5 clean code has no markers (total = 0)' ([int]$t5.Result.totalMarkers -eq 0) ("got {0}" -f $t5.Result.totalMarkers)

# T6: the HTML placeholder="..." attribute is NOT scaffold debt.
$t6 = Invoke-DebtCase -ModernFiles @{ 'input.component.html' = '<input placeholder="Enter a key number" />' } -CurrentStep 12
Assert-That 'T6 HTML placeholder attribute is not flagged (total = 0)' ([int]$t6.Result.totalMarkers -eq 0) ("got {0}" -f $t6.Result.totalMarkers)

# T7: a comment describing an improvement OVER an old placeholder is not flagged.
$t7 = Invoke-DebtCase -ModernFiles @{ 'wrap.component.ts' = '// a large upgrade over placeholder text' } -CurrentStep 12
Assert-That 'T7 "upgrade over placeholder text" is not flagged (total = 0)' ([int]$t7.Result.totalMarkers -eq 0) ("got {0}" -f $t7.Result.totalMarkers)

# T8: an accepted-marker registry entry downgrades a marker (no block).
$t8 = Invoke-DebtCase -ModernFiles $stepMarkerFile -CurrentStep 11 -RegistryJson '{ "acceptedMarkers": [ { "textContains": "Step 11 wires the real service", "reason": "self-test accepted" } ] }'
Assert-That 'T8 accepted marker is not overdue (overdue = 0)' ([int]$t8.Result.overdueMarkers -eq 0) ("got {0}" -f $t8.Result.overdueMarkers)
Assert-That 'T8 accepted marker is counted as accepted (accepted >= 1)' ([int]$t8.Result.acceptedMarkers -ge 1) ("got {0}" -f $t8.Result.acceptedMarkers)
Assert-That 'T8 accepted-only run exits 0' ($t8.ExitCode -eq 0) ("exit {0}" -f $t8.ExitCode)

# T9: regression lock for a real false positive found on a correctly-built Fusion wrapper -
# the word "placeholder" (a legitimate input feature) must NOT be a scaffold-debt trigger.
$t9 = Invoke-DebtCase -ModernFiles @{ 'field.component.ts' = '// Placeholder text passed straight through to the Fusion textbox.' } -CurrentStep 12
Assert-That 'T9 "placeholder" in correct wrapper code is not flagged (total = 0)' ([int]$t9.Result.totalMarkers -eq 0) ("got {0}" -f $t9.Result.totalMarkers)

# T10: a rendered scaffold-placeholder element (exact CSS class) is a shipped placeholder standing
# in for a real control/grid. It is ALWAYS overdue (blocking) at any step - a placeholder shipped as
# final state is a defect now, not "later". This is the exact defect a real app shipped (a DWG grid
# rendered as <p class="scaffold-placeholder">Grid (Step 11): ...</p>) that neither the parity nor the
# step-marker scan caught, because the columns were declared in TS and the text had no "Step N wires" verb.
$t10 = Invoke-DebtCase -ModernFiles @{ 'grid.component.html' = '<p class="scaffold-placeholder">Grid (Step 11): Key - Change - Dwg</p>' } -CurrentStep 0
Assert-That 'T10 scaffold-placeholder class is overdue even at CurrentStep 0 (overdue >= 1)' ([int]$t10.Result.overdueMarkers -ge 1) ("got {0}" -f $t10.Result.overdueMarkers)
Assert-That 'T10 scaffold-placeholder class blocks (exit 2)' ($t10.ExitCode -eq 2) ("exit {0}" -f $t10.ExitCode)

# T11: an ordinary class that merely CONTAINS the word 'placeholder' as a substring of a different
# token (e.g. 'input-placeholder-hint') must NOT trip the exact 'scaffold-placeholder' rule.
$t11 = Invoke-DebtCase -ModernFiles @{ 'ok.component.html' = '<div class="grid-region input-placeholder-hint">real</div>' } -CurrentStep 12
Assert-That 'T11 a non-scaffold placeholder-ish class is not flagged (total = 0)' ([int]$t11.Result.totalMarkers -eq 0) ("got {0}" -f $t11.Result.totalMarkers)

Write-Host ""
if ($script:failures.Count -eq 0) {
    Write-Host "SCAFFOLD-DEBT SELF-TEST: all assertions passed." -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("SCAFFOLD-DEBT SELF-TEST: {0} assertion(s) FAILED." -f $script:failures.Count) -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host ("  - {0}" -f $_) -ForegroundColor Red }
    exit 2
}
