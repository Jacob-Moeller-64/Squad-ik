<#
.SYNOPSIS
    Functional Parity Ledger scanner. Reads the interaction-wiring-inventory (the
    legacy control census built at Step 3) and determines how many entries have
    reached the Implemented lifecycle state in src/ vs how many are still at
    Inventoried -- meaning the modernized app is missing that behavior entirely.

.DESCRIPTION
    The Functional Parity Ledger is the single contract that travels the full
    24-step lifecycle. Every interactive legacy control starts at Inventoried
    (Step 3) and must reach Verified before a step can close. This scanner
    computes the current state of each control family by cross-referencing:

      mutate/read      - against backend-parity-scan.json (tracks missing API endpoints)
      navigate         - against routes declared in src/ routes.config.ts
      filter           - against PlaceholderAction count in ui-parity-gap-scan.json
      export           - against export/download methods in src/ controllers
      open-dialog      - static check only; must reach Verified at runtime checkpoint
      ui-only          - always Verified (no backend proof needed)

    This scanner answers "what legacy behaviors are STILL missing from the
    modernized app?" -- the question no earlier gate was asking.

    Waivers (intentional accepted drops with a written reason) are read from
    functional-parity-registry.json and excluded from the blocking count.

.PARAMETER RepoRoot
    Workspace root. Defaults to two levels above this script's directory.

.PARAMETER Quiet
    Suppress per-gap detail lines. Still emits the RESULT: line and exit code.

.OUTPUTS
    .modernization/ignition-artifacts/discovery/functional-parity-ledger-scan.json
    Exit 0 when no unimplemented in-scope blocking entries remain.
    Exit 2 when any mutate, read, or filter entry is unimplemented with no waiver.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-functional-parity-ledger.ps1
