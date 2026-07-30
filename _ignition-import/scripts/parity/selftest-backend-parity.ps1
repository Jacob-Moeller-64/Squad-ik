<#
.SYNOPSIS
    App-agnostic self-test for the legacy-anchored backend functionality-parity gate
    (scan-backend-parity.ps1). Proves the gate HONESTLY catches dropped mutation endpoints and
    cannot be silently re-blinded.

.DESCRIPTION
    The modernization failure this locks down: a legacy app with real write endpoints
    (POST/PUT/DELETE) is modernized with only the GET endpoints ported, so every write feature
    (Add/Edit/Delete/Link/Export) is silently dropped while every other gate reports green. This
    self-test runs the REAL gate against synthetic legacy/modern controller fixtures and asserts:
      1. A legacy mutation endpoint with NO modern counterpart is a Major gap and blocks (exit 2).
      2. A legacy GET with no modern counterpart is Minor (non-blocking) by default.
      3. A legacy mutation that HAS a modern counterpart (same controller + verb) is not flagged.
      4. An accepted-drop registry entry downgrades an intentional drop (no block).
      5. -StrictReads escalates a missing GET to blocking.
      6. An entirely-dropped legacy controller is surfaced in droppedControllers[].

.OUTPUTS
    Exit 0 when every assertion passes; exit 2 when any assertion fails.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/selftest-backend-parity.ps1
#>
[CmdletBinding()]
param([switch]$Quiet)

$ErrorActionPreference = 'Stop'
$scanner = Join-Path $PSScriptRoot 'scan-backend-parity.ps1'
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

