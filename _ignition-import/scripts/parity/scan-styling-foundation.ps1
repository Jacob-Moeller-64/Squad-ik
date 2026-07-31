<#
.SYNOPSIS
    Deterministic styling-foundation gate for a modernized browser client.

.DESCRIPTION
    Static, app-agnostic checks that catch the visual-foundation failure modes a
    build / control-parity scan / HTTP-200 probe cannot see, so a Step 10 pass
    cannot be claimed from proxies while the running app renders the wrong color
    scheme, unbranded chrome, or full-bleed controls. These checks are mechanical
    and require no running app, so they hold on the first pass for any application:

      1. colorSchemePinned   - the client index.html must NOT silently follow the
                               workstation OS `prefers-color-scheme` (the browser
                               starter ships a script that adds a `dark-theme`
                               class from the OS media query). For a fixed-scheme
                               legacy app that makes the same build render light on
                               one machine and dark on another. The scheme must be
                               pinned to the legacy scheme.
      2. styleIncludePaths   - the client build must declare shared style include
                               paths (angular.json stylePreprocessorOptions.includePaths)
                               so per-component styles can `@use` shared layout
                               partials. Empty include paths is the root cause of
                               full-bleed controls (no shared layout system).
      3. sharedStylePartials - the declared include-path folder(s) must actually
                               contain shared partials (variables/mixins/layout),
                               not be empty.
      4. gridColumnWidths    - data-grid columns must declare explicit widths so the
                               grid renders at legacy density. A grid whose columns
                               are all auto-sized diverges from the legacy layout.

    The gate is data-driven: it derives the legacy fixed scheme from
    styling-foundation.json when present, discovers the client root and angular.json
    generically, and harvests grid columns app-agnostically. Document an intentional
    exception by adding the file/grid to the matching allowlist below with a reason,
    never by bypassing the gate.

.PARAMETER ModernClientRoot
    The Angular/browser client project folder that contains angular.json (for example
    src/<AppName>.Web.Client). Auto-discovered under src/ when not supplied.

.PARAMETER StylingFoundationPath
    Optional path to styling-foundation.json. Used to read colorSchemeForced.

.PARAMETER OutputPath
    Where to write the JSON result. Defaults to
    .modernization/legacy-analysis/styling-foundation-scan.json.

.OUTPUTS
    Exit 0 when every Major check passes (or is allowlisted); exit 2 when any
    Major check fails. The JSON result lists every check with status and detail.
#>
[CmdletBinding()]
param(
    [string]$ModernClientRoot,
    [string]$StylingFoundationPath,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Documented intentional exceptions (data-driven; add a reason, never bypass).
# ---------------------------------------------------------------------------
# Grid HTML files whose columns may legitimately auto-size (e.g. a single
# free-text column). Key = client-relative forward-slash path, value = reason.
$gridWidthAllowlist = @{ }

# ---------------------------------------------------------------------------
# Resolve roots.
# ---------------------------------------------------------------------------
$repoRoot = (Resolve-Path '.').Path

if (-not $ModernClientRoot) {
    $angularJson = Get-ChildItem -Path (Join-Path $repoRoot 'src') -Recurse -Filter 'angular.json' -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notmatch 'node_modules|dist' } |
        Select-Object -First 1
    if ($angularJson) { $ModernClientRoot = Split-Path $angularJson.FullName -Parent }
}

if (-not $ModernClientRoot -or -not (Test-Path $ModernClientRoot)) {
    Write-Host "Could not resolve a modern client root (no angular.json found under src/). Pass -ModernClientRoot."
    exit 2
}
$ModernClientRoot = (Resolve-Path $ModernClientRoot).Path
Write-Host "Scanning styling foundation under $ModernClientRoot ..."

if (-not $OutputPath) {
    $OutputPath = Join-Path $repoRoot '.modernization/legacy-analysis/styling-foundation-scan.json'
}