#>
[CmdletBinding()]
param(
    [string]$RepoRoot,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
if (-not $RepoRoot -or [string]::IsNullOrWhiteSpace($RepoRoot)) {
    # .github/scripts/parity -> .github/scripts -> .github -> repo root
    $RepoRoot = (Get-Item $PSScriptRoot).Parent.Parent.Parent.FullName
}

# ---------------------------------------------------------------
# Artifact paths
# ---------------------------------------------------------------
$discoveryRoot   = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery'
$ledgerPath      = Join-Path $discoveryRoot 'interaction-wiring-inventory.json'
$backendScanPath = Join-Path $discoveryRoot 'backend-parity-scan.json'
$uiScanPath      = Join-Path $discoveryRoot 'ui-parity-gap-scan.json'
$registryPath    = Join-Path $discoveryRoot 'functional-parity-registry.json'
$outputPath      = Join-Path $discoveryRoot 'functional-parity-ledger-scan.json'

# ---------------------------------------------------------------
# Load ledger
# ---------------------------------------------------------------
if (-not (Test-Path -LiteralPath $ledgerPath)) {
    Write-Host "BLOCKED: interaction-wiring-inventory.json not found. Run Step 3 (03-P1-generate-manifest.ps1) first." -ForegroundColor Red
    exit 2
}

$ledgerDoc = Get-Content -LiteralPath $ledgerPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
$entries   = @(if ($ledgerDoc.PSObject.Properties.Name -contains 'entries' -and $ledgerDoc.entries) { $ledgerDoc.entries } else { @() })

# Detect whether the ledger was generated with the Phase 1 effectClass schema.
# If not, the scanner degrades gracefully: treats all entries as ui-only and warns.
$hasEffectClassSchema = ($entries.Count -gt 0 -and
    ($entries | Where-Object { $null -ne $_.PSObject.Properties['effectClass'] } | Select-Object -First 1) -ne $null)

if (-not $Quiet) {
    Write-Host "FUNCTIONAL PARITY LEDGER SCAN" -ForegroundColor Cyan
    Write-Host ("  Ledger        : {0} entries (Phase-1 schema: {1})" -f $entries.Count, $hasEffectClassSchema)
}

# ---------------------------------------------------------------
# Load acceptance registry (waivers for intentional drops / future deferrals)
# ---------------------------------------------------------------
$acceptedDrops = @()
if (Test-Path -LiteralPath $registryPath) {
    try {
        $reg = Get-Content -LiteralPath $registryPath -Raw | ConvertFrom-Json
        if ($reg.PSObject.Properties.Name -contains 'acceptedDrops' -and $reg.acceptedDrops) {
            $acceptedDrops = @($reg.acceptedDrops)
        }
    } catch { }
}

function Test-IsWaived {
    param($entry)
    # An entry-level waiver field set during Step 6/9/12 takes precedence.
    if ($null -ne $entry.PSObject.Properties['waiver'] -and $null -ne $entry.waiver) { return $true }
    # Registry-level pattern waivers match by effectClass and/or label regex.
    foreach ($drop in $acceptedDrops) {
        $ecOk  = (-not $drop.PSObject.Properties['effectClass'] -or [string]::IsNullOrWhiteSpace([string]$drop.effectClass) -or
                  ([string]$drop.effectClass -ieq [string]$entry.effectClass))
        $lblOk = (-not $drop.PSObject.Properties['labelPattern'] -or [string]::IsNullOrWhiteSpace([string]$drop.labelPattern) -or
                  ([string]$entry.label -imatch [string]$drop.labelPattern))
        if ($ecOk -and $lblOk) { return $true }
    }
    return $false
}

# ---------------------------------------------------------------
# Load backend parity scan (used for mutate/read implementation status)
# ---------------------------------------------------------------
$missingMutCount    = 0
$missingQueryCount  = 0
$droppedControllers = @()
$backendScanAge     = ''
if (Test-Path -LiteralPath $backendScanPath) {
    try {
        $bp = Get-Content -LiteralPath $backendScanPath -Raw | ConvertFrom-Json
        $missingMutCount   = if ($bp.PSObject.Properties.Name -contains 'missingMutationCount') { [int]$bp.missingMutationCount } else { 0 }
        $missingQueryCount = if ($bp.PSObject.Properties.Name -contains 'missingQueryCount')    { [int]$bp.missingQueryCount    } else { 0 }
        if ($bp.PSObject.Properties.Name -contains 'droppedControllers' -and $bp.droppedControllers) {
            $droppedControllers = @($bp.droppedControllers | ForEach-Object { [string]$_ })
        }
        $backendScanAge = if ($bp.PSObject.Properties.Name -contains 'generatedUtc') { [string]$bp.generatedUtc } else { 'unknown' }
    } catch { }
}

# ---------------------------------------------------------------
# Load UI parity scan (filter PlaceholderAction count)
# ---------------------------------------------------------------
$placeholderActionCount = 0
if (Test-Path -LiteralPath $uiScanPath) {
    try {
        $ui = Get-Content -LiteralPath $uiScanPath -Raw | ConvertFrom-Json
        if ($ui.PSObject.Properties.Name -contains 'byKind' -and $ui.byKind) {
            $paEntry = @($ui.byKind | Where-Object { [string]$_.Name -ieq 'PlaceholderAction' }) | Select-Object -First 1
            if ($paEntry) {
                $cntProp = $paEntry.PSObject.Properties['Count']
                $placeholderActionCount = if ($cntProp) { [int]$cntProp.Value } else { 0 }
            }
        }
    } catch { }
}

# ---------------------------------------------------------------
# Load modern route paths from routes.config.ts files in src/
# ---------------------------------------------------------------
$modernRoutePaths = New-Object System.Collections.Generic.List[string]
$routeConfigFiles = @(Get-ChildItem -Path (Join-Path $RepoRoot 'src') -Recurse -Filter 'routes.config.ts' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch '\\node_modules\\|\\dist\\' })
foreach ($rc in $routeConfigFiles) {
    $text = Get-Content -LiteralPath $rc.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($text)) { continue }
    foreach ($m in [regex]::Matches($text, "(?i)path\s*:\s*['""](?<p>[^'""]+)['""]")) {
        $p = [string]$m.Groups['p'].Value.Trim()
        if ($p -and $p -ne '**') { $modernRoutePaths.Add($p.TrimStart('/')) | Out-Null }
    }
}
$modernRoutePaths = @($modernRoutePaths | Sort-Object -Unique)

