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

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-65 only; 1 of the 3 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
