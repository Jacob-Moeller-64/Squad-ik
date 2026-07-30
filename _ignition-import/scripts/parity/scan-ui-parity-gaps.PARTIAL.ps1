<#
.SYNOPSIS
    Deterministic legacy-to-modern UI parity scanner.

.DESCRIPTION
    Walks LegacyCode/**/*.cshtml + *.html and extracts two structured inventories:
      1. iconLabelPairs : every (icon, label) co-located within an <a>, <button>, or
                          <li> in the legacy source. Patterns covered:
                            <i class="fa fa-X ..."></i> Label
                            Label <i class="fa fa-X ..."></i>
                            <span class="fa fa-X ..."></span> Label
                            <button class="... fa fa-X ...">Label</button>
                            <a class="... fa fa-X ...">Label</a>            (icon on the button itself)
                          Also handles Bootstrap-3 glyphicons.
      2. clickableLabels: every <a>/<button>/<input type=submit/button>/<role=button> with text.

    Walks src/<App>.Web.Client/src/**/*.html, extracts the same shapes, plus
    Angular-flavored variants: [icon]="..."  fa-icon="..."  testId="..."
    data-testid="..."  and inline <i class="fa fa-X"> inside templates.

    Cross-checks: for each legacy (label, icon) pair, finds the closest modern
    element by case/space-normalized label. Emits:
      - MissingControl : an interactive legacy control (button, link, routerLink,
                         submit, modal/dropdown trigger, or icon control) has no
                         modern counterpart by label. This is the parity defect
                         that silent label-only drops used to hide. Major
                         (Minor for ambiguous filter-value labels such as 'all').
      - MissingColumn  : a legacy grid column header (from <th>, ag-grid headerName,
                         a ColDef title, or a Fusion/Kendo grid-column title) has no
                         modern column counterpart by label - the column-collapse
                         defect where a grid loads real data in fewer or more
                         generic columns than legacy. Major.
      - InertControl   : a modern control is present but its (click) handler is an
                         empty / TODO-only method body, or it is permanently
                         disabled by a literal [disabled]="true". Major.
      - MissingIcon    : legacy had icon, modern has no icon near same label
      - IconMismatch   : icons differ
      - LowControlCoverage : emitted only when -CoverageFloor is set and the modern
                             interactive control count is far below the legacy count.
    Passive (non-interactive) legacy labels with no modern counterpart are counted
    as passiveLabelDrops and reported, never silently zeroed.

    Output:
      .modernization/ignition-artifacts/discovery/ui-parity-gap-scan.json

    Exit codes:
      0 = no Critical or Major gaps
      2 = Major or Critical gaps present

    This script is repeatable and content-only - no live runtime needed.
    Re-run after every shell or template edit.
#>
param(
    [string]$LegacyRoot = '.\LegacyCode',
    [string]$ModernClientRoot = '',
    [string]$OutputPath = '.\.modernization\ignition-artifacts\discovery\ui-parity-gap-scan.json',
    # Optional per-app deferred-behavior registry. When omitted, defaults to
    # 'ui-deferral-registry.json' beside the output file. Each entry temporarily
    # suppresses a Major InertControl for a legitimately-deferred stub handler, but
    # every suppressed handler is still surfaced in deferredInertControls[] so a zero
    # inert count can never hide parked stubs. This replaces the previous practice of
    # hard-coding app-specific handler names into this reusable script.
    [string]$DeferralRegistryPath = '',
    # The step currently running the scan. When > 0, any deferral whose owner step has
    # been reached or passed (ownerStep <= CurrentStep) is treated as STALE and re-flagged
    # as a Major InertControl (the deferral-drain gate) instead of being suppressed.
    [int]$CurrentStep = 0,
    # Optional coverage floor for closeout steps. When > 0, a modern interactive control
    # count far below the legacy count emits a Critical LowControlCoverage gap. Off (0) by
    # default so early foundation passes are not blocked while coverage is legitimately low.
    [double]$CoverageFloor = 0,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

# Reusable kit script: this file lives under .github/scripts/parity/ so every
# new repo starts with the parity scanner, while per-app evidence and runtime
# outputs continue to live under .modernization/ignition-artifacts/discovery/. The modern
# client root is derived from .modernization/.readme/kit-params.md (canonical kit identity file)
# (the same source the VS Code tasks use) so this script stays app-agnostic.
if (-not $ModernClientRoot -or [string]::IsNullOrWhiteSpace($ModernClientRoot)) {
    $deployValues = Join-Path (Get-Location) '.modernization\.readme\kit-params.md'
    if (Test-Path $deployValues) {
        $appNameMatch = Select-String -Path $deployValues -Pattern '^appName:\s*(.+)$' | Select-Object -First 1
        if ($appNameMatch) {
            $appName = $appNameMatch.Matches[0].Groups[1].Value.Trim()
            $candidate = Join-Path (Get-Location) ("src\{0}.Web.Client\src" -f $appName)
            if (Test-Path $candidate) { $ModernClientRoot = $candidate }
        }
    }
    if (-not $ModernClientRoot) {
        # Fallback: pick the first src/*.Web.Client/src folder that exists.
        $first = Get-ChildItem -Path .\src -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -match '\.Web\.Client$' -and (Test-Path (Join-Path $_.FullName 'src')) } |
            Select-Object -First 1
        if ($first) { $ModernClientRoot = (Join-Path $first.FullName 'src') }
    }
    if (-not $ModernClientRoot) {
        throw "Could not determine ModernClientRoot. Pass -ModernClientRoot or populate .modernization/.readme/kit-params.md with appName."
    }
}