# ---------------------------------------------------------------
# Load modern controller methods for mutation and query coverage
# ---------------------------------------------------------------
$modernMutationMethods = New-Object System.Collections.Generic.List[string]
$modernQueryMethods    = New-Object System.Collections.Generic.List[string]
$hasExportEndpoint     = $false
$srcRoot = Join-Path $RepoRoot 'src'
if (Test-Path -LiteralPath $srcRoot) {
    $controllerFiles = @(Get-ChildItem -Path $srcRoot -Recurse -Filter '*Controller.cs' -ErrorAction SilentlyContinue)
    foreach ($cf in $controllerFiles) {
        $text = Get-Content -LiteralPath $cf.FullName -Raw -ErrorAction SilentlyContinue
        if ([string]::IsNullOrWhiteSpace($text)) { continue }
        foreach ($m in [regex]::Matches($text, '(?i)\[Http(?:Post|Put|Delete|Patch)\]')) {
            $modernMutationMethods.Add('found') | Out-Null
        }
        foreach ($m in [regex]::Matches($text, '(?i)\[HttpGet\]')) {
            $modernQueryMethods.Add('found') | Out-Null
        }
        if ($text -match '(?i)export|download|FileContentResult|FileStreamResult|\.csv\b|\.xlsx\b|pdf') {
            $hasExportEndpoint = $true
        }
    }
}
$modernMutationCount = $modernMutationMethods.Count
$modernQueryCount    = $modernQueryMethods.Count

# ---------------------------------------------------------------
# Classify each entry and compute lifecycle state
# ---------------------------------------------------------------
$allEffectClasses = @('mutate','read','filter','navigate','export','open-dialog','ui-only')
$summary = @{}
foreach ($ec in $allEffectClasses) {
    $summary[$ec] = [ordered]@{ total=0; implemented=0; unimplemented=0; waived=0 }
}

$blockingGaps = New-Object System.Collections.Generic.List[object]

