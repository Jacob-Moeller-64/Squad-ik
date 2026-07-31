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
      1. A ledger with NO effectClass schema (old format) → scanner exits 0 but sets
         hasEffectClassSchema: false (degraded mode, not blocking, warns operator).
      2. A ledger with Phase 1 schema + mutate entries + backend-parity-scan missing
         mutations > 0 → scanner exits 2 (BLOCKED).
      3. A ledger with Phase 1 schema + mutate entries + backend-parity-scan missing
         mutations = 0 → scanner exits 0 (PASS).
      4. A ledger with Phase 1 schema + filter entries + ui-parity-gap-scan
         PlaceholderAction > 0 → scanner exits 2 (BLOCKED).
      5. A ledger with blocking mutate entries but a registry waiver covering them
         → scanner exits 0 (waiver respected).
      6. A ledger with navigate entries whose target is NOT in routes.config.ts
         → scanner exits 0 (Minor gap only, not a blocker).

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

# Ledger entry WITHOUT effectClass (old schema — pre-Phase-1)
$oldSchemaLedger = @'
{
  "generatedAt": "2026-01-01T00:00:00Z",
  "sourceRoot": "./LegacyCode",
  "entries": [
    { "controlId": "ctrl-1", "surface": "./legacy/file-log.html", "label": "Add Row",
      "controlKind": "button", "triggerEvent": "click",
      "wiringKind": "state-mutation", "target": "addRow()", "sideEffects": [],
      "authGate": "", "legacyEvidence": [], "wiringStatus": "located" }
  ]
}
'@

# Ledger with Phase 1 schema — one mutate entry
$mutateSchemaLedger = @'
{
  "generatedAt": "2026-01-01T00:00:00Z",
  "sourceRoot": "./LegacyCode",
  "entries": [
    { "controlId": "ctrl-1", "surface": "./legacy/file-log.html", "label": "Add Row",
      "controlKind": "button", "triggerEvent": "click",
      "effectClass": "mutate", "effectAssertion": "api-call-fires-and-persists",
      "lifecycleState": "Inventoried",
      "wiringKind": "api-call", "target": "addRow()", "resolvedTarget": "",
      "sideEffects": [], "authGate": "", "legacyEvidence": [], "waiver": null,
      "wiringStatus": "located" }
  ]
}
'@

# Ledger with a filter entry (PlaceholderAction scenario)
$filterSchemaLedger = @'
{
  "generatedAt": "2026-01-01T00:00:00Z",
  "sourceRoot": "./LegacyCode",
  "entries": [
    { "controlId": "ctrl-1", "surface": "./legacy/missing-links.html", "label": "Apply Filter",
      "controlKind": "button", "triggerEvent": "click",
      "effectClass": "filter", "effectAssertion": "grid-rows-change-after-apply",
      "lifecycleState": "Inventoried",
      "wiringKind": "state-mutation", "target": "applyFilter()", "resolvedTarget": "",
      "sideEffects": [], "authGate": "", "legacyEvidence": [], "waiver": null,
      "wiringStatus": "located" }
  ]
}
'@

# Ledger with a navigate entry whose route does NOT exist in modern routes.config.ts
$navigateMissingLedger = @'
{
  "generatedAt": "2026-01-01T00:00:00Z",
  "sourceRoot": "./LegacyCode",
  "entries": [
    { "controlId": "ctrl-1", "surface": "./legacy/nav.html", "label": "Antenna Index",
      "controlKind": "a", "triggerEvent": "click",
      "effectClass": "navigate", "effectAssertion": "route-changes-to-target",
      "lifecycleState": "Inventoried",
      "wiringKind": "route-navigation", "target": "/antenna-index", "resolvedTarget": "/antenna-index",
      "sideEffects": [], "authGate": "", "legacyEvidence": [], "waiver": null,
      "wiringStatus": "located" }
  ]
}
'@

# Backend parity scan showing missing mutations (blocks mutate ledger entries)
$backendWithGaps = @'
{
  "generatedUtc": "2026-01-01T00:00:00Z",
  "missingMutationCount": 3,
  "missingQueryCount": 0,
  "droppedControllers": [],
  "majorGaps": 3,
  "minorGaps": 0
}
'@

# Backend parity scan showing zero gaps (all mutations implemented)
$backendNoGaps = @'
{
  "generatedUtc": "2026-01-01T00:00:00Z",
  "missingMutationCount": 0,
  "missingQueryCount": 0,
  "droppedControllers": [],
  "majorGaps": 0,
  "minorGaps": 0
}
'@

# UI parity scan showing PlaceholderAction controls (blocks filter ledger entries)
$uiWithPlaceholders = @'
{
  "majorGaps": 1,
  "byKind": [
    { "Name": "PlaceholderAction", "Count": 2 }
  ]
}
'@

# UI parity scan with no placeholder actions
$uiNoPlaceholders = @'
{
  "majorGaps": 0,
  "byKind": []
}
'@

# Registry that waives all mutate entries for a specific label pattern
$waiverForAddRow = @'
{
  "registryVersion": "1.0",
  "acceptedDrops": [
    {
      "effectClass": "mutate",
      "labelPattern": "Add Row",
      "reason": "Out of scope for initial release per PM approval 2026-07-04",
      "owningStep": "6"
    }
  ]
}
'@