# Optional: legacy fixed scheme from the styling foundation.
$legacyScheme = $null
if (-not $StylingFoundationPath) {
    $sfGuess = Join-Path $repoRoot '.modernization/fusion-restructure/styling-foundation.json'
    if (Test-Path $sfGuess) { $StylingFoundationPath = $sfGuess }
}
if ($StylingFoundationPath -and (Test-Path $StylingFoundationPath)) {
    try {
        $sf = Get-Content -LiteralPath $StylingFoundationPath -Raw | ConvertFrom-Json
        if ($sf.colorSchemeForced) { $legacyScheme = "$($sf.colorSchemeForced)" }
        elseif ($sf.fusionThemeBinding -and $sf.fusionThemeBinding.colorSchemeForced) { $legacyScheme = "$($sf.fusionThemeBinding.colorSchemeForced)" }
    } catch { }
}

$findings = New-Object System.Collections.Generic.List[object]
function Add-Finding([string]$check, [string]$severity, [string]$status, [string]$detail) {
    $findings.Add([ordered]@{ check = $check; severity = $severity; status = $status; detail = $detail }) | Out-Null
}

# ---------------------------------------------------------------------------
# Check 1: color scheme pinned (index.html must not follow OS prefers-color-scheme).
# ---------------------------------------------------------------------------
$indexFiles = Get-ChildItem -Path $ModernClientRoot -Recurse -Filter 'index.html' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch 'node_modules|dist' }
if (-not $indexFiles) {
    Add-Finding 'colorSchemePinned' 'Major' 'WARN' 'No index.html found under the client root.'
} else {
    foreach ($idx in $indexFiles) {
        $html = Get-Content -LiteralPath $idx.FullName -Raw
        $followsOs = ($html -match 'prefers-color-scheme') -and ($html -match "classList\.add\(\s*['""]dark-theme['""]")
        $rel = $idx.FullName.Substring($ModernClientRoot.Length).TrimStart('\','/').Replace('\','/')
        if ($followsOs) {
            $schemeNote = if ($legacyScheme) { " Legacy fixed scheme recorded as '$legacyScheme'." } else { '' }
            Add-Finding 'colorSchemePinned' 'Major' 'FAIL' "$rel adds a 'dark-theme' class from the OS prefers-color-scheme media query, so the app follows the workstation OS instead of the legacy fixed scheme.$schemeNote Pin the scheme in index.html."
        } else {
            Add-Finding 'colorSchemePinned' 'Major' 'PASS' "$rel does not follow the OS prefers-color-scheme; scheme is pinned."
        }
    }
}

# ---------------------------------------------------------------------------
# Check 2 + 3: style include paths declared and populated.
# ---------------------------------------------------------------------------
$angularJsonPath = Join-Path $ModernClientRoot 'angular.json'
$includePaths = @()
if (-not (Test-Path $angularJsonPath)) {
    Add-Finding 'styleIncludePaths' 'Major' 'WARN' 'No angular.json at the client root; cannot verify style include paths.'
} else {
    try {
        $ng = Get-Content -LiteralPath $angularJsonPath -Raw | ConvertFrom-Json
        foreach ($projProp in $ng.projects.PSObject.Properties) {
            $opts = $projProp.Value.architect.build.options
            if ($opts -and $opts.stylePreprocessorOptions -and $opts.stylePreprocessorOptions.includePaths) {
                foreach ($p in $opts.stylePreprocessorOptions.includePaths) { if ($p) { $includePaths += "$p" } }
            }
        }
    } catch {
        Add-Finding 'styleIncludePaths' 'Major' 'WARN' "angular.json could not be parsed: $($_.Exception.Message)"
    }
    $includePaths = $includePaths | Select-Object -Unique
    if (-not $includePaths -or $includePaths.Count -eq 0) {
        Add-Finding 'styleIncludePaths' 'Major' 'FAIL' "angular.json declares no stylePreprocessorOptions.includePaths. With no shared style include path, per-component styles cannot @use shared layout partials, which is the root cause of full-bleed controls."
        Add-Finding 'sharedStylePartials' 'Major' 'FAIL' 'No include paths declared, so no shared style partials are wired. Provide shared layout partials (variables, mixins, collection/grid layout, side-nav) and reference them from page components.'
    } else {
        Add-Finding 'styleIncludePaths' 'Major' 'PASS' "Style include paths declared: $($includePaths -join ', ')."
        $partialCount = 0
        foreach ($ip in $includePaths) {
            $ipFull = Join-Path $ModernClientRoot ($ip -replace '/','\')
            if (Test-Path $ipFull) {
                $partials = Get-ChildItem -Path $ipFull -Recurse -Filter '*.scss' -ErrorAction SilentlyContinue
                $partialCount += @($partials).Count
            }
        }
        if ($partialCount -eq 0) {
            Add-Finding 'sharedStylePartials' 'Major' 'FAIL' "Include paths are declared but contain no .scss partials. Provide the shared layout partials the page components consume."
        } else {
            Add-Finding 'sharedStylePartials' 'Major' 'PASS' "$partialCount shared style partial(s) found under the declared include path(s)."
        }
    }
}

# ---------------------------------------------------------------------------
# Check 4: data-grid columns declare explicit widths.
# ---------------------------------------------------------------------------
$appRoot = Join-Path $ModernClientRoot 'src'
$htmlFiles = Get-ChildItem -Path $appRoot -Recurse -Filter '*.html' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch 'node_modules|dist' }
$gridColumnPattern = '(?i)<(?:fusion-data-grid-column|kendo-grid-column)\b[^>]*>'
$widthAttrPattern = '(?i)(\[width\]|\bwidth\s*=)'
$gridFilesScanned = 0
$gridColumnsTotal = 0
$gridColumnsWithoutWidth = 0
$autoSizedGridFiles = New-Object System.Collections.Generic.List[string]
foreach ($f in $htmlFiles) {
    $text = Get-Content -LiteralPath $f.FullName -Raw
    if (-not $text) { continue }
    $cols = [regex]::Matches($text, $gridColumnPattern)
    if ($cols.Count -eq 0) { continue }
    $gridFilesScanned++
    $rel = $f.FullName.Substring($ModernClientRoot.Length).TrimStart('\','/').Replace('\','/')
    $withWidth = 0
    foreach ($c in $cols) { if ($c.Value -match $widthAttrPattern) { $withWidth++ } }
    $gridColumnsTotal += $cols.Count
    $gridColumnsWithoutWidth += ($cols.Count - $withWidth)
    # A grid whose columns are ALL auto-sized (and has more than one column) diverges
    # from legacy density. A grid with at least one explicit width is intentional layout.
    if ($withWidth -eq 0 -and $cols.Count -gt 1) {
        if ($gridWidthAllowlist.ContainsKey($rel)) { continue }
        $autoSizedGridFiles.Add($rel) | Out-Null
    }
}
if ($gridFilesScanned -eq 0) {
    Add-Finding 'gridColumnWidths' 'Major' 'PASS' 'No data grids found to check.'
} elseif ($autoSizedGridFiles.Count -gt 0) {
    Add-Finding 'gridColumnWidths' 'Major' 'FAIL' "$($autoSizedGridFiles.Count) data-grid file(s) declare columns with no explicit width (fully auto-sized), which diverges from legacy column density: $($autoSizedGridFiles -join ', '). Declare explicit per-column widths (a free-text column may flex)."
} else {
    Add-Finding 'gridColumnWidths' 'Major' 'PASS' "$gridFilesScanned grid file(s) scanned; each declares at least one explicit column width."
}

# ---------------------------------------------------------------------------
# Check 5: header chrome bound to the legacy brand color (the nav/header bar color).
# ---------------------------------------------------------------------------
# The legacy header/nav bar color is part of the visual contract. For a Fusion
# client the default header (`.ffx-header > header`) paints the main bar with a
# NEUTRAL `app-surface` color, so the legacy brand header color only renders when
# the app styles OVERRIDE the header chrome selector after the theme include.
# Without that override the bar renders grey, not the legacy brand color - a
# nav-bar-color defect that otherwise only a render diff would catch. Asserting the
# override statically makes the nav-bar color gate-enforced, not a render-time
# judgement call. Set $headerBrandingNeutralAllowed = $true (with a recorded
# reason) only when the legacy header genuinely was the framework-neutral surface.
$headerBrandingNeutralAllowed = $false
$styleTexts = ''
$styleEntries = @()
if ($ng) {
    foreach ($projProp in $ng.projects.PSObject.Properties) {
        $opts = $projProp.Value.architect.build.options
        if ($opts -and $opts.styles) { foreach ($s in $opts.styles) { if ($s -is [string]) { $styleEntries += $s } } }
    }
}
if (-not $styleEntries -or $styleEntries.Count -eq 0) { $styleEntries = @('src/styles.scss') }
foreach ($se in $styleEntries) {
    $seFull = Join-Path $ModernClientRoot ($se -replace '/','\')
    if (Test-Path $seFull) { $styleTexts += "`n" + (Get-Content -LiteralPath $seFull -Raw -ErrorAction SilentlyContinue) }
}
foreach ($ip in $includePaths) {
    $ipFull = Join-Path $ModernClientRoot ($ip -replace '/','\')
    if (Test-Path $ipFull) {
        Get-ChildItem -Path $ipFull -Recurse -Filter '*.scss' -ErrorAction SilentlyContinue | ForEach-Object {
            $styleTexts += "`n" + (Get-Content -LiteralPath $_.FullName -Raw -ErrorAction SilentlyContinue)
        }
    }
}
$isFusionClient = $styleTexts -match '@fusion/theme'
if ($headerBrandingNeutralAllowed) {
    Add-Finding 'headerChromeBranded' 'Major' 'PASS' 'Allowlisted: legacy header was the framework-neutral surface (recorded exception).'
} elseif ($isFusionClient) {
    $hasHeaderOverride = $styleTexts -match '(?s)\.ffx-header[\s\S]{0,300}?\bbackground\b'
    if ($hasHeaderOverride) {
        Add-Finding 'headerChromeBranded' 'Major' 'PASS' 'Header chrome override present (.ffx-header background bound); the header bar renders the legacy brand color, not the Fusion neutral default.'
    } else {
        Add-Finding 'headerChromeBranded' 'Major' 'FAIL' "No header-chrome brand override found. The Fusion default header paints the main bar with the neutral 'app-surface' color, so the legacy brand header/nav-bar color will not render (the bar shows grey). Add a '.ffx-header > header { background: <brand>; }' override with legible foreground AFTER the theme include in styles.scss."
    }
} else {
    Add-Finding 'headerChromeBranded' 'Major' 'PASS' 'Non-Fusion client: header-chrome brand binding is verified by the render-observed visual-parity gate (computed header background vs legacy contract), not this static check.'
}

# ---------------------------------------------------------------------------
# Roll-up + output.
# ---------------------------------------------------------------------------
$majorFail = @($findings | Where-Object { $_.severity -eq 'Major' -and $_.status -eq 'FAIL' }).Count
$gateStatus = if ($majorFail -eq 0) { 'pass' } else { 'fail' }

$result = [ordered]@{
    generatedBy = 'Step 10 styling-foundation gate (scan-styling-foundation.ps1)'
    generatedUtc = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
    modernClientRoot = $ModernClientRoot.Replace($repoRoot, '').TrimStart('\','/').Replace('\','/')
    legacyColorSchemeForced = $legacyScheme
    gateStatus = $gateStatus
    majorFailCount = $majorFail
    gridColumnsTotal = $gridColumnsTotal
    gridColumnsWithoutWidth = $gridColumnsWithoutWidth
    findings = $findings
}

$outDir = Split-Path $OutputPath -Parent
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
$result | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $OutputPath -Encoding UTF8

Write-Host ''
Write-Host "STYLING FOUNDATION SCAN COMPLETE -> $($OutputPath.Replace($repoRoot, '.'))"
foreach ($fnd in $findings) {
    Write-Host ("  [{0}] {1}: {2}" -f $fnd.status, $fnd.check, $fnd.detail)
}
Write-Host ''
Write-Host ("Gate: {0} (Major failures: {1})" -f $gateStatus.ToUpper(), $majorFail)

if ($majorFail -gt 0) { exit 2 } else { exit 0 }