# ---------------------------------------------------------------------
# APP COMPONENT-WRAPPER PREFIX (derived, app-agnostic)
# ---------------------------------------------------------------------
# The kit generates app-owned control wrappers named after the app (kebab of appName),
# e.g. <filelog-command-button> for app "FileLog". The scanner MUST see these the same way
# it sees native <button> and <fusion-button>; otherwise it is blind to every wrapped
# control and reports FALSE MissingControl gaps after a wrapper-swap pass (a gate that fails
# a control that is actually present is as dishonest as one that passes a missing control).
# The prefix is derived from kit-params appName, or falls back to the '<App>.Web.Client'
# folder name, so no app identity is hard-coded here.
$script:AppComponentPrefix = ''
$appNameForPrefix = ''
$kitParamsForPrefix = Join-Path (Get-Location) '.modernization\.readme\kit-params.md'
if (Test-Path $kitParamsForPrefix) {
    $prefixMatch = Select-String -Path $kitParamsForPrefix -Pattern '^appName:\s*(.+)$' | Select-Object -First 1
    if ($prefixMatch) { $appNameForPrefix = $prefixMatch.Matches[0].Groups[1].Value.Trim() }
}
if ([string]::IsNullOrWhiteSpace($appNameForPrefix) -and $ModernClientRoot) {
    $webClientSegment = ($ModernClientRoot -split '[\\/]') | Where-Object { $_ -match '\.Web\.Client$' } | Select-Object -First 1
    if ($webClientSegment) { $appNameForPrefix = ($webClientSegment -replace '\.Web\.Client$', '') }
}
if (-not [string]::IsNullOrWhiteSpace($appNameForPrefix)) {
    $script:AppComponentPrefix = ($appNameForPrefix -replace '[^A-Za-z0-9]', '').ToLowerInvariant()
}