# ---------------------------------------------------------------
# Synthetic modern controller with real mutations (for "all implemented" test)
$implementedController = @'
[Route("api/[controller]")]
public class TestController : ControllerBase {
    [HttpGet]
    public IActionResult GetAll() { return Ok(); }
    [HttpPost]
    public IActionResult AddItem([FromBody] object input) { return Ok(); }
    [HttpPut("{id}")]
    public IActionResult UpdateItem(int id) { return Ok(); }
    [HttpDelete("{id}")]
    public IActionResult DeleteItem(int id) { return Ok(); }
}
'@

# ---------------------------------------------------------------
Write-Host "Functional-parity-ledger self-test" -ForegroundColor Cyan
Write-Host ""

# ---------------------------------------------------------------
# Case 1: Old schema (no effectClass) — degrades gracefully, exits 0, warns
# ---------------------------------------------------------------
Write-Host "  Case 1: old-schema ledger (pre-Phase-1 -- no effectClass field)" -ForegroundColor DarkCyan
$c1 = Invoke-LedgerCase -LedgerJson $oldSchemaLedger
Assert-That 'case1: exits 0 (old schema does not block)' ($c1.ExitCode -eq 0)
Assert-That 'case1: hasEffectClassSchema is false' ($c1.Result -and $c1.Result.hasEffectClassSchema -eq $false)
Assert-That 'case1: all entries classified as ui-only' ($c1.Result -and [int]$c1.Result.byEffectClass.'ui-only'.total -eq 1)
Assert-That 'case1: majorGaps is 0' ($c1.Result -and [int]$c1.Result.majorGaps -eq 0)

Write-Host ""

# ---------------------------------------------------------------
# Case 2: Phase 1 schema + mutate entry + backend-parity missing mutations → BLOCKED
# ---------------------------------------------------------------
Write-Host "  Case 2: Phase-1 schema, mutate entry, backend has 3 missing mutations -> BLOCKED" -ForegroundColor DarkCyan
$c2 = Invoke-LedgerCase -LedgerJson $mutateSchemaLedger -BackendScanJson $backendWithGaps -UiScanJson $uiNoPlaceholders
Assert-That 'case2: exits 2 (blocked)' ($c2.ExitCode -eq 2)
Assert-That 'case2: hasEffectClassSchema is true' ($c2.Result -and $c2.Result.hasEffectClassSchema -eq $true)
Assert-That 'case2: mutate entry counted' ($c2.Result -and [int]$c2.Result.byEffectClass.mutate.total -eq 1)
Assert-That 'case2: mutate entry is unimplemented' ($c2.Result -and [int]$c2.Result.byEffectClass.mutate.unimplemented -eq 1)
Assert-That 'case2: majorGaps is 1' ($c2.Result -and [int]$c2.Result.majorGaps -ge 1)

Write-Host ""

# ---------------------------------------------------------------
# Case 3: Phase 1 schema + mutate entry + backend has 0 missing mutations → PASS
# ---------------------------------------------------------------
Write-Host "  Case 3: Phase-1 schema, mutate entry, backend fully ported -> PASS" -ForegroundColor DarkCyan
$c3 = Invoke-LedgerCase -LedgerJson $mutateSchemaLedger -BackendScanJson $backendNoGaps -UiScanJson $uiNoPlaceholders -ControllerContent $implementedController
Assert-That 'case3: exits 0 (pass)' ($c3.ExitCode -eq 0)
Assert-That 'case3: mutate entry is implemented' ($c3.Result -and [int]$c3.Result.byEffectClass.mutate.implemented -eq 1)
Assert-That 'case3: majorGaps is 0' ($c3.Result -and [int]$c3.Result.majorGaps -eq 0)

Write-Host ""

# ---------------------------------------------------------------
# Case 4: Phase 1 schema + filter entry + UI scan has PlaceholderActions → BLOCKED
# ---------------------------------------------------------------
Write-Host "  Case 4: Phase-1 schema, filter entry, UI scan has PlaceholderAction -> BLOCKED" -ForegroundColor DarkCyan
$c4 = Invoke-LedgerCase -LedgerJson $filterSchemaLedger -BackendScanJson $backendNoGaps -UiScanJson $uiWithPlaceholders
Assert-That 'case4: exits 2 (blocked)' ($c4.ExitCode -eq 2)
Assert-That 'case4: filter entry is unimplemented' ($c4.Result -and [int]$c4.Result.byEffectClass.filter.unimplemented -eq 1)
Assert-That 'case4: majorGaps includes filter' ($c4.Result -and [int]$c4.Result.majorGaps -ge 1)

Write-Host ""

# ---------------------------------------------------------------
# Case 5: Blocking mutate entry with a registry waiver → PASS (waiver respected)
# ---------------------------------------------------------------
Write-Host "  Case 5: mutate entry blocked, registry waiver present -> PASS (waiver respected)" -ForegroundColor DarkCyan
$c5 = Invoke-LedgerCase -LedgerJson $mutateSchemaLedger -BackendScanJson $backendWithGaps -UiScanJson $uiNoPlaceholders -RegistryJson $waiverForAddRow
Assert-That 'case5: exits 0 (waiver clears block)' ($c5.ExitCode -eq 0)
Assert-That 'case5: mutate entry counted as waived' ($c5.Result -and [int]$c5.Result.byEffectClass.mutate.waived -eq 1)
Assert-That 'case5: majorGaps is 0' ($c5.Result -and [int]$c5.Result.majorGaps -eq 0)

Write-Host ""

# ---------------------------------------------------------------
# Case 6: navigate entry whose route is NOT in modern routes.config.ts → Minor (non-blocking)
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