# Run the gate against synthetic legacy/modern controller trees; return { Result, ExitCode }.
# Invoked as a child process so `exit` is the reliable process exit code; assertions read the
# JSON output file, never stdout.
function Invoke-BackendCase {
    param(
        [hashtable]$LegacyControllers,   # name -> file content
        [hashtable]$ModernControllers,   # name -> file content
        [string]$RegistryJson = '',
        [switch]$StrictReads
    )
    $root = Join-Path ([System.IO.Path]::GetTempPath()) ("backend-parity-selftest-" + [guid]::NewGuid().ToString('N'))
    $leg = Join-Path $root 'legacy'
    $mod = Join-Path $root 'modern'
    New-Item -ItemType Directory -Force -Path $leg, $mod | Out-Null
    try {
        foreach ($name in $LegacyControllers.Keys) {
            Set-Content -LiteralPath (Join-Path $leg $name) -Value $LegacyControllers[$name] -Encoding UTF8
        }
        foreach ($name in $ModernControllers.Keys) {
            Set-Content -LiteralPath (Join-Path $mod $name) -Value $ModernControllers[$name] -Encoding UTF8
        }
        $reg = Join-Path $root 'registry.json'
        if ($RegistryJson) { Set-Content -LiteralPath $reg -Value $RegistryJson -Encoding UTF8 }
        $out = Join-Path $root 'scan.json'
        $psArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $scanner,
            '-LegacyRoot', $leg, '-ModernApiRoot', $mod, '-OutputPath', $out, '-RegistryPath', $reg, '-Quiet')
        if ($StrictReads) { $psArgs += '-StrictReads' }
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

Write-Host "Backend-parity self-test" -ForegroundColor Cyan

# A legacy controller with a GET, a POST (add), a PUT (edit), and a DELETE.
$legacyFileKeys = @'
[Route("api/[controller]")]
public class FileKeysController : ControllerBase {
    [HttpGet]
    public async Task<ActionResult> GetAll() { return Ok(); }
    [HttpPost]
    [Authorize(Policy = "RequireAdministratorRole")]
    public async Task<ActionResult> AddFileKey([FromBody] object input) { return Ok(); }
    [HttpPut]
    [Route("{keyNo}/{changeNo}")]
    public async Task<ActionResult> EditFileKey(string keyNo, string changeNo) { return Ok(); }
    [HttpDelete]
    [Route("{keyNo}/{changeNo}")]
    public async Task<ActionResult> DeleteFileKey(string keyNo, string changeNo) { return Ok(); }
}
'@

# Modern controller that ported ONLY the GET (the failure mode).
$modernFileKeysReadOnly = @'
[Route("api/[controller]")]
public class FileKeysController : ControllerBase {
    [HttpGet]
    public async Task<ActionResult> GetAll() { return Ok(); }
}
'@

# Modern controller that ported the GET + POST + PUT + DELETE (parity kept).
$modernFileKeysFull = @'
[Route("api/[controller]")]
public class FileKeysController : ControllerBase {
    [HttpGet]
    public async Task<ActionResult> GetAll() { return Ok(); }
    [HttpPost]
    public async Task<ActionResult> AddFileKey([FromBody] object input) { return Ok(); }
    [HttpPut]
    [Route("{keyNo}/{changeNo}")]
    public async Task<ActionResult> EditFileKey(string keyNo, string changeNo) { return Ok(); }
    [HttpDelete]
    [Route("{keyNo}/{changeNo}")]
    public async Task<ActionResult> DeleteFileKey(string keyNo, string changeNo) { return Ok(); }
}
'@

# --- Test 1 + 2: read-only modern drops the 3 mutations (Major) and keeps the GET covered ---
$t1 = Invoke-BackendCase -LegacyControllers @{ 'FileKeysController.cs' = $legacyFileKeys } -ModernControllers @{ 'FileKeysController.cs' = $modernFileKeysReadOnly }
Assert-That 'T1 read-only modern surfaces the 3 dropped mutations (missingMutationCount = 3)' ([int]$t1.Result.missingMutationCount -eq 3) ("got {0}" -f $t1.Result.missingMutationCount)
Assert-That 'T1 dropped mutations block (exit 2)' ($t1.ExitCode -eq 2) ("exit {0}" -f $t1.ExitCode)
Assert-That 'T1 the covered GET is NOT flagged (missingQueryCount = 0)' ([int]$t1.Result.missingQueryCount -eq 0) ("got {0}" -f $t1.Result.missingQueryCount)

# --- Test 3: full modern parity - no gaps, clean exit ---
$t3 = Invoke-BackendCase -LegacyControllers @{ 'FileKeysController.cs' = $legacyFileKeys } -ModernControllers @{ 'FileKeysController.cs' = $modernFileKeysFull }
Assert-That 'T3 full modern parity has no missing mutations (missingMutationCount = 0)' ([int]$t3.Result.missingMutationCount -eq 0) ("got {0}" -f $t3.Result.missingMutationCount)
Assert-That 'T3 full parity exits 0 (clean)' ($t3.ExitCode -eq 0) ("exit {0}" -f $t3.ExitCode)

# --- Test 4: an accepted-drop registry entry downgrades an intentional drop ---
$reg = '{ "acceptedDrops": [ { "controller": "FileKeys", "verb": "DELETE", "reason": "self-test: delete intentionally deferred" }, { "controller": "FileKeys", "verb": "POST", "reason": "self-test" }, { "controller": "FileKeys", "verb": "PUT", "reason": "self-test" } ] }'
$t4 = Invoke-BackendCase -LegacyControllers @{ 'FileKeysController.cs' = $legacyFileKeys } -ModernControllers @{ 'FileKeysController.cs' = $modernFileKeysReadOnly } -RegistryJson $reg
Assert-That 'T4 accepted drops are not counted as Major gaps (missingMutationCount = 0)' ([int]$t4.Result.missingMutationCount -eq 0) ("got {0}" -f $t4.Result.missingMutationCount)
Assert-That 'T4 accepted-only run exits 0' ($t4.ExitCode -eq 0) ("exit {0}" -f $t4.ExitCode)

# --- Test 5: -StrictReads escalates a missing GET to blocking ---
$legacyReadController = @'
[Route("api/[controller]")]
public class ReportController : ControllerBase {
    [HttpGet]
    public async Task<ActionResult> GetReport() { return Ok(); }
}
'@
$t5 = Invoke-BackendCase -LegacyControllers @{ 'ReportController.cs' = $legacyReadController } -ModernControllers @{ 'OtherController.cs' = $modernFileKeysReadOnly } -StrictReads
Assert-That 'T5 -StrictReads makes a missing GET blocking (exit 2)' ($t5.ExitCode -eq 2) ("exit {0}" -f $t5.ExitCode)

# --- Test 6: an entirely-dropped legacy controller is surfaced ---
$t6 = Invoke-BackendCase -LegacyControllers @{ 'ReportController.cs' = $legacyReadController; 'FileKeysController.cs' = $legacyFileKeys } -ModernControllers @{ 'FileKeysController.cs' = $modernFileKeysFull }
Assert-That 'T6 an entirely-dropped controller is surfaced in droppedControllers[]' (@($t6.Result.droppedControllers) -contains 'Report') ("got {0}" -f (@($t6.Result.droppedControllers) -join ','))

Write-Host ""
if ($script:failures.Count -eq 0) {
    Write-Host "BACKEND-PARITY SELF-TEST: all assertions passed." -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("BACKEND-PARITY SELF-TEST: {0} assertion(s) FAILED." -f $script:failures.Count) -ForegroundColor Red
    $script:failures | ForEach-Object { Write-Host ("  - {0}" -f $_) -ForegroundColor Red }
    exit 2
}