# ---------------------------------------------------------------------
# PER-APP REGISTRY LOAD (app EVIDENCE, never hard-coded in this reusable script)
# ---------------------------------------------------------------------
# Every app-specific suppression fact - deferred stub handlers plus documented
# intentional icon/color divergences - is loaded from the per-app registry so
# this reusable script carries no app identity (no app-shaped labels, handler
# names, or feature names). Default path sits beside the output file. Shape:
#   {
#     "deferrals":          [ { "handler", "ownerStep", "reason" } ],
#     "iconMismatchAllowlist": [ { "key": "label||legacyIcon||modernIcon",  "reason" } ],
#     "colorMismatchAllowlist":[ { "key": "label||legacyColor||modernColor", "reason" } ]
#   }
# Honesty rules for the deferral list (the previous failure mode was an
# app-specific hardcoded allowlist that permanently blinded the inert gate):
#   1. A suppressed handler is STILL counted and listed in deferredInertControls[],
#      so inertControlCount = 0 can never hide N parked stubs.
#   2. When -CurrentStep is passed and a deferral's owner step is reached or passed
#      (ownerStep <= CurrentStep), the deferral is STALE and is re-flagged as a Major
#      InertControl (the drain gate) instead of being suppressed.
$inertControlAllowlist = @{}    # inert dimension: temporarily-deferred stub handlers
$deferralOwnerStep = @{}        # handler -> ownerStep that must WIRE it
$intentionalImprovements = @{}  # icon dimension: documented intentional glyph divergences
$colorAllowlist = @{}           # color dimension: documented intentional palette divergences
# Every suppressed deferral is recorded here and emitted in the summary so a zero inert
# count is never mistaken for zero deferred behavior.
$deferredInertControls = New-Object System.Collections.Generic.List[object]
if (-not $DeferralRegistryPath -or [string]::IsNullOrWhiteSpace($DeferralRegistryPath)) {
    $DeferralRegistryPath = Join-Path (Split-Path $OutputPath -Parent) 'ui-deferral-registry.json'
}
if (Test-Path $DeferralRegistryPath) {
    try {
        $registry = Get-Content -LiteralPath $DeferralRegistryPath -Raw | ConvertFrom-Json
        foreach ($d in @($registry.deferrals)) {
            if (-not $d.handler) { continue }
            $inertControlAllowlist[$d.handler] = [string]$d.reason
            if ($null -ne $d.ownerStep) { $deferralOwnerStep[$d.handler] = [int]$d.ownerStep }
        }
        foreach ($i in @($registry.iconMismatchAllowlist)) {
            if ($i.key) { $intentionalImprovements[[string]$i.key] = [string]$i.reason }
        }
        foreach ($c in @($registry.colorMismatchAllowlist)) {
            if ($c.key) { $colorAllowlist[[string]$c.key] = [string]$c.reason }
        }
    } catch {
        Write-Verbose ("Could not parse deferral registry {0}: {1}" -f $DeferralRegistryPath, $_.Exception.Message)
    }
}

function Normalize-Label([string]$s) {
    if (-not $s) { return '' }
    $t = $s -replace '<[^>]+>', ' '
    $t = $t -replace '&lt;', '<'
    $t = $t -replace '&gt;', '>'
    $t = $t -replace '&amp;', '&'
    $t = $t -replace '&[a-z0-9]+;', ' '
    $t = $t -replace '\{\{[^}]*\}\}', ' '
    $t = $t -replace '\s+', ' '
    return $t.Trim().ToLowerInvariant().TrimEnd(':').Trim()
}

function Extract-IconClasses([string]$classAttr) {
    if (-not $classAttr) { return @() }
    $tokens = $classAttr -split '\s+'
    # Drop FA size and stack modifiers; they describe rendering, not the glyph.
    $faTokens = $tokens | Where-Object { $_ -match '^fa-[a-z0-9\-]+$' -and $_ -notmatch '^fa-(1x|lg|2x|3x|4x|5x|fw|sm|md|stack|stack-1x|stack-2x|inverse|spin|pulse|rotate-(?:90|180|270)|flip-(?:horizontal|vertical))$' }
    $glyph = $tokens | Where-Object { $_ -match '^glyphicon-[a-z0-9\-]+$' }
    return @($faTokens + $glyph) | Where-Object { $_ }
}

# Known semantic-icon vocabulary used by the modern app's action-button wrapper
# to resolve a semantic name (add, edit, delete, ...) to a Font Awesome glyph.
# Keeping this mapping local to the scanner avoids parsing TypeScript and keeps
# IconMismatch output comparable across legacy FA classes and modern semantic
# wrapper attributes. Derive new entries from the app's wrapper; never hard-code
# an app identity here.
$SemanticIconMap = @{
    'add'                = 'fa-plus'
    'calculate'          = 'fa-calculator'
    'cancel'             = 'fa-times-circle-o'
    'delete'             = 'fa-trash-o'
    'edit'               = 'fa-pencil-square-o'
    'export'             = 'fa-file-excel-o'
    'import'             = 'fa-upload'
    'lock'               = 'fa-edit'
    'print'              = 'fa-print'
    'save'               = 'fa-floppy-o'
    'save-all'           = 'fa-save'
    'switch-application' = 'fa-angle-up'
    'unlock'             = 'fa-edit'
}

