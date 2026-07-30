<#
.SYNOPSIS
    Legacy-anchored backend functionality-parity scanner: proves every legacy backend endpoint -
    ESPECIALLY every mutation (POST / PUT / DELETE / PATCH) - has a modern counterpart, so the
    modernization cannot silently drop write functionality the legacy app shipped.

.DESCRIPTION
    THE FAILURE MODE THIS EXISTS TO CATCH
    A modernization can rebuild the READ path (queries, grids, search) perfectly and render live
    data, while quietly dropping the entire WRITE path (Add / Edit / Delete / Link / Export). The
    UI still shows the buttons - they open placeholder modals - so the UI parity scanner (which
    checks the label is present and the click handler is non-empty) reports green. The UI->API
    wiring gate also passes, because the modern client only calls the GET endpoints that remain,
    so there are no "broken" calls. Nothing was comparing the LEGACY backend surface to the MODERN
    backend surface, so a real regression (e.g. 35 legacy mutation endpoints -> 0 modern) shipped
    green. Every other gate verifies "what EXISTS in modern is wired"; none verified "everything in
    LEGACY was carried over". That direction is backwards for catching MISSES - this gate fixes it.

    WHAT IT DOES (deterministic, content-only, no running app)
    Walks legacy and modern ASP.NET controllers, extracts every action endpoint as
    (controllerBase, httpVerb, routeTemplate, methodName, isMutation, authPolicy), and reconciles
    each legacy endpoint against the modern surface:
      - A legacy endpoint is COVERED when a modern endpoint shares the same controller base name
        and the same HTTP verb (route-template shape is reported but not required to match, because
        modern routes are often reshaped - a missing verb on a controller is the real defect).
      - A legacy MUTATION endpoint (POST / PUT / DELETE / PATCH) with no modern counterpart is a
        MAJOR gap (dropped write functionality) and blocks (exit 2).
      - A legacy GET endpoint with no modern counterpart is a MINOR gap (reads are sometimes
        consolidated); reported, never silently dropped, but non-blocking by default.
    Intentionally out-of-scope legacy controllers/endpoints are declared in the per-app registry
    (backend-parity-registry.json) with a written reason, exactly like the other kit gates - so the
    drop stays VISIBLE and OWNED instead of hidden.

    GENERIC: any C# ASP.NET (Framework or Core) legacy->modern modernization. Controller and verb
    extraction is attribute-driven ([Route], [Http*]); no app-specific controller names are baked in.

