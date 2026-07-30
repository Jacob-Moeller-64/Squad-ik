<#
.SYNOPSIS
    App-agnostic self-test for the Functional Parity Ledger scanner
    (scan-functional-parity-ledger.ps1). Proves the gate honestly catches the class of
    miss where legacy Add/Edit/Delete functionality or filter behavior was never ported to
    the modernized app.

.DESCRIPTION
    The modernization failure this locks down: a Step 3 interaction-wiring-inventory
    lists buttons with effectClass 'mutate' or 'filter', but the modernized app never
    ports those write endpoints or wires those filter calls. Every prior gate reports
    green (controls are present in the UI) while the user cannot Add, Edit, Delete, or
    filter anything. This self-test runs the REAL scanner against synthetic fixtures and
    asserts:
      1. A ledger with NO effectClass schema (old format) -> scanner exits 0 but sets
         hasEffectClassSchema: false (degraded mode, not blocking, warns operator).
      2. A ledger with Phase 1 schema + mutate entries + backend-parity-scan missing
         mutations > 0 -> scanner exits 2 (BLOCKED).
      3. A ledger with Phase 1 schema + mutate entries + backend-parity-scan missing
         mutations = 0 -> scanner exits 0 (PASS).
      4. A ledger with Phase 1 schema + filter entries + ui-parity-gap-scan
         PlaceholderAction > 0 -> scanner exits 2 (BLOCKED).
      5. A ledger with blocking mutate entries but a registry waiver covering them
         -> scanner exits 0 (waiver respected).
      6. A ledger with navigate entries whose target is NOT in routes.config.ts
         -> scanner exits 0 (Minor gap only, not a blocker).

.OUTPUTS
    Exit 0 when every assertion passes; exit 2 when any assertion fails.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/selftest-functional-parity-ledger.ps1
#>
[CmdletBinding()]
param([switch]$Quiet)

$ErrorActionPreference = 'Stop'
$scanner = Join-Path $PSScriptRoot 'scan-functional-parity-ledger.ps1'
if (-not (Test-Path -LiteralPath $scanner)) { throw "Scanner not found at $scanner" }

$script:failures = New-Object System.Collections.Generic.List[string]
$script:passCount = 0

function Assert-That {
    param([string]$Name, [bool]$Condition, [string]$Detail = '')
    if ($Condition) {
        $script:passCount++
        if (-not $Quiet) { Write-Host ("  [PASS] {0}" -f $Name) -ForegroundColor Green }
    } else {
        $script:failures.Add($Name) | Out-Null
        Write-Host ("  [FAIL] {0}{1}" -f $Name, $(if ($Detail) { " - $Detail" } else { '' })) -ForegroundColor Red
    }
}

# Run the scanner against a synthetic repo root containing the provided fixture files.
# Returns { Result (parsed JSON), ExitCode }.
function Invoke-LedgerCase {
    param(
        # JSON content for interaction-wiring-inventory.json (the ledger)
        [string]$LedgerJson,
        # JSON content for backend-parity-scan.json (optional)
        [string]$BackendScanJson = '{"missingMutationCount":0,"missingQueryCount":0,"droppedControllers":[],"majorGaps":0,"minorGaps":0}',
        # JSON content for ui-parity-gap-scan.json (optional)
        [string]$UiScanJson = '{"byKind":[],"majorGaps":0}',
        # JSON content for functional-parity-registry.json (optional)
        [string]$RegistryJson = '{"acceptedDrops":[]}',
        # Routes to declare in a synthetic routes.config.ts (array of path strings)
        [string[]]$ModernRoutes = @('file-keys','spec-book'),
        # C# controller content to write into src/ (optional, for mutation count detection)
        [string]$ControllerContent = ''
    )

    $root = Join-Path ([System.IO.Path]::GetTempPath()) ("fpl-selftest-" + [guid]::NewGuid().ToString('N'))
    $discoveryDir = Join-Path $root '.modernization/ignition-artifacts/discovery'
    $clientDir    = Join-Path $root 'src/TestApp.Web.Client/src/app'
    $apiDir       = Join-Path $root 'src/TestApp.Web.Api/Controllers'

    New-Item -ItemType Directory -Force -Path $discoveryDir, $clientDir, $apiDir | Out-Null

    # Write fixture files
    Set-Content -LiteralPath (Join-Path $discoveryDir 'interaction-wiring-inventory.json')  -Value $LedgerJson       -Encoding UTF8
    Set-Content -LiteralPath (Join-Path $discoveryDir 'backend-parity-scan.json')           -Value $BackendScanJson  -Encoding UTF8
    Set-Content -LiteralPath (Join-Path $discoveryDir 'ui-parity-gap-scan.json')            -Value $UiScanJson       -Encoding UTF8
    Set-Content -LiteralPath (Join-Path $discoveryDir 'functional-parity-registry.json')    -Value $RegistryJson     -Encoding UTF8

    # Synthetic routes.config.ts
    $routeLines = ($ModernRoutes | ForEach-Object { "  { path: '$_' }," }) -join "`n"
    $routesTs = "export const routes = { routes: [`n$routeLines`n] };"
    Set-Content -LiteralPath (Join-Path $clientDir 'routes.config.ts') -Value $routesTs -Encoding UTF8

    # Synthetic controller (for HasHttpMutation detection)
    if (-not [string]::IsNullOrWhiteSpace($ControllerContent)) {
        Set-Content -LiteralPath (Join-Path $apiDir 'TestController.cs') -Value $ControllerContent -Encoding UTF8
    }

    try {
        $out = Join-Path $root 'scan-output.json'
        # Run the real scanner. Use the current shell (pwsh) directly since the scanner is PS7-compatible.
        $psArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $scanner,
            '-RepoRoot', $root, '-Quiet')
        $null = & powershell @psArgs 2>&1
        $code = $LASTEXITCODE

        # The scanner writes to $discoveryDir/functional-parity-ledger-scan.json
        $scanOut = Join-Path $discoveryDir 'functional-parity-ledger-scan.json'
        $json = $null
        if (Test-Path -LiteralPath $scanOut) { $json = Get-Content -LiteralPath $scanOut -Raw | ConvertFrom-Json }
        return [pscustomobject]@{ Result = $json; ExitCode = $code }
    } finally {
        Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# ---------------------------------------------------------------
# Fixture helpers
# ---------------------------------------------------------------

# Ledger entry WITHOUT effectClass (old schema - pre-Phase-1)
$oldSchemaLedger = @'
{
  "generatedAt": "2026-01-01T00:00:00Z",

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-121 only. Source lines 122-283 are NOT
# transcribed. Lines 284-341 (the tail) are held separately in
# selftest-functional-parity-ledger.TAIL-284-341.ps1. The source file is 340
# content lines. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