# Font Awesome 4 alias normalization. Some legacy templates use the older
# alias name while modern wrappers prefer the canonical glyph name (or vice
# versa). Treating these as equivalent removes IconMismatch noise that has no
# visual impact at runtime.
$IconAliasMap = @{
    'fa-save'             = 'fa-floppy-o'
    'fa-floppy-o'         = 'fa-floppy-o'
    'fa-edit'             = 'fa-pencil-square-o'
    'fa-pencil-square-o'  = 'fa-pencil-square-o'
    'fa-trash'            = 'fa-trash-o'
    'fa-trash-o'          = 'fa-trash-o'
    'fa-times-circle'     = 'fa-times-circle-o'
    'fa-times-circle-o'   = 'fa-times-circle-o'
    'fa-files-o'          = 'fa-files-o'
}

# Resolve a token list into FA-class space so legacy FA classes compare cleanly
# against modern semantic markers like 'semantic:cancel'. Unknown semantic
# markers are dropped (treated as "has icon, unknown glyph") so they no longer
# create false IconMismatch noise. FA4 aliases are normalized to a canonical
# glyph so fa-save and fa-floppy-o compare equal.
function Resolve-IconTokens($tokens) {
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($t in $tokens) {
        if (-not $t) { continue }
        if ($t -like 'semantic:*') {
            $key = $t.Substring('semantic:'.Length)
            if ($SemanticIconMap.ContainsKey($key)) {
                $resolved = $SemanticIconMap[$key]
                if ($IconAliasMap.ContainsKey($resolved)) { $resolved = $IconAliasMap[$resolved] }
                $out.Add($resolved) | Out-Null
            }
            continue
        }
        $canonical = if ($IconAliasMap.ContainsKey($t)) { $IconAliasMap[$t] } else { $t }
        $out.Add($canonical) | Out-Null
    }
    return ,$out
}

# ---------------------------------------------------------------------
# DIMENSION REGISTRY (rule packs)
# ---------------------------------------------------------------------
# A "dimension" is one comparable attribute family between legacy and modern.
# Adding a new dimension should not require rewriting the engine: each entry
# below declares (a) how to extract the value from a control record, (b) how
# to normalize/canonicalize it for comparison, (c) the gap kind + severity to
# emit when legacy and modern diverge, and (d) optional documented allowlist
# tuples that suppress noise for known intentional improvements.
#
# Dimensions implemented today:
#   icon        : already wired through the legacy<->modern matcher below.
#   color       : Bootstrap 3 btn-* class vs Fusion color="..." attribute.
#
# To add a future dimension (e.g. tooltip, disabled-binding, visibility-binding)
# add a new block to $ParityDimensions, populate $rec.<dim> in Scan-File, and
# the engine will automatically compare and report it.
# ---------------------------------------------------------------------

# Bootstrap-3 button color class -> Fusion semantic color.
# Used by the 'color' dimension. Update when a new app introduces a new
# palette mapping; do not encode app-specific names here.
$BootstrapColorMap = @{
    'btn-primary' = 'primary'
    'btn-success' = 'success'
    'btn-info'    = 'info'
    'btn-warning' = 'warning'
    'btn-danger'  = 'error'
    'btn-default' = 'default'
    'btn-link'    = 'link'
}

function Extract-ColorToken([string]$classAttr, [string]$colorAttr) {
    if ($colorAttr) {
        $c = $colorAttr.Trim().ToLowerInvariant()
        if ($c) { return $c }
    }
    if (-not $classAttr) { return '' }
    foreach ($t in ($classAttr -split '\s+')) {
        if ($BootstrapColorMap.ContainsKey($t)) { return $BootstrapColorMap[$t] }
    }
    return ''
}