foreach ($entry in $entries) {
    # Determine effectClass: use Phase 1 field when present, fall back to 'ui-only'.
    $ec = 'ui-only'
    if ($hasEffectClassSchema) {
        $ecProp = $entry.PSObject.Properties['effectClass']
        if ($ecProp -and -not [string]::IsNullOrWhiteSpace([string]$ecProp.Value)) {
            $ec = [string]$ecProp.Value.ToLowerInvariant()
        }
    }
    if (-not $summary.ContainsKey($ec)) { $summary[$ec] = [ordered]@{ total=0; implemented=0; unimplemented=0; waived=0 } }
    $summary[$ec].total++

    # Waivers count as implemented for blocking purposes.
    if (Test-IsWaived $entry) {
        $summary[$ec].waived++
        continue
    }

    # Determine implementation status per effectClass.
    $isImplemented = switch ($ec) {
        'ui-only' {
            # Pure UI toggles never need backend proof.
            $true
        }
        'navigate' {
            # Implemented when the resolved/derived route exists in modern routes.config.ts.
            $rtProp  = $entry.PSObject.Properties['resolvedTarget']; $rt  = if ($rtProp)  { [string]$rtProp.Value }  else { '' }
            $lblProp = $entry.PSObject.Properties['label'];          $lbl = if ($lblProp) { [string]$lblProp.Value } else { '' }
            $found = $false
            if (-not [string]::IsNullOrWhiteSpace($rt)) {
                $cleanRt = $rt.TrimStart('/')
                $found = ($modernRoutePaths | Where-Object { $_ -ieq $cleanRt -or $cleanRt -imatch ('^' + [regex]::Escape($_)) }) -as [bool]
            }
            if (-not $found -and -not [string]::IsNullOrWhiteSpace($lbl)) {
                $slug = ($lbl -replace '\s+', '-' -replace '[^a-z0-9\-]', '').ToLowerInvariant()
                $found = ($modernRoutePaths | Where-Object { $_ -match $slug -or $slug -match $_ }) -as [bool]
            }
            $found
        }
        'mutate' {
            # Implemented only when the modern API has mutation methods AND
            # backend-parity-scan confirms 0 missing legacy mutation endpoints.
            # Any missing mutation means at least one mutate ledger entry is unimplemented.
            ($missingMutCount -eq 0 -and $modernMutationCount -gt 0)
        }
        'read' {
            # Implemented when modern API has GET endpoints AND no missing query endpoints.
            ($missingQueryCount -eq 0 -and $modernQueryCount -gt 0)
        }
        'filter' {
            # Implemented when zero PlaceholderAction controls exist in the UI parity scan.
            # A PlaceholderAction means a filter button opens a modal stub instead of calling
            # a real filter endpoint -- the exact broken-filter symptom you described.
            ($placeholderActionCount -eq 0)
        }
        'export' {
            # Implemented when at least one export/download endpoint exists in modern src/.
            $hasExportEndpoint
        }
        'open-dialog' {
            # Cannot be verified statically. Must reach Verified at the Step 12/13 runtime
            # checkpoint by observing the dialog render and confirming its own controls are
            # ledgered. Reported as a Minor gap (not blocking) until that checkpoint runs.
            $false
        }
        default { $false }
    }

    if ($isImplemented) {
        $summary[$ec].implemented++
    } else {
        $summary[$ec].unimplemented++
        # Major (blocking): mutate, read, filter -- direct user-facing functionality loss.
        # Minor (informational): navigate, export, open-dialog.
        $isMajor = $ec -in @('mutate', 'read', 'filter')
        $reason = switch ($ec) {
            'mutate'      { "backend-parity-scan reports $missingMutCount missing mutation endpoint(s). Port the missing POST/PUT/DELETE/PATCH methods and re-run scan-backend-parity.ps1 to clear this." }
            'read'        { "backend-parity-scan reports $missingQueryCount missing query endpoint(s). Port the missing GET methods." }
            'filter'      { "ui-parity-gap-scan detected $placeholderActionCount PlaceholderAction control(s): filter/search buttons open placeholder modals instead of calling real query endpoints." }
            'navigate'    { "Route not found in modern routes.config.ts. Declare the missing route or check the resolvedTarget value in the ledger." }
            'export'      { "No export/download endpoint or FileResult return type found in modern src/ controllers." }
            'open-dialog' { "Dialog cannot be verified statically. Must be confirmed at Step 12/13 runtime checkpoint: dialog renders and all its own controls are separately ledgered and verified." }
            default       { "Not yet implemented in modern src/." }
        }
        $blockingGaps.Add([ordered]@{
            controlId     = [string]($entry.PSObject.Properties['controlId'] | ForEach-Object { $_.Value })
            label         = [string]($entry.PSObject.Properties['label']     | ForEach-Object { $_.Value })
            effectClass   = $ec
            surface       = [string]($entry.PSObject.Properties['surface']   | ForEach-Object { $_.Value })
            severity      = if ($isMajor) { 'Major' } else { 'Minor' }
            computedState = 'Inventoried'
            reason        = $reason
        }) | Out-Null
    }
}