.OUTPUTS
    .modernization/ignition-artifacts/discovery/backend-parity-scan.json

    Exit codes:
      0 = no missing legacy MUTATION endpoints (every legacy write has a modern counterpart or an
          accepted registry waiver)
      2 = at least one legacy mutation endpoint has no modern counterpart and no accepted waiver

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-backend-parity.ps1 -Quiet
#>
param(
    [string]$LegacyRoot = '.\LegacyCode',
    # Modern API project root. When omitted, derived from kit-params appName as src/<App>.Web.Api.
    [string]$ModernApiRoot = '',
    [string]$OutputPath = '.\.modernization\ignition-artifacts\discovery\backend-parity-scan.json',
    # Optional per-app registry of intentionally-dropped or deferred legacy endpoints/controllers.
    # When omitted, defaults to 'backend-parity-registry.json' beside the output file.
    [string]$RegistryPath = '',
    # When set, a missing legacy GET endpoint is also treated as blocking (strict read parity).
    # Off by default because reads are often legitimately consolidated in the modern surface.
    [switch]$StrictReads,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------
# Resolve the modern API root from kit-params when not passed explicitly.
# ---------------------------------------------------------------
if (-not $ModernApiRoot -or [string]::IsNullOrWhiteSpace($ModernApiRoot)) {
    $kitParams = Join-Path (Get-Location) '.modernization\.readme\kit-params.md'
    if (Test-Path $kitParams) {
        $appNameMatch = Select-String -Path $kitParams -Pattern '^appName:\s*(.+)$' | Select-Object -First 1
        if ($appNameMatch) {
            $appName = $appNameMatch.Matches[0].Groups[1].Value.Trim()
            $candidate = Join-Path (Get-Location) ("src\{0}.Web.Api" -f $appName)
            if (Test-Path $candidate) { $ModernApiRoot = $candidate }
        }
    }
    if (-not $ModernApiRoot -or [string]::IsNullOrWhiteSpace($ModernApiRoot)) {
        # Fallback: the first *.Web.Api folder under src.
        $srcApi = Get-ChildItem -Path (Join-Path (Get-Location) 'src') -Directory -Filter '*.Web.Api' -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($srcApi) { $ModernApiRoot = $srcApi.FullName }
    }
    if (-not $ModernApiRoot -or [string]::IsNullOrWhiteSpace($ModernApiRoot)) {
        throw "Could not determine ModernApiRoot. Pass -ModernApiRoot or populate .modernization/.readme/kit-params.md with appName."
    }
}

# ---------------------------------------------------------------
# Load the per-app registry of accepted (intentionally-dropped/deferred) endpoints.
# Each entry: { controller?, verb?, reason }. A blank controller/verb matches any.
# ---------------------------------------------------------------
$acceptedDrops = @()
if (-not $RegistryPath -or [string]::IsNullOrWhiteSpace($RegistryPath)) {
    $RegistryPath = Join-Path (Split-Path $OutputPath -Parent) 'backend-parity-registry.json'
}
if (Test-Path $RegistryPath) {
    try {
        $registry = Get-Content -LiteralPath $RegistryPath -Raw | ConvertFrom-Json
        $acceptedDrops = @($registry.acceptedDrops)
    } catch {
        Write-Verbose ("Could not parse backend-parity registry {0}: {1}" -f $RegistryPath, $_.Exception.Message)
    }
}

function Test-DropAccepted {
    param([string]$Controller, [string]$Verb)
    foreach ($a in $acceptedDrops) {
        if ($null -eq $a) { continue }
        $ctrlOk = (-not $a.controller) -or [string]::IsNullOrWhiteSpace([string]$a.controller) -or ($Controller -ieq [string]$a.controller)
        $verbOk = (-not $a.verb) -or [string]::IsNullOrWhiteSpace([string]$a.verb) -or ($Verb -ieq [string]$a.verb)
        if ($ctrlOk -and $verbOk) { return $true }
    }
    return $false
}

# ---------------------------------------------------------------
# Extract endpoints from a set of controller files.
# Returns a list of [pscustomobject]{ controller, verb, route, method, isMutation, authPolicy, file }.
# ---------------------------------------------------------------
$mutationVerbs = @('POST', 'PUT', 'DELETE', 'PATCH')

function Get-Endpoints {
    param([string]$Root)
    $records = New-Object System.Collections.Generic.List[object]
    if (-not (Test-Path $Root)) { return $records }
    $excludePattern = '\\bin\\|\\obj\\|\\packages\\|node_modules|\\TestResults\\'
    $files = @(Get-ChildItem -Path (Join-Path $Root '*') -Recurse -Filter '*Controller*.cs' -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch $excludePattern })
    foreach ($f in $files) {
        $text = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $text) { continue }
        # Controller base name from the class declaration: "class FooController".
        $classMatch = [regex]::Match($text, '(?im)class\s+([A-Za-z0-9_]+?)Controller\b')
        if (-not $classMatch.Success) { continue }
        $controllerBase = $classMatch.Groups[1].Value
        # Walk each [Http<Verb>] attribute and attach the nearest following method + any [Route].
        foreach ($m in [regex]::Matches($text, '(?im)\[\s*Http(Get|Post|Put|Delete|Patch)\b')) {
            $verb = $m.Groups[1].Value.ToUpperInvariant()
            # Look at a window AFTER the attribute for a [Route("...")], [Authorize], and the method name.
            $tail = $text.Substring($m.Index, [Math]::Min(600, $text.Length - $m.Index))
            $routeMatch = [regex]::Match($tail, '(?i)\[\s*Route\s*\(\s*"([^"]*)"')
            $route = if ($routeMatch.Success) { $routeMatch.Groups[1].Value } else { '' }
            $authMatch = [regex]::Match($tail, '(?i)\[\s*Authorize[^\]]*Policy\s*=\s*"([^"]+)"')
            $authPolicy = if ($authMatch.Success) { $authMatch.Groups[1].Value } else { '' }
            # Method name: first "Task<...> Name(" or "ActionResult... Name(" after the attribute block.
            $methodMatch = [regex]::Match($tail, '(?im)(?:public|internal|protected)\s+(?:async\s+)?[A-Za-z0-9_<>,\[\]\.\s]+?\s+([A-Za-z0-9_]+)\s*\(')
            $method = if ($methodMatch.Success) { $methodMatch.Groups[1].Value } else { '' }
            $records.Add([pscustomobject]@{
                controller = $controllerBase
                verb       = $verb
                route      = $route
                method     = $method
                isMutation = ($mutationVerbs -contains $verb)
                authPolicy = $authPolicy
                file       = $f.FullName
            }) | Out-Null
        }
    }
    return $records
}

if (-not $Quiet) { Write-Host "Scanning legacy controllers under $LegacyRoot ..." }
$legacy = @(Get-Endpoints -Root $LegacyRoot)
if (-not $Quiet) { Write-Host "Scanning modern controllers under $ModernApiRoot ..." }
$modern = @(Get-Endpoints -Root $ModernApiRoot)