# ---------------------------------------------------------------------
# DISCOVERY PROBE
# ---------------------------------------------------------------------
# The discovery probe is the answer to "future mysteries": after every known
# rule pack runs, we walk every legacy <a>/<button>/<li> block and collect the
# attribute names + AngularJS directives + class-token families that NO rule
# pack consumed. The output ranks them by frequency so the next app's first
# parity defect immediately tells you which rule pack to add next. Coverage
# converges to 100% as the registry grows.
$KnownLegacyAttributes = @(
    'class','id','type','href','target','rel','title','alt','name','value',
    'role','aria-label','aria-labelledby','aria-controls','aria-expanded',
    'data-toggle','data-target','data-dismiss','data-testid','data-test-id',
    'tabindex','autofocus','disabled','readonly','required','maxlength','minlength',
    'placeholder','autocomplete','for','form','formaction','formmethod',
    'ng-click','ng-show','ng-hide','ng-if','ng-disabled','ng-class','ng-style',
    'ng-model','ng-bind','ng-href','ng-src','ng-repeat','ng-options','ng-init',
    'ng-mouseover','ng-mouseleave','ng-mouseenter','ng-blur','ng-focus','ng-keydown',
    'ng-keypress','ng-change','ng-submit','ng-controller','ng-app','ng-include',
    'ng-show','ng-cloak','ng-bind-html','ng-attr','onclick','style'
)
$KnownLegacyClassPrefixes = @(
    'fa-','fa','glyphicon-','glyphicon','btn-','btn','col-','row','container','panel-','panel','navbar-',
    'nav-','nav','tab-','tab','active','disabled','pull-','text-','bg-','label-','label',
    'alert-','form-','input-','well','well-','help-','close','clearfix',
    'ng-','dropdown-','dropdown','divider','hidden','visible','show','hide','collapse','collapsed','in','fade'
)
function Probe-LegacyControl([string]$tagName, [string]$attrsRaw, [hashtable]$bag) {
    if (-not $attrsRaw) { return }
    # Attribute name harvest: name="value" pairs and bare boolean attrs.
    $attrPairs = [regex]::Matches($attrsRaw, '(?i)([a-z_:][\w\-:]*)\s*(?:=\s*(?:"[^"]*"|''[^'']*''|[^\s>]+))?')
    foreach ($ap in $attrPairs) {
        $name = $ap.Groups[1].Value.ToLowerInvariant()
        if (-not $name) { continue }
        if ($KnownLegacyAttributes -contains $name) { continue }
        # Collapse data-* and aria-* into known buckets when prefix matches.
        if ($name -like 'aria-*') { continue }
        if ($name -like 'data-*' -and $name -ne 'data-testid' -and $name -ne 'data-test-id') {
            $bag['data-*'] = ($bag['data-*'] + 1)
            continue
        }
        $bag[$name] = ($bag[$name] + 1)
    }
    # Class-token family harvest: capture unrecognized class roots.
    $cm = [regex]::Match($attrsRaw, '(?i)class\s*=\s*"([^"]*)"')
    if ($cm.Success) {
        foreach ($tk in ($cm.Groups[1].Value -split '\s+')) {
            if (-not $tk) { continue }
            $known = $false
            foreach ($p in $KnownLegacyClassPrefixes) {
                if ($p.EndsWith('-')) {
                    if ($tk.StartsWith($p)) { $known = $true; break }
                } else {
                    if ($tk -eq $p) { $known = $true; break }
                }
            }
            if (-not $known) {
                $key = "class:$tk"
                $bag[$key] = ($bag[$key] + 1)
            }
        }
    }
}

