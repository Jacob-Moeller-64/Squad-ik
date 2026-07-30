<#
.SYNOPSIS
    App-agnostic self-test for the UI control-parity gate: proves scan-ui-parity-gaps.ps1
    and the Step 11/12 mechanical enforcement stay HONEST and cannot be silently re-blinded.

.DESCRIPTION
    The original modernization failure mode was a parity gate that reported majorGaps=0 while
    the app was missing half its controls, because an app-specific allowlist hard-coded into the
    reusable scanner permanently suppressed the inert-control signal. This self-test locks in the
    fixes so a future edit cannot quietly reintroduce that blindness:

      Behavior tests (synthetic legacy/modern fixtures + a temp registry, no real app needed):
        1. A registry-deferred stub is SUPPRESSED from Major gaps but SURFACED in
           deferredInertControls[] (a zero inert count can never hide a parked stub).
        2. The drain gate re-flags that deferral as a Major InertControl once its owner step is
           reached (-CurrentStep >= ownerStep) and the scan exits 2.
        3. A deferral whose owner step is not yet reached stays suppressed (no false drain).
        4. A cosmetic (color) divergence is suppressed when its key is in the registry allowlist
           and flagged when it is not - proving cosmetic allowlists load from evidence, not code.
        5. A genuinely missing control is reported as a Major gap and exits 2 (the gate is not
           merely always-green).

      Static anti-re-blinding guards (regression locks on the reusable assets):
        6. scan-ui-parity-gaps.ps1 ships an EMPTY inert allowlist default and carries no known
           app-specific handler/label/feature tokens.
        7. scan-ui-parity-gaps.ps1 still emits deferredInertControls and accepts -CurrentStep.
        8. verify-step-artifacts.ps1 still contains the Step 11/12 parity + deferral-drain gate.

.OUTPUTS
    Exit code 0 when every assertion passes; exit code 2 when any assertion fails.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/selftest-parity-gate.ps1
#>
[CmdletBinding()]
param([switch]$Quiet)

$ErrorActionPreference = 'Stop'

$scanner = Join-Path $PSScriptRoot 'scan-ui-parity-gaps.ps1'
$verifier = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath 'shared' | Join-Path -ChildPath 'verify-step-artifacts.ps1'
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

# Run the scanner against a synthetic fixture and return { Result (parsed JSON), ExitCode }.
# The scanner is invoked in-process with the call operator; its `exit` sets $LASTEXITCODE and
# returns control here. Assertions read the JSON output file, never stdout, so console
# truncation is irrelevant.
function Invoke-ScanCase {
    param(
        [string]$LegacyHtml,
        [hashtable]$ModernFiles,
        [string]$RegistryJson,
        [int]$CurrentStep = 0

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-66 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