# Build a modern coverage set keyed by "controllerBase|verb" (case-insensitive).
$modernCoverage = New-Object System.Collections.Generic.HashSet[string] ([System.StringComparer]::OrdinalIgnoreCase)
foreach ($e in $modern) { [void]$modernCoverage.Add(("{0}|{1}" -f $e.controller, $e.verb)) }

# Reconcile: every legacy endpoint should have a modern (controller|verb) counterpart.
$gaps = New-Object System.Collections.Generic.List[object]
foreach ($e in $legacy) {
    $key = "{0}|{1}" -f $e.controller, $e.verb
    if ($modernCoverage.Contains($key)) { continue }
    if (Test-DropAccepted -Controller $e.controller -Verb $e.verb) { continue }
    $severity = if ($e.isMutation) { 'Major' } elseif ($StrictReads) { 'Major' } else { 'Minor' }
    $gaps.Add([pscustomobject]@{
        severity   = $severity
        controller = $e.controller
        verb       = $e.verb
        route      = $e.route
        method     = $e.method
        isMutation = $e.isMutation
        authPolicy = $e.authPolicy
        legacyFile = $e.file
        kind       = if ($e.isMutation) { 'MissingMutationEndpoint' } else { 'MissingQueryEndpoint' }
    }) | Out-Null
}

$legacyMutationCount = @($legacy | Where-Object { $_.isMutation }).Count
$modernMutationCount = @($modern | Where-Object { $_.isMutation }).Count
$majorGaps = @($gaps | Where-Object { $_.severity -eq 'Major' })
$minorGaps = @($gaps | Where-Object { $_.severity -eq 'Minor' })

# Controllers present in legacy but entirely absent from modern (all verbs dropped).
$legacyControllers = @($legacy | Select-Object -ExpandProperty controller -Unique)
$modernControllers = @($modern | Select-Object -ExpandProperty controller -Unique)
$droppedControllers = @($legacyControllers | Where-Object { $modernControllers -notcontains $_ -and -not (Test-DropAccepted -Controller $_ -Verb '') })

$result = [ordered]@{
    generatedUtc          = (Get-Date).ToUniversalTime().ToString('o')
    legacyRoot            = $LegacyRoot
    modernApiRoot         = $ModernApiRoot
    legacyEndpointCount   = $legacy.Count
    modernEndpointCount   = $modern.Count
    legacyMutationCount   = $legacyMutationCount
    modernMutationCount   = $modernMutationCount
    missingMutationCount  = $majorGaps.Count
    missingQueryCount     = $minorGaps.Count
    droppedControllers    = $droppedControllers
    majorGaps             = $majorGaps.Count
    minorGaps             = $minorGaps.Count
    gaps                  = $gaps.ToArray()
    registryPath          = $RegistryPath
    acceptedDropCount     = @($acceptedDrops).Count
    note                  = 'Legacy-anchored backend functionality parity. A legacy mutation (POST/PUT/DELETE/PATCH) with no modern counterpart is dropped write functionality and blocks. Declare intentional drops in backend-parity-registry.json with a reason.'
}

$outDir = Split-Path $OutputPath -Parent
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
($result | ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $OutputPath -Encoding UTF8

if (-not $Quiet) {
    Write-Host ''
    Write-Host ("BACKEND PARITY SCAN COMPLETE -> {0}" -f $OutputPath)
    Write-Host ("  Legacy endpoints : {0} ({1} mutations)" -f $legacy.Count, $legacyMutationCount)
    Write-Host ("  Modern endpoints : {0} ({1} mutations)" -f $modern.Count, $modernMutationCount)
    Write-Host ("  Missing mutations: {0} (Major - blocks)" -f $majorGaps.Count) -ForegroundColor $(if ($majorGaps.Count -gt 0) { 'Red' } else { 'Green' })
    Write-Host ("  Missing queries  : {0} (Minor)" -f $minorGaps.Count)
    if ($droppedControllers.Count -gt 0) {
        Write-Host ("  Dropped controllers: {0}" -f ($droppedControllers -join ', ')) -ForegroundColor Yellow
    }
    if ($majorGaps.Count -gt 0) {
        Write-Host '  Missing legacy mutation endpoints (dropped write functionality):' -ForegroundColor Red
        foreach ($g in ($majorGaps | Select-Object -First 40)) {
            Write-Host ("    [{0}] {1}Controller.{2} (route '{3}')" -f $g.verb, $g.controller, $g.method, $g.route) -ForegroundColor Red
        }
    }
}

if ($majorGaps.Count -gt 0) { exit 2 } else { exit 0 }