# De-duplicate: one representative blocking entry per effectClass (since most entries
# of the same class share the same root cause -- e.g. all mutate entries are unimplemented
# because the same 37 backend mutations are missing). Keep a representative sample + total.
$deduped = New-Object System.Collections.Generic.List[object]
$ecSeen  = @{}
foreach ($gap in $blockingGaps) {
    $key = [string]$gap['effectClass']
    if (-not $ecSeen.ContainsKey($key)) { $ecSeen[$key] = 0 }
    $ecSeen[$key]++
    if ($ecSeen[$key] -le 3) { $deduped.Add($gap) | Out-Null }   # show first 3 per class
}

$majorGaps = @($blockingGaps | Where-Object { $_['severity'] -eq 'Major' }).Count
$minorGaps = @($blockingGaps | Where-Object { $_['severity'] -eq 'Minor' }).Count

# ---------------------------------------------------------------
# Write output artifact
# ---------------------------------------------------------------
$result = [ordered]@{
    generatedUtc         = (Get-Date).ToUniversalTime().ToString('o')
    ledgerPath           = $ledgerPath
    repoRoot             = $RepoRoot
    totalEntries         = $entries.Count
    hasEffectClassSchema = $hasEffectClassSchema
    byEffectClass        = $summary
    majorGaps            = $majorGaps
    minorGaps            = $minorGaps
    blockingGaps         = $deduped.ToArray()
    registryPath         = $registryPath
    acceptedDropCount    = $acceptedDrops.Count
    inputs               = [ordered]@{
        backendParityGeneratedUtc = $backendScanAge
        missingMutations          = $missingMutCount
        missingQueries            = $missingQueryCount
        droppedControllers        = $droppedControllers
        placeholderActions        = $placeholderActionCount
        modernRoutePaths          = $modernRoutePaths.Count
        modernMutationMethods     = $modernMutationCount
        modernQueryMethods        = $modernQueryCount
        hasExportEndpoint         = $hasExportEndpoint
    }
    note = 'Functional Parity Ledger: every interactive legacy control must reach Verified (or Waived) before its owning step can close. This scanner computes Implemented state per effectClass by cross-referencing the Step 3 inventory against live modern src/ artifacts. A mutate entry that is Inventoried means the legacy write functionality was never ported - Add/Edit/Delete still does not exist in the modernized app.'
}

$result | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $outputPath -Encoding UTF8

# ---------------------------------------------------------------
# Console output
# ---------------------------------------------------------------
if (-not $Quiet) {
    Write-Host ""
    Write-Host ("  {0,-12} {1,6} {2,8} {3,10} {4,7}" -f 'effectClass','total','implmntd','unimplmntd','waived')
    Write-Host ("  " + ("-" * 52))
    foreach ($k in $allEffectClasses) {
        $s = $summary[$k]
        if ($s.total -eq 0) { continue }
        $color = if ($s.unimplemented -gt 0 -and $k -in @('mutate','read','filter')) { 'Red' }
                 elseif ($s.unimplemented -gt 0) { 'Yellow' }
                 else { 'Green' }
        Write-Host ("  {0,-12} {1,6} {2,8} {3,10} {4,7}" -f $k, $s.total, $s.implemented, $s.unimplemented, $s.waived) -ForegroundColor $color
    }
    Write-Host ""
    Write-Host ("  Major gaps (mutate/read/filter): $majorGaps") -ForegroundColor $(if ($majorGaps -gt 0) { 'Red' } else { 'Green' })
    Write-Host ("  Minor gaps (navigate/export/dialog): $minorGaps") -ForegroundColor $(if ($minorGaps -gt 0) { 'Yellow' } else { 'Green' })
    Write-Host ""
    Write-Host "Output -> $outputPath"
    Write-Host ""
}

if ($majorGaps -gt 0) {
    if (-not $Quiet) {
        Write-Host ("RESULT: BLOCKED ({0} major gap(s) -- legacy behaviors not yet ported to modern src/)" -f $majorGaps) -ForegroundColor Red
    }
    exit 2
}

if (-not $Quiet) {
    Write-Host "RESULT: OK" -ForegroundColor Green
}
exit 0
