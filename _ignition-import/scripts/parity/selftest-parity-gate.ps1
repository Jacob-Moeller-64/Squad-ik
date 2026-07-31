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
    )
    $root = Join-Path ([System.IO.Path]::GetTempPath()) ("parity-selftest-" + [guid]::NewGuid().ToString('N'))
    $leg = Join-Path $root 'legacy'
    $mod = Join-Path $root 'modern'
    New-Item -ItemType Directory -Force -Path $leg, $mod | Out-Null
    try {
        Set-Content -LiteralPath (Join-Path $leg 'legacy.cshtml') -Value $LegacyHtml -Encoding UTF8
        foreach ($name in $ModernFiles.Keys) {
            $fp = Join-Path $mod $name
            $dir = Split-Path $fp -Parent
            if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
            Set-Content -LiteralPath $fp -Value $ModernFiles[$name] -Encoding UTF8
        }
        $reg = Join-Path $root 'registry.json'
        Set-Content -LiteralPath $reg -Value $RegistryJson -Encoding UTF8
        $out = Join-Path $root 'scan.json'
        # Invoke the scanner as a CHILD PROCESS so its `exit` code is the reliable process exit
        # code (an in-process `&` combined with stream redirection can reset $LASTEXITCODE). All
        # paths are absolute, so the child's working directory does not matter. Output is
        # discarded; assertions read the JSON output file, never stdout.
        $null = & powershell -NoProfile -ExecutionPolicy Bypass -File $scanner -LegacyRoot $leg -ModernClientRoot $mod -OutputPath $out -DeferralRegistryPath $reg -CurrentStep $CurrentStep -Quiet 2>&1
        $code = $LASTEXITCODE
        $json = $null
        if (Test-Path -LiteralPath $out) { $json = Get-Content -LiteralPath $out -Raw | ConvertFrom-Json }
        return [pscustomobject]@{ Result = $json; ExitCode = $code }
    }
    finally {
        Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Get-GapCountOfKind {
    param($Result, [string]$Kind)
    if ($null -eq $Result -or -not ($Result.PSObject.Properties.Name -contains 'gaps') -or $null -eq $Result.gaps) { return 0 }
    return @($Result.gaps | Where-Object { $_.kind -eq $Kind }).Count
}

Write-Host "Parity-gate self-test" -ForegroundColor Cyan

# --- Shared fixtures ----------------------------------------------------------
# Two legacy buttons; the modern side matches both by label. One modern handler is an empty
# body (a stub) registered as a deferral; the other is a real method (never inert).
$legacyTwoButtons = '<button>Go</button><button>Search</button>'
$modernTwoButtons = @{
    'demo.component.ts'   = 'export class DemoComponent { demoStub() {} onSearch() { return 1; } }'
    'demo.component.html' = '<button (click)="demoStub()">Go</button><button (click)="onSearch()">Search</button>'
}
$deferralReg = '{ "deferrals": [ { "handler": "demoStub", "ownerStep": 11, "reason": "self-test stub" } ] }'

# --- Test 1: deferral suppressed by default but always surfaced ---------------
$t1 = Invoke-ScanCase -LegacyHtml $legacyTwoButtons -ModernFiles $modernTwoButtons -RegistryJson $deferralReg -CurrentStep 0
Assert-That 'T1 deferred stub is surfaced (deferredInertControlCount = 1)' ([int]$t1.Result.deferredInertControlCount -eq 1) ("got {0}" -f $t1.Result.deferredInertControlCount)
Assert-That 'T1 deferred stub is NOT counted as an inert Major gap (inertControlCount = 0)' ([int]$t1.Result.inertControlCount -eq 0) ("got {0}" -f $t1.Result.inertControlCount)
Assert-That 'T1 matching labels produce no MissingControl gaps (majorGaps = 0)' ([int]$t1.Result.majorGaps -eq 0) ("got {0}" -f $t1.Result.majorGaps)
Assert-That 'T1 default run exits 0 (clean)' ($t1.ExitCode -eq 0) ("exit {0}" -f $t1.ExitCode)

# --- Test 2: drain gate re-flags the deferral at its owner step ---------------
$t2 = Invoke-ScanCase -LegacyHtml $legacyTwoButtons -ModernFiles $modernTwoButtons -RegistryJson $deferralReg -CurrentStep 11
Assert-That 'T2 drain gate re-flags the stub as an inert Major gap (inertControlCount >= 1)' ([int]$t2.Result.inertControlCount -ge 1) ("got {0}" -f $t2.Result.inertControlCount)
Assert-That 'T2 drained deferral is no longer merely suppressed (deferredInertControlCount = 0)' ([int]$t2.Result.deferredInertControlCount -eq 0) ("got {0}" -f $t2.Result.deferredInertControlCount)
Assert-That 'T2 drain gate exits 2 (blocking)' ($t2.ExitCode -eq 2) ("exit {0}" -f $t2.ExitCode)

# --- Test 3: deferral not yet due stays suppressed ----------------------------
$t3 = Invoke-ScanCase -LegacyHtml $legacyTwoButtons -ModernFiles $modernTwoButtons -RegistryJson $deferralReg -CurrentStep 10
Assert-That 'T3 deferral owned by Step 11 is not drained at Step 10 (deferredInertControlCount = 1)' ([int]$t3.Result.deferredInertControlCount -eq 1) ("got {0}" -f $t3.Result.deferredInertControlCount)
Assert-That 'T3 not-yet-due deferral does not block (exit 0)' ($t3.ExitCode -eq 0) ("exit {0}" -f $t3.ExitCode)

# --- Test 4: cosmetic (color) allowlist loads from the registry ---------------
$legacyCancel = '<button class="btn btn-default">Cancel</button>'
$modernCancel = @{ 'c.component.html' = '<fusion-button color="error" label="Cancel"></fusion-button>' }
$colorAllowReg = '{ "colorMismatchAllowlist": [ { "key": "cancel||default||error", "reason": "self-test" } ] }'
$t4a = Invoke-ScanCase -LegacyHtml $legacyCancel -ModernFiles $modernCancel -RegistryJson $colorAllowReg -CurrentStep 0
$t4b = Invoke-ScanCase -LegacyHtml $legacyCancel -ModernFiles $modernCancel -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T4 color divergence is suppressed when its key is in the registry allowlist' ((Get-GapCountOfKind $t4a.Result 'ColorMismatch') -eq 0) ("got {0}" -f (Get-GapCountOfKind $t4a.Result 'ColorMismatch'))
Assert-That 'T4 same color divergence is flagged when the registry is empty' ((Get-GapCountOfKind $t4b.Result 'ColorMismatch') -eq 1) ("got {0}" -f (Get-GapCountOfKind $t4b.Result 'ColorMismatch'))

# --- Test 5: a genuinely missing control is caught ----------------------------
$t5 = Invoke-ScanCase -LegacyHtml '<button>OnlyInLegacy</button>' -ModernFiles @{ 'empty.component.html' = '<div>no controls</div>' } -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T5 a missing interactive control is a Major gap (majorGaps >= 1)' ([int]$t5.Result.majorGaps -ge 1) ("got {0}" -f $t5.Result.majorGaps)
Assert-That 'T5 missing control exits 2 (the gate is not always-green)' ($t5.ExitCode -eq 2) ("exit {0}" -f $t5.ExitCode)

# --- Tests 6-7: static anti-re-blinding guards on the scanner -----------------
$scannerText = Get-Content -LiteralPath $scanner -Raw
Assert-That 'T6 scanner ships an EMPTY inert allowlist default ($inertControlAllowlist = @{})' ($scannerText -match '\$inertControlAllowlist\s*=\s*@\{\}')
$appTokens = @('phase-calcs', 'TransformerOverload', 'view data all tx')
$leaked = @($appTokens | Where-Object { $scannerText -match [regex]::Escape($_) })
Assert-That 'T6 scanner carries no known app-specific tokens (no re-blinding)' ($leaked.Count -eq 0) ("leaked: {0}" -f ($leaked -join ', '))
Assert-That 'T7 scanner still surfaces deferredInertControls' ($scannerText -match 'deferredInertControls')
Assert-That 'T7 scanner still accepts -CurrentStep (drain gate)' ($scannerText -match '\$CurrentStep')

# --- Test 8: the mechanical Step 11/12 gate is still present ------------------
if (Test-Path -LiteralPath $verifier) {
    $verifierText = Get-Content -LiteralPath $verifier -Raw
    Assert-That 'T8 verify-step-artifacts.ps1 still contains the Step 11/12 parity + drain gate' ($verifierText -match 'deferral-drain closeout gate')
}
else {
    Assert-That 'T8 verify-step-artifacts.ps1 is present' $false ("not found at {0}" -f $verifier)
}

# --- Test 9: the scanner SEES the app's own control wrappers (no false MissingControl) ---
# After a wrapper-swap pass, controls live inside app-owned wrappers (e.g. filelog-command-button).
# The scanner must recognize the app's prefix (derived from kit-params) or it reports false
# missing controls for controls that are actually present.
# The appTagAlt uses a SUFFIX HEURISTIC: only *-button/*-btn/*-link/*-action/*-cmd are matched as
# interactive block elements. Container wrappers like filelog-modal or filelog-data-grid do NOT
# match so they cannot swallow nested button children (see T9b).
$t9 = Invoke-ScanCase -LegacyHtml '<button>Widget Action</button>' -ModernFiles @{ 'w.component.html' = '<filelog-command-button testId="w" (click)="doWidget()">Widget Action</filelog-command-button>' } -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T9 app-owned wrapper controls are recognized (no false MissingControl)' ([int]$t9.Result.majorGaps -eq 0) ("majorGaps got {0}" -f $t9.Result.majorGaps)

# --- Test 9b: container wrappers do NOT swallow nested button children ---
# Regression lock for the container-swallow bug: if filelog-modal is matched as a block element
# (old behaviour: appTagAlt matched ALL filelog-* prefixes), [regex]::Matches finds the outer
# filelog-modal and its (.*?) captures the inner filelog-command-button as plain text.  The inner
# Cancel button is never a separate record → false MissingControl.  With the suffix heuristic only
# filelog-*-button is in the block pattern, so filelog-modal is invisible to the regex and the inner
# filelog-command-button is found independently.
$t9b = Invoke-ScanCase -LegacyHtml '<button>Cancel</button>' -ModernFiles @{ 'modal.component.html' = '<filelog-modal [open]="show"><filelog-command-button (click)="cancel()">Cancel</filelog-command-button></filelog-modal>' } -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T9b nested button inside container wrapper is detected (no false MissingControl)' ([int]$t9b.Result.majorGaps -eq 0) ("majorGaps got {0} - container swallow bug" -f $t9b.Result.majorGaps)

# --- Test 10: legacy TypeScript inline templates are scanned (row-level renderer coverage) ---
# Regression lock: controls in legacy .ts template:`` strings (e.g. ag-grid cell renderers like
# RetrieveFilesRenderer) MUST be visible to the scanner. Without this pass majorGaps=0 while row-level
# action links are missing from modern - a false clean that let FileLog ship with empty File Links/Actions.
# This test is an integration-level check against a real temp legacy tree (not the LegacyHtml stub)
# because the scanner's TS template logic requires actual .ts files on disk with template: `` syntax.
$t10Root = Join-Path ([System.IO.Path]::GetTempPath()) ("t10-" + [guid]::NewGuid().ToString('N'))
$t10Leg = Join-Path $t10Root 'legacy'; $t10Mod = Join-Path $t10Root 'modern'
New-Item -ItemType Directory -Force -Path $t10Leg, $t10Mod | Out-Null
try {
    # Use Angular @Component decorator syntax matching the real legacy files, with [routerLink]
    # so the anchor is classified as INTERACTIVE (the scanner requires routerLink/href/handler/icon
    # for an <a> to count as an interactive control; a bare <a>Text</a> is correctly treated as passive).
    Set-Content (Join-Path $t10Leg 'renderer.ts') "@Component({ template: ``<a [routerLink]=`"['/files']`">Retrieve Files</a>`` })`nexport class R {}" -Encoding UTF8
    Set-Content (Join-Path $t10Mod 'empty.html') '<div>nothing</div>' -Encoding UTF8
    $t10out = Join-Path $t10Root 's.json'
    $null = & powershell -NoProfile -ExecutionPolicy Bypass -File $scanner -LegacyRoot $t10Leg -ModernClientRoot $t10Mod -OutputPath $t10out -DeferralRegistryPath (Join-Path $t10Root 'r.json') -Quiet 2>&1
    if (Test-Path $t10out) {
        $t10j = Get-Content $t10out -Raw | ConvertFrom-Json
        Assert-That 'T10 legacy TS inline template controls are scanned (Retrieve Files visible)' ([int]$t10j.legacyInteractiveControls -ge 1) ("legacy interactive=$($t10j.legacyInteractiveControls) - TS template scan missing")
    } else {
        Assert-That 'T10 legacy TS inline template controls are scanned (scan output exists)' $false 'scan output file not produced'
    }
} finally {
    Remove-Item $t10Root -Recurse -Force -ErrorAction SilentlyContinue
}

# --- Test 11: a DEAD control (legacy interactive, modern label-only stub) is flagged ---
# Regression lock for the dead-nav / dead-button defect: a legacy INTERACTIVE control (routerLink)
# ported to the modern side as a bare label-only element (<a>Retrieve Files</a> with no routerLink,
# a <span>Copy</span> with no handler) renders the right text but DOES NOTHING. The plain label
# pass treated it as "present". The DeadControl check catches "label present but no behavior".
$t11 = Invoke-ScanCase `
    -LegacyHtml '<a href="/files">Retrieve Files</a>' `
    -ModernFiles @{ 'r.component.html' = '<a class="local-link">Retrieve Files</a>' } `
    -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T11 a dead label-only modern control is a Major DeadControl gap (majorGaps >= 1)' ([int]$t11.Result.majorGaps -ge 1) ("majorGaps got {0}" -f $t11.Result.majorGaps)
Assert-That 'T11 the gap kind is DeadControl' ((@($t11.Result.gaps | Where-Object { $_.kind -eq 'DeadControl' }).Count) -ge 1) ("no DeadControl gap emitted")
Assert-That 'T11 dead control exits 2 (blocking)' ($t11.ExitCode -eq 2) ("exit {0}" -f $t11.ExitCode)

# --- Test 12: a properly-wired modern control (real routerLink) is NOT a dead control ---
$t12 = Invoke-ScanCase `
    -LegacyHtml '<a href="/files">Retrieve Files</a>' `
    -ModernFiles @{ 'r.component.html' = '<a [routerLink]="[''/files'']">Retrieve Files</a>' } `
    -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T12 a wired modern control (routerLink) is NOT a DeadControl (majorGaps = 0)' ([int]$t12.Result.majorGaps -eq 0) ("majorGaps got {0}" -f $t12.Result.majorGaps)

# --- Test 13: a mutation-action button wired to a modal-open-only handler is a PlaceholderAction ---
# Regression lock for the dead-action defect: an Add/Edit/Delete/Save/Submit button whose (click)
# handler ONLY opens a modal flag (this.showXModal = true) and does no real work looks wired (the
# handler is not empty, so InertControl does not fire) but performs nothing. This is exactly how
# 'Add Row / Delete Selected / Export' shipped green over placeholder modals.
$paTs = 'export class DemoComponent { showAddModal = false; deleteSelectedModal() { this.showAddModal = true; } save() { return this.svc.save(); } }'
$t13 = Invoke-ScanCase `
    -LegacyHtml '<button>Delete Selected</button><button>Save</button>' `
    -ModernFiles @{ 'demo.component.ts' = $paTs; 'demo.component.html' = '<button (click)="deleteSelectedModal()">Delete Selected</button><button (click)="save()">Save</button>' } `
    -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T13 a modal-open-only mutation-action handler is a Major PlaceholderAction' ((@($t13.Result.gaps | Where-Object { $_.kind -eq 'PlaceholderAction' }).Count) -ge 1) ("no PlaceholderAction gap emitted")
Assert-That 'T13 placeholder action blocks (exit 2)' ($t13.ExitCode -eq 2) ("exit {0}" -f $t13.ExitCode)
Assert-That 'T13 the real save() handler is NOT flagged as a PlaceholderAction' ((@($t13.Result.gaps | Where-Object { $_.kind -eq 'PlaceholderAction' -and $_.label -eq 'save' }).Count) -eq 0) ("save() wrongly flagged")

# --- Test 14: a benign read-only modal opener (showHelp) is NOT a PlaceholderAction ---
$helpTs = 'export class HelpBtn { showHelpModal = false; showHelp() { this.showHelpModal = true; } }'
$t14 = Invoke-ScanCase `
    -LegacyHtml '<button>Help</button>' `
    -ModernFiles @{ 'help.component.ts' = $helpTs; 'help.component.html' = '<button (click)="showHelp()">Help</button>' } `
    -RegistryJson '{ }' -CurrentStep 0
Assert-That 'T14 a benign read-only modal opener (showHelp) is NOT a PlaceholderAction' ((@($t14.Result.gaps | Where-Object { $_.kind -eq 'PlaceholderAction' }).Count) -eq 0) ("showHelp wrongly flagged as placeholder action")


Write-Host ""
if ($script:failures.Count -eq 0) {
    Write-Host "PARITY-GATE SELF-TEST: all assertions passed." -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("PARITY-GATE SELF-TEST: {0} assertion(s) FAILED." -f $script:failures.Count) -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host ("  - {0}" -f $_) -ForegroundColor Red }
    exit 2
}