# Scan a single file content; return list of records.
function Scan-File([string]$path, [string]$kind) {
    $text = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
    if (-not $text) { return @() }
    # Strip HTML comments so commented-out legacy markup is not treated as live UI.
    # Razor server comments (@*...*@) and Angular HTML comments (<!--...-->) both ignored.
    $text = [regex]::Replace($text, '(?s)<!--.*?-->', '')
    $text = [regex]::Replace($text, '(?s)@\*.*?\*@', '')
    $records = New-Object System.Collections.Generic.List[object]

    # Match <a> / <button> / <li> blocks (non-greedy, single-line forced via (?s)).
    # Also match the app's button-shaped control wrappers (e.g. <filelog-command-button>) so
    # wrapped buttons and links are seen; without this the scanner is blind to every wrapped
    # control and reports false MissingControl gaps.
    # IMPORTANT: only match button-action-shaped wrappers (names ending in -button/-btn/-link/
    # -action/-cmd). Container-shaped wrappers like <filelog-modal>, <filelog-data-grid>,
    # <filelog-dropdown> must NOT be included here: the block regex is non-overlapping, so
    # if a container wrapper is matched as one block its inner <filelog-command-button> children
    # are swallowed and never seen as separate records - producing false MissingControl gaps for
    # the Cancel/Submit buttons inside the modal. The suffix heuristic is generic: any app that
    # names its button wrapper *-button, *-btn, *-link, *-action, or *-cmd is covered.
    $appTagAlt = if ($script:AppComponentPrefix) {
        '|' + [regex]::Escape($script:AppComponentPrefix) + '-[a-z0-9\-]*-(?:button|btn|link|action|cmd)'
    } else { '' }
    $blockPattern = "(?si)<(a|button|li|fusion-button$appTagAlt)\b([^>]*)>(.*?)</\1>"
    $matches = [regex]::Matches($text, $blockPattern)
    foreach ($m in $matches) {
        $tag   = $m.Groups[1].Value.ToLowerInvariant()
        $attrs = $m.Groups[2].Value
        $inner = $m.Groups[3].Value
        # Discovery probe: harvest unrecognized attribute names + class tokens
        # from legacy-side controls so future apps can see "what we don't yet
        # check" ranked by frequency. Cheap, side-effect only.
        if ($kind -eq 'legacy' -and $script:DiscoveryBag) {
            Probe-LegacyControl $tag $attrs $script:DiscoveryBag
        }
        # Skip nested control wrappers that aren't user-facing buttons (e.g. tab <li> containing another <a>)
        # but still record the outer if it has its own icon class.
        $classMatch = [regex]::Match($attrs, '(?i)class\s*=\s*"([^"]*)"')
        $ownClasses = if ($classMatch.Success) { $classMatch.Groups[1].Value } else { '' }
        $ownIcons = Extract-IconClasses $ownClasses

        # Find inline icons inside the inner text
        $innerIconMatches = [regex]::Matches($inner, '(?i)<(i|span)\b([^>]*class\s*=\s*"([^"]*)"[^>]*)>\s*</\1>')
        $innerIcons = @()
        foreach ($im in $innerIconMatches) {
            $innerIcons += Extract-IconClasses $im.Groups[3].Value
        }

        # testId / data-testid
        $tidMatch = [regex]::Match($attrs, '(?i)(?:data-testid|testid|testId)\s*=\s*"([^"]+)"')
        $testId = if ($tidMatch.Success) { $tidMatch.Groups[1].Value } else { '' }

        # ng-click / (click) / (pressed)
        $clickMatch = [regex]::Match($attrs, '(?i)(ng-click|\(click\)|\(pressed\))\s*=\s*"([^"]+)"')
        $handler = if ($clickMatch.Success) { $clickMatch.Groups[2].Value } else { '' }

        $label = Normalize-Label $inner
        if ([string]::IsNullOrWhiteSpace($label) -and -not $testId -and -not $handler) { continue }
        # Skip absurdly long labels (likely a whole panel)
        if ($label.Length -gt 80) { $label = $label.Substring(0,80) }

        $iconList = @($ownIcons + $innerIcons | Where-Object { $_ -match '^(fa-|glyphicon-)' } | Select-Object -Unique)
        # Color/severity dimension: legacy uses Bootstrap btn-* classes.
        $colorTok = Extract-ColorToken $ownClasses ''

        # Interactivity: is this control's absence a real parity defect? This
        # captures far more than the click handler alone so navigation links,
        # routerLinks, form submits, and modal/dropdown triggers are never
        # silently dropped the way a routerLink-only nav link used to be.
        $hrefMatch = [regex]::Match($attrs, '(?i)\bhref\s*=\s*"([^"]*)"')
        $hrefVal = if ($hrefMatch.Success) { $hrefMatch.Groups[1].Value.Trim() } else { '' }
        $hasRealHref = $hrefVal -and ($hrefVal -notmatch '(?i)^\s*(#|javascript:\s*void)')
        $hasRouterLink = [regex]::IsMatch($attrs, '(?i)\[?routerLink\]?\s*=')
        $hasSubmit = [regex]::IsMatch($attrs, '(?i)\btype\s*=\s*"submit"') -or [regex]::IsMatch($attrs, '(?i)\(ngSubmit\)\s*=')
        $hasTrigger = [regex]::IsMatch($attrs, '(?i)\b(data-toggle|data-bs-toggle|data-target|data-bs-target|ngbPopover|\(change\))\s*=')
        $interactive = ($tag -eq 'button') -or (-not [string]::IsNullOrWhiteSpace($handler)) -or $hasRealHref -or $hasRouterLink -or $hasSubmit -or $hasTrigger -or ($iconList.Count -gt 0)

        $records.Add([pscustomobject]@{
            kind    = $kind
            file    = $path
            tag     = $tag
            label   = $label
            icons   = $iconList
            color   = $colorTok
            testId  = $testId
            handler = $handler

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-454. Source lines 455-831 are NOT yet
# transcribed (they were in photos not read). A separate photographed set covers
# roughly 832-end and is also not yet transcribed. Deliberately incomplete;
# must not be executed.
# ---------------------------------------------------------------------------
