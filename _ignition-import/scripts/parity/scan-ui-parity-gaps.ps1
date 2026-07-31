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
            interactive = $interactive
# =====================================================================
# TRANSCRIPTION GAP -- NOT PART OF THE SOURCE FILE.
# Source lines 456-501 of scan-ui-parity-gaps.ps1 are not covered by any
# photo in _ignition-import/_source-photos/parity/scan-ui-parity-gaps:
# photo 08-a31b8876.jpg ends at source line 455 and photo 09-73c4e863.jpg
# begins at source line 502, so one screenshot between them was skipped.
# The remainder of function Scan-File (closing the $records.Add call,
# any further extraction passes, and the function's return) lies in this
# range and cannot be transcribed without inventing code.
# The placeholder lines below keep every later line of this file at its
# true source line number: lines 502-1120 are anchor-verified against
# the photo gutters at exactly those numbers.
# Replace this block with the verbatim source once the missing
# screenshot is supplied. Do NOT execute this file until then.
# (untranscribed source line 470)
# (untranscribed source line 471)
# (untranscribed source line 472)
# (untranscribed source line 473)
# (untranscribed source line 474)
# (untranscribed source line 475)
# (untranscribed source line 476)
# (untranscribed source line 477)
# (untranscribed source line 478)
# (untranscribed source line 479)
# (untranscribed source line 480)
# (untranscribed source line 481)
# (untranscribed source line 482)
# (untranscribed source line 483)
# (untranscribed source line 484)
# (untranscribed source line 485)
# (untranscribed source line 486)
# (untranscribed source line 487)
# (untranscribed source line 488)
# (untranscribed source line 489)
# (untranscribed source line 490)
# (untranscribed source line 491)
# (untranscribed source line 492)
# (untranscribed source line 493)
# (untranscribed source line 494)
# (untranscribed source line 495)
# (untranscribed source line 496)
# (untranscribed source line 497)
# (untranscribed source line 498)
# (untranscribed source line 499)
# (untranscribed source line 500)
# ===================== END TRANSCRIPTION GAP =========================
}

# Directories that hold generated, vendored, or report output rather than real
# app UI. Scanning these produced false "missing control" noise (for example
# Istanbul coverage report links) once href-bearing anchors began to count as
# interactive controls, so they are excluded from every scan below.
$excludePattern = '\\bin\\|\\obj\\|\\packages\\|node_modules|\\coverage\\|\\dist\\|\\out-tsc\\|\\.angular\\|\\TestResults\\|\\wwwroot\\lib\\'

Write-Host "Scanning legacy under $LegacyRoot ..."
$legacyFiles = @(Get-ChildItem -Path (Join-Path $LegacyRoot "*") -Recurse -Include *.cshtml,*.html -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern })
$legacyRecords = New-Object System.Collections.Generic.List[object]
$script:DiscoveryBag = @{}
foreach ($f in $legacyFiles) { Scan-File $f.FullName 'legacy' | ForEach-Object { $legacyRecords.Add($_) | Out-Null } }

# Also scan legacy *.ts inline templates so cell-renderer components (e.g. RetrieveFilesRenderer,
# ActionsRenderer) are visible to the scanner. These are common in Angular/ag-grid legacy apps where
# each grid column action lives in a TypeScript file with a template:`` string rather than a .html.
# Without this pass the scanner misses every row-level action link and reports no gap — a false clean.
# Uses the same bounded BFS the column scanner uses to avoid walking legacy node_modules.
$legacyTsFilesForTemplate = New-Object System.Collections.Generic.List[object]
if (Test-Path $LegacyRoot) {
    $walkQueue2 = [System.Collections.Generic.Queue[string]]::new()
    $walkQueue2.Enqueue((Convert-Path $LegacyRoot))
    while ($walkQueue2.Count -gt 0) {
        $dir = $walkQueue2.Dequeue()
        if ($dir -match '(?i)node_modules|\\bin\\|\\obj\\|\\dist\\|\\.angular\\|\\coverage\\|\\out-tsc\\|\\packages\\') { continue }
        foreach ($tsf in (Get-ChildItem -LiteralPath $dir -File -Filter *.ts -ErrorAction SilentlyContinue)) { $legacyTsFilesForTemplate.Add($tsf) | Out-Null }
        foreach ($sub in (Get-ChildItem -LiteralPath $dir -Directory -ErrorAction SilentlyContinue)) { $walkQueue2.Enqueue($sub.FullName) }
    }
}
foreach ($f in $legacyTsFilesForTemplate) {
    $raw = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $raw) { continue }
    # Extract inline template strings. Three separate patterns cover each quote style independently:
    # backtick templates can contain single/double quotes inside Angular bindings ([attr]="..."),
    # so the closing delimiter must match the same character that opened the template, not stop at
    # the first quote of any kind. The existing [^\x60\x27\x22]+ approach stops early when a
    # template attribute uses double-quotes (the most common case in Angular ag-grid renderers).
    $tplText = ''
    foreach ($pat in @("(?s)\x60([^\x60]+)\x60", "(?s)'([^']+)'", '(?s)"([^"]+)"')) {
        foreach ($tm in [regex]::Matches($raw, "(?i)template\s*:\s*$pat")) {
            $tplText = $tm.Groups[1].Value
            $tplText = [regex]::Replace($tplText, '(?s)<!--.*?-->', '')
            $tmp = New-TemporaryFile
            Set-Content -LiteralPath $tmp -Value $tplText -Encoding UTF8
            Scan-File $tmp 'legacy' | ForEach-Object {
                $_.file = $f.FullName
                $legacyRecords.Add($_) | Out-Null
            }
            Remove-Item $tmp -ErrorAction SilentlyContinue
        }
    }
    $tplText = $null  # release
}
Write-Host ("  legacy controls scanned: {0} across {1} html + {2} ts files" -f $legacyRecords.Count, $legacyFiles.Count, $legacyTsFilesForTemplate.Count)

Write-Host "Scanning modern under $ModernClientRoot ..."
$modernFiles = @(Get-ChildItem -Path (Join-Path $ModernClientRoot "*") -Recurse -Include *.html -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern })
$modernRecords = New-Object System.Collections.Generic.List[object]
foreach ($f in $modernFiles) { Scan-File $f.FullName 'modern' | ForEach-Object { $modernRecords.Add($_) | Out-Null } }

# Also scan modern *.ts templates for inline 'template: `...`' so tab-style components are covered.
$modernTsFiles = @(Get-ChildItem -Path (Join-Path $ModernClientRoot "*") -Recurse -Include *.ts -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern })
foreach ($f in $modernTsFiles) {
    $raw = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $raw) { continue }
    $tplMatches = [regex]::Matches($raw, "(?s)template\s*:\s*[``']([^``']+)[``']")
    foreach ($tm in $tplMatches) {
        $tplText = $tm.Groups[1].Value
        $tplText = [regex]::Replace($tplText, '(?s)<!--.*?-->', '')
        $tmp = New-TemporaryFile
        Set-Content -LiteralPath $tmp -Value $tplText -Encoding UTF8
        Scan-File $tmp 'modern' | ForEach-Object {
            $_.file = $f.FullName
            $modernRecords.Add($_) | Out-Null
        }
        Remove-Item $tmp -ErrorAction SilentlyContinue
    }
}
Write-Host ("  modern controls scanned: {0} across {1} html + {2} ts files" -f $modernRecords.Count, $modernFiles.Count, $modernTsFiles.Count)

# Additionally harvest tab/menu/navigation labels declared inline in TS data arrays
# (e.g. PjTabNavigationItem { label: 'View Phase Calcs', icon: 'fa fa-files-o' }).
# These never appear as label="..." HTML attributes but are real, user-visible labels.
foreach ($f in $modernTsFiles) {
    $raw = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $raw) { continue }
    # Match object literals containing label: 'X' (and optionally icon: 'Y') within a single { ... } block.
    $objMatches = [regex]::Matches($raw, "(?s)\{[^{}]*label\s*:\s*'([^']+)'[^{}]*\}")
    foreach ($om in $objMatches) {
        $obj = $om.Value
        $lbl = $om.Groups[1].Value.Trim()
        if (-not $lbl) { continue }
        $iconList = New-Object System.Collections.Generic.List[string]
        $iconMatch = [regex]::Match($obj, "icon\s*:\s*'([^']+)'")
        if ($iconMatch.Success) {
            foreach ($t in ($iconMatch.Groups[1].Value -split '\s+')) {
                if ($t -match '^fa-[a-z0-9\-]+$') { $iconList.Add($t) | Out-Null }
            }
        }
        $modernRecords.Add([pscustomobject]@{
            file        = $f.FullName
            tag         = 'ts-data'
            label       = $lbl.ToLowerInvariant()
            icons       = $iconList
            handler     = $null
            kind        = 'modern'
            interactive = $true
        }) | Out-Null
    }
}

# Also harvest dynamic [label] bindings of the form [label]="'Prefix ' + expr" or [label]="'Prefix' + expr".
# We use the leading string literal as a parity label, and lift the icon="..." attribute from the same opening tag.
foreach ($f in $modernFiles) {
    $raw = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $raw) { continue }
    $tagMatches = [regex]::Matches($raw, "(?si)<((?:app|fusion)-[a-z0-9\-]+)\b([^>]*?)(?:/?)>")
    foreach ($tm in $tagMatches) {
        $attrs = $tm.Groups[2].Value
        $dynMatch = [regex]::Match($attrs, "\[label\]\s*=\s*`"'([^']+)'\s*\+")
        if (-not $dynMatch.Success) { continue }
        $lbl = $dynMatch.Groups[1].Value.Trim().TrimEnd()
        if (-not $lbl) { continue }
        $iconList = New-Object System.Collections.Generic.List[string]
        $iconAttr = [regex]::Match($attrs, "\bicon\s*=\s*`"([^`"]+)`"")
        if ($iconAttr.Success) {
            foreach ($t in ($iconAttr.Groups[1].Value -split '\s+')) {
                if ($t -match '^fa-[a-z0-9\-]+$') { $iconList.Add($t) | Out-Null }
            }
        }
        $modernRecords.Add([pscustomobject]@{
            file        = $f.FullName
            tag         = 'dyn-label'
            label       = $lbl.ToLowerInvariant()
            icons       = $iconList
            handler     = $null
            kind        = 'modern'
            interactive = $true
        }) | Out-Null
    }
}

# Build modern lookup by normalized label.
$modernByLabel = @{}
foreach ($r in $modernRecords) {
    $key = $r.label
    if ([string]::IsNullOrWhiteSpace($key)) { continue }
    if (-not $modernByLabel.ContainsKey($key)) { $modernByLabel[$key] = New-Object System.Collections.Generic.List[object] }
    $modernByLabel[$key].Add($r) | Out-Null
}

# Compare.
$gaps = New-Object System.Collections.Generic.List[object]
$passiveLabelDrops = 0
$legacyInteractiveCount = 0
# Labels that match too broadly and are usually filter/option values rather than
# action controls. A missing interactive control with one of these labels is
# downgraded to Minor instead of Major to avoid filter-chip noise - but it is
# still reported, never silently dropped.
$ambiguousFilterLabels = @('all','selected','none','n/a','--','any')
foreach ($lr in $legacyRecords) {
    if ([string]::IsNullOrWhiteSpace($lr.label)) { continue }
    if ($lr.label.Length -lt 2) { continue }
    if ($lr.interactive) { $legacyInteractiveCount++ }
    # Wrap in @() to prevent PS7 from unrolling an empty-array else-branch into $null.
    $modernHits = @(if ($modernByLabel.ContainsKey($lr.label)) { $modernByLabel[$lr.label] })

    if ($modernHits.Count -eq 0) {
        if (-not $lr.interactive) {
            # Passive text / list item with no behavior - informational only.
            $passiveLabelDrops++
            continue
        }
        # A real interactive legacy control with no modern counterpart. This is
        # exactly the missing-button / missing-nav-link defect that the old
        # silent label-only drop bucket used to hide.
        $isAmbiguous = $ambiguousFilterLabels -contains $lr.label
        $gaps.Add([pscustomobject]@{
            severity      = $(if ($isAmbiguous) { 'Minor' } else { 'Major' })
            kind          = 'MissingControl'
            label         = $lr.label
            legacyIcon    = ($lr.icons -join ' ')
            legacyFile    = $lr.file
            legacyTag     = $lr.tag
            legacyHandler = $lr.handler
            modernMatch   = $null
        }) | Out-Null
        continue
    }

    # DEAD-CONTROL CHECK: the legacy control's label matched a modern element, but if the legacy
    # control is INTERACTIVE (button, routerLink, href, submit, trigger, or icon control) and NONE
    # of the modern matches is interactive, the modern "control" is a dead label-only stub - it
    # renders the right text but DOES NOTHING (a bare <a>Retrieve Files</a> with no routerLink, a
    # <span>Copy</span> with no handler). The plain label check treated it as present; this catches
    # the "looks-ported-but-inert" nav/button defect the label pass alone cannot see.
    if ($lr.interactive) {
        $modernInteractiveHits = @($modernHits | Where-Object { $_.interactive })
        if ($modernInteractiveHits.Count -eq 0) {
            $isAmbiguousDead = $ambiguousFilterLabels -contains $lr.label
            $gaps.Add([pscustomobject]@{
                severity      = $(if ($isAmbiguousDead) { 'Minor' } else { 'Major' })
                kind          = 'DeadControl'
                label         = $lr.label
                legacyIcon    = ($lr.icons -join ' ')
                legacyFile    = $lr.file
                legacyTag     = $lr.tag
                legacyHandler = $lr.handler
                modernMatch   = 'label present but the modern control has NO interactive behavior (no routerLink/href/(click)/submit/trigger/icon)'
            }) | Out-Null
            continue
        }
    }

    if ($lr.icons.Count -eq 0) { continue }

    # Has icon - check that at least one modern hit also has an icon (any icon counts as a soft pass; exact match raises Major to Minor).
    $modernWithAnyIcon = $modernHits | Where-Object { $_.icons.Count -gt 0 }
    if ($modernWithAnyIcon.Count -eq 0) {
        $gaps.Add([pscustomobject]@{
            severity    = 'Critical'
            kind        = 'MissingIcon'
            label       = $lr.label
            legacyIcon  = ($lr.icons -join ' ')
            legacyFile  = $lr.file
            legacyTag   = $lr.tag
            modernMatch = ($modernHits | Select-Object -First 1 -ExpandProperty file)
            modernIcon  = ''
        }) | Out-Null
        continue
    }
    # Optional: report exact icon mismatch. Resolve semantic markers to FA
    # classes first so 'semantic:cancel' compares equal to legacy 'fa-times-circle-o'.
    $legacyResolved = (Resolve-IconTokens $lr.icons | Sort-Object) -join ','
    $sameIcon = $modernWithAnyIcon | Where-Object {
        ((Resolve-IconTokens $_.icons | Sort-Object) -join ',') -eq $legacyResolved
    }
    if ($sameIcon.Count -eq 0) {
        $modernIconStr = (($modernWithAnyIcon | Select-Object -First 1 -ExpandProperty icons) -join ' ')
        # Documented intentional improvements where modern deliberately diverges
        # from legacy because the legacy icon was wrong, missing, or had no exact
        # label counterpart are loaded once from the per-app registry's
        # iconMismatchAllowlist near the top of this script (key shape
        # 'label||legacyIcon||modernIcon'); they are never hard-coded here.
        $allowlistKey = ('{0}||{1}||{2}' -f $lr.label, (($lr.icons -join ' ').Trim()), $modernIconStr.Trim())
        if (-not $intentionalImprovements.ContainsKey($allowlistKey)) {
            $gaps.Add([pscustomobject]@{
                severity    = 'Minor'
                kind        = 'IconMismatch'
                label       = $lr.label
                legacyIcon  = ($lr.icons -join ' ')
                legacyFile  = $lr.file
                legacyTag   = $lr.tag
                modernMatch = ($modernWithAnyIcon | Select-Object -First 1 -ExpandProperty file)
                modernIcon  = $modernIconStr
            }) | Out-Null
        }
    }
}

# ---------------------------------------------------------------------
# DIMENSION PASS: color/severity
# ---------------------------------------------------------------------
# For every legacy control that has both a label AND a Bootstrap-derived color
# token, find the modern record by label and compare colors. Divergences are
# emitted as Minor 'ColorMismatch' gaps. This is the second built-in rule pack
# and demonstrates the dimension-pack pattern; copy this block + add a new
# allowlist to wire a third dimension (tooltip, disabled-binding,
# visibility-binding, etc.). Documented intentional color divergences are loaded
# once from the per-app registry's colorMismatchAllowlist near the top of this
# script (key shape 'label||legacyColor||modernColor'), never hard-coded here.
foreach ($lr in $legacyRecords) {
    if (-not $lr.color) { continue }
    if ([string]::IsNullOrWhiteSpace($lr.label)) { continue }
    if (-not $modernByLabel.ContainsKey($lr.label)) { continue }
    $modernHits = $modernByLabel[$lr.label]
    $modernColored = @($modernHits | Where-Object { $_.color })
    if ($modernColored.Count -eq 0) { continue }
    $sameColor = @($modernColored | Where-Object { $_.color -eq $lr.color })
    if ($sameColor.Count -gt 0) { continue }
    $mc = $modernColored | Select-Object -First 1
    $key = ('{0}||{1}||{2}' -f $lr.label, $lr.color, $mc.color)
    if ($colorAllowlist.ContainsKey($key)) { continue }
    $gaps.Add([pscustomobject]@{
        severity    = 'Minor'
        kind        = 'ColorMismatch'
        label       = $lr.label
        legacyColor = $lr.color
        legacyFile  = $lr.file
        legacyTag   = $lr.tag
        modernMatch = $mc.file
        modernColor = $mc.color
    }) | Out-Null
}

# ---------------------------------------------------------------------
# DIMENSION PASS: grid column parity (column-collapse detector)
# ---------------------------------------------------------------------
# Catches the "grid re-created thinner" defect: a modern grid that renders real
# data but in fewer or more generic columns than the legacy grid (for example
# several typed legacy columns folded into one generic 'details' column). The
# grid passes the label/icon passes (the grid element exists) and the data binds,
# but user-facing fields are gone - invisible to those passes and to a pixel diff.
#
# Column headers are harvested app-agnostically from the common grid-declaration
# shapes across frameworks, on BOTH the markup side and the .ts side (ag-grid /
# Kendo / ColDef arrays frequently live in component .ts, not in templates):
#   <th ...>Header</th>                        (server + SPA tables)
#   headerName: 'Header'                       (ag-grid / generic ColDef .ts)
#   { field: '...', title: 'Header' }          (modern data-grid ColDef .ts)
#   <fusion-data-grid-column ... title="Header">  (Fusion data grid markup)
#   <kendo-grid-column ... title="Header">     (Kendo grid markup)
# A legacy column header with no modern column counterpart (by normalized label)
# is a MissingColumn Major gap. Matching is global (any modern grid counts), so
# the detector under-reports rather than false-blocks an app.
function Get-ColumnLabels([string]$text) {
    $out = New-Object System.Collections.Generic.List[string]
    if (-not $text) { return ,$out }
    $text = [regex]::Replace($text, '(?s)<!--.*?-->', '')
    $text = [regex]::Replace($text, '(?s)@\*.*?\*@', '')
    $patterns = @(
        '(?si)<th\b[^>]*>(.*?)</th>',
        '(?i)headerName\s*:\s*[\x27\x22]([^\x27\x22]+)[\x27\x22]',
        '(?si)<(?:fusion-data-grid-column|kendo-grid-column)\b[^>]*\btitle\s*=\s*[\x22]([^\x22]+)[\x22]',
        '(?s)\{[^{}]*\bfield\s*:\s*[\x27\x22][^\x27\x22]*[\x27\x22][^{}]*\btitle\s*:\s*[\x27\x22]([^\x27\x22]+)[\x27\x22]',
        '(?s)\{[^{}]*\btitle\s*:\s*[\x27\x22]([^\x27\x22]+)[\x27\x22][^{}]*\bfield\s*:\s*[\x27\x22]'
    )
    foreach ($pat in $patterns) {
        foreach ($m in [regex]::Matches($text, $pat)) {
            $lbl = Normalize-Label $m.Groups[1].Value
            $lbl = $lbl.TrimEnd('.', ' ')
            if ($lbl -and $lbl.Length -ge 2 -and $lbl.Length -le 60) { $out.Add($lbl) | Out-Null }
        }
    }
    return ,$out
}

# Generic non-data header cells (selection checkbox, row-action column) that are
# expected to differ and are not user data fields.
$nonDataColumnHeaders = @('actions', 'action', '', '#', 'select', 'sel')
# Documented intentional column removals (normalized label -> reason). Add a row
# to accept a deliberately dropped legacy column; remove it to re-flag the drop.
$missingColumnAllowlist = @{ }

$legacyColumnSource = @{}
foreach ($f in $legacyFiles) {
    foreach ($c in (Get-ColumnLabels (Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue))) {
        if (-not $legacyColumnSource.ContainsKey($c)) { $legacyColumnSource[$c] = $f.FullName }
    }
}
# Enumerate legacy .ts for ag-grid/ColDef column declarations, pruning heavy
# generated/vendored trees DURING the walk. LegacyRoot is the repo-relative
# LegacyCode root, which (unlike the modern client 'src' folder) can contain a
# legacy node_modules with thousands of .ts files; a plain -Recurse would walk
# all of it. This bounded BFS skips those trees so the scan stays fast.
$legacyTsFiles = New-Object System.Collections.Generic.List[object]
if (Test-Path $LegacyRoot) {
    $walkQueue = [System.Collections.Generic.Queue[string]]::new()
    $walkQueue.Enqueue((Convert-Path $LegacyRoot))
    while ($walkQueue.Count -gt 0) {
        $dir = $walkQueue.Dequeue()
        if ($dir -match '(?i)node_modules|\\bin\\|\\obj\\|\\dist\\|\\.angular\\|\\coverage\\|\\out-tsc\\|\\packages\\') { continue }
        foreach ($tsf in (Get-ChildItem -LiteralPath $dir -File -Filter *.ts -ErrorAction SilentlyContinue)) { $legacyTsFiles.Add($tsf) | Out-Null }
        foreach ($sub in (Get-ChildItem -LiteralPath $dir -Directory -ErrorAction SilentlyContinue)) { $walkQueue.Enqueue($sub.FullName) }
    }
}
foreach ($f in $legacyTsFiles) {
    foreach ($c in (Get-ColumnLabels (Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue))) {
        if (-not $legacyColumnSource.ContainsKey($c)) { $legacyColumnSource[$c] = $f.FullName }
    }
}
$modernColumnSet = New-Object System.Collections.Generic.HashSet[string]
foreach ($f in (@($modernFiles) + @($modernTsFiles))) {
    foreach ($c in (Get-ColumnLabels (Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue))) { [void]$modernColumnSet.Add($c) }
}
foreach ($lc in ($legacyColumnSource.Keys | Sort-Object)) {
    if ($nonDataColumnHeaders -contains $lc) { continue }
    if ($modernColumnSet.Contains($lc)) { continue }
    if ($missingColumnAllowlist.ContainsKey($lc)) { continue }
    $gaps.Add([pscustomobject]@{
        severity    = 'Major'
        kind        = 'MissingColumn'
        label       = $lc
        legacyFile  = $legacyColumnSource[$lc]
        legacyTag   = 'grid-column'
        modernMatch = $null
    }) | Out-Null
}
$unmappedColumnCount = @($gaps | Where-Object { $_.kind -eq 'MissingColumn' }).Count

# ---------------------------------------------------------------------
# DIMENSION PASS: inert / stubbed control detection
# ---------------------------------------------------------------------
# Catches "present but inert": a control renders and is visible but its handler
# is an empty / TODO-only method body, or it is permanently disabled by a literal
# [disabled]="true". The label/icon passes see the control as present; only this
# pass sees the behavior is gone. Authoritative inert detection is the runtime
# checkpoint (click it, nothing happens); this static pass is the cheap early
# signal at Step 10/11. Scoped PER COMPONENT - a component's template is checked
# only against that component's own empty methods - so a same-named real method
# in another component never false-flags.
$jsKeywordNames = @('if', 'for', 'while', 'switch', 'catch', 'function', 'return', 'do', 'else', 'try', 'typeof', 'await', 'new', 'of', 'in', 'constructor', 'ngoninit', 'ngondestroy', 'ngafterviewinit', 'ngonchanges', 'ngdocheck', 'ngaftercontentinit', 'ngafterviewchecked')
# The inert-control deferral registry ($inertControlAllowlist, $deferralOwnerStep) and the
# $deferredInertControls surfacing list are loaded once from the per-app registry near the
# top of this script (see PER-APP REGISTRY LOAD).
foreach ($f in $modernTsFiles) {
    $tsRaw = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $tsRaw) { continue }
    # Empty / comment-only method bodies in THIS component only.
    $localInert = New-Object System.Collections.Generic.HashSet[string]
    foreach ($mm in [regex]::Matches($tsRaw, '(?s)(?:protected\s+|public\s+|private\s+)?([A-Za-z_]\w*)\s*\(([^()]*)\)\s*(?::\s*[\w<>\[\]\| ]+\s*)?\{\s*((?:/\*.*?\*/|//[^\r\n]*|\s)*)\}')) {
        $name = $mm.Groups[1].Value
        if ($jsKeywordNames -contains $name.ToLowerInvariant()) { continue }
        [void]$localInert.Add($name)
    }
    # Gather this component's template: sibling .html + inline template:`...`.
    $tpl = ''
    $sibling = [System.IO.Path]::ChangeExtension($f.FullName, '.html')
    if (Test-Path $sibling) { $tpl += (Get-Content -LiteralPath $sibling -Raw -ErrorAction SilentlyContinue) }
    foreach ($tm in [regex]::Matches($tsRaw, '(?s)template\s*:\s*[\x60\x27\x22]([^\x60\x27\x22]+)[\x60\x27\x22]')) { $tpl += "`n" + $tm.Groups[1].Value }
    if ([string]::IsNullOrWhiteSpace($tpl)) { continue }
    $tpl = [regex]::Replace($tpl, '(?s)<!--.*?-->', '')
    $seenInert = New-Object System.Collections.Generic.HashSet[string]
    # (click)/(pressed) bound to a local empty / TODO-only method.
    foreach ($cm in [regex]::Matches($tpl, '(?i)\((?:click|pressed)\)\s*=\s*[\x22]\s*([A-Za-z_]\w*)\s*\(')) {
        $h = $cm.Groups[1].Value
        if (-not $localInert.Contains($h)) { continue }
        if ($inertControlAllowlist.ContainsKey($h)) {
            $ownerStep = if ($deferralOwnerStep.ContainsKey($h)) { $deferralOwnerStep[$h] } else { $null }
            # Stale/overdue once the run reaches or passes the owner step: at step N
            # closeout, every deferral owned by N or earlier must already be wired.
            $isStale = ($CurrentStep -gt 0 -and $null -ne $ownerStep -and $ownerStep -le $CurrentStep)
            if (-not $isStale) {
                # Suppressed but never invisible: surfaced in the summary so a zero inert
                # count cannot hide a parked stub.
                if ($seenInert.Add('def:' + $h)) {
                    $deferredInertControls.Add([pscustomobject]@{
                        handler   = $h
                        ownerStep = $ownerStep
                        reason    = $inertControlAllowlist[$h]
                        file      = $f.FullName
                    }) | Out-Null
                }
                continue
            }
            # Stale deferral: owner step already complete but handler still inert.
            # Fall through and emit it as a Major InertControl (the drain gate).
        }
        if (-not $seenInert.Add('h:' + $h)) { continue }
        $gaps.Add([pscustomobject]@{
            severity    = 'Major'
            kind        = 'InertControl'
            label       = $h
            legacyFile  = $f.FullName
            legacyTag   = 'stubbed-handler'
            modernMatch = $f.FullName
        }) | Out-Null
    }
    # Permanently disabled action control: literal [disabled]="true".
    foreach ($dm in [regex]::Matches($tpl, '(?si)<(?:button|fusion-button|a)\b[^>]*\[disabled\]\s*=\s*[\x22]true[\x22]')) {
        if (-not $seenInert.Add('d:' + $dm.Index)) { continue }
        $gaps.Add([pscustomobject]@{
            severity    = 'Major'
            kind        = 'InertControl'
            label       = 'disabled=true'
            legacyFile  = $f.FullName
            legacyTag   = 'permanently-disabled'
            modernMatch = $f.FullName
        }) | Out-Null
    }

    # PLACEHOLDER-ACTION CHECK: a mutation-intent action button (Add/Edit/Delete/Save/Submit/
    # Remove/Clear/Update/Manage/Export/Create) whose (click) handler ONLY opens or closes a
    # modal-visibility flag (`this.showXModal = true`) and does NO real work - no service call,
    # no await, no state mutation - is a DEAD ACTION. It looks wired (the handler is not empty,
    # so the InertControl check passes) but it opens a placeholder modal that performs nothing.
    # This is exactly how "Add Row / Edit / Delete" shipped green while doing nothing. The
    # backend-parity gate catches the missing endpoint; THIS catches the dead UI action even
    # when an endpoint exists. Deferral-registry entries suppress but always surface it.
    # Handler body that is ONLY modal-flag assignments (one or more `this.<flag> = true|false;`).
    $modalOnlyHandlers = @{}
    foreach ($mm in [regex]::Matches($tsRaw, '(?s)(?:protected\s+|public\s+|private\s+)?([A-Za-z_]\w*)\s*\(([^()]*)\)\s*(?::\s*[\w<>\[\]\| ]+\s*)?\{\s*((?:this\.\w*(?i:modal|dialog|show|open|flag)\w*\s*=\s*(?:true|false)\s*;\s*)+)\}')) {
        $name = $mm.Groups[1].Value
        if ($jsKeywordNames -contains $name.ToLowerInvariant()) { continue }
        $modalOnlyHandlers[$name] = $true
    }
    $mutationVerbRe = '(?i)(add|edit|delete|remove|save|submit|clear|update|manage|export|create|new|bulk|link)'
    foreach ($cm in [regex]::Matches($tpl, '(?i)\((?:click|pressed)\)\s*=\s*[\x22]\s*([A-Za-z_]\w*)\s*\(')) {
        $h = $cm.Groups[1].Value
        if (-not $modalOnlyHandlers.ContainsKey($h)) { continue }
        # Only flag when the handler NAME signals a mutation action (avoid flagging showHelp,
        # showConsent, and other benign modal openers that are read-only dialogs).
        if ($h -notmatch $mutationVerbRe) { continue }
        # Honor the per-app deferral registry: a registered handler is surfaced, not blocked,
        # until its owner step is reached (same drain semantics as InertControl).
        if ($inertControlAllowlist.ContainsKey($h)) {
            $ownerStep = if ($deferralOwnerStep.ContainsKey($h)) { $deferralOwnerStep[$h] } else { $null }
            $isStale = ($CurrentStep -gt 0 -and $null -ne $ownerStep -and $ownerStep -le $CurrentStep)
            if (-not $isStale) {
                if ($seenInert.Add('pa-def:' + $h)) {
                    $deferredInertControls.Add([pscustomobject]@{
                        handler   = $h
                        ownerStep = $ownerStep
                        reason    = $inertControlAllowlist[$h]
                        file      = $f.FullName
                    }) | Out-Null
                }
                continue
            }
        }
        if (-not $seenInert.Add('pa:' + $h)) { continue }
        $gaps.Add([pscustomobject]@{
            severity    = 'Major'
            kind        = 'PlaceholderAction'
            label       = $h
            legacyFile  = $f.FullName
            legacyTag   = 'modal-open-only'
            modernMatch = 'mutation-action button opens a modal flag but performs no real work (no service call / mutation)'
        }) | Out-Null
    }
}
$inertControlCount = @($gaps | Where-Object { $_.kind -eq 'InertControl' }).Count
$deferredInertControlCount = $deferredInertControls.Count

# ---------------------------------------------------------------------
# DISCOVERY PROBE OUTPUT
# ---------------------------------------------------------------------
# Sort the discovery bag descending by frequency so the next app's most-common
# unrecognized legacy attribute or class family rises to the top of the report.
# Anything appearing here is a candidate for a new dimension rule pack.
$discoveryEntries = @()
foreach ($k in $script:DiscoveryBag.Keys) {
    $discoveryEntries += [pscustomobject]@{ token = $k; count = [int]$script:DiscoveryBag[$k] }
}
$discoveryEntries = $discoveryEntries | Sort-Object -Property count -Descending

# ---------------------------------------------------------------------
# CONTROL COVERAGE
# ---------------------------------------------------------------------
# Honest coverage signal: how many interactive controls the modern app has
# relative to the legacy app. A missing interactive control is already a Major
# MissingControl gap above; this ratio is the coarse safety net that catches a
# wholesale shortfall even when exact label matching is imperfect.
$modernInteractiveCount = @($modernRecords | Where-Object { $_.interactive }).Count
$unmappedInteractiveCount = @($gaps | Where-Object { $_.kind -eq 'MissingControl' }).Count
$controlCoverageRatio = if ($legacyInteractiveCount -gt 0) { [math]::Round($modernInteractiveCount / $legacyInteractiveCount, 3) } else { $null }

# Optional hard floor for closeout steps. Off by default (0) so early foundation
# passes are not blocked while modern coverage is legitimately still climbing.
if ($CoverageFloor -gt 0 -and $null -ne $controlCoverageRatio -and $controlCoverageRatio -lt $CoverageFloor) {
    $gaps.Add([pscustomobject]@{
        severity    = 'Critical'
        kind        = 'LowControlCoverage'
        label       = ''
        legacyFile  = ''
        legacyTag   = ''
        modernMatch = $null
        detail      = ("Modern interactive control coverage {0} is below the required floor {1} ({2} of {3} legacy interactive controls)." -f $controlCoverageRatio, $CoverageFloor, $modernInteractiveCount, $legacyInteractiveCount)
    }) | Out-Null
}

# Group + summarize.
$summary = [pscustomobject]@{
    generatedUtc = (Get-Date).ToUniversalTime().ToString('o')
    legacyControlsScanned = $legacyRecords.Count
    modernControlsScanned = $modernRecords.Count
    legacyInteractiveControls = $legacyInteractiveCount
    modernInteractiveControls = $modernInteractiveCount
    controlCoverageRatio = $controlCoverageRatio
    coverageFloor = $CoverageFloor
    unmappedInteractiveControlCount = $unmappedInteractiveCount
    passiveLabelDrops = $passiveLabelDrops
    labelOnlyDropsIgnored = $passiveLabelDrops
    legacyColumnsScanned = $legacyColumnSource.Count
    modernColumnsScanned = $modernColumnSet.Count
    unmappedColumnCount = $unmappedColumnCount
    inertControlCount = $inertControlCount
    deferredInertControlCount = $deferredInertControlCount
    deferredInertControls = $deferredInertControls
    totalGaps     = $gaps.Count
    criticalGaps  = @($gaps | Where-Object severity -eq 'Critical').Count
    majorGaps     = @($gaps | Where-Object severity -eq 'Major').Count
    minorGaps     = @($gaps | Where-Object severity -eq 'Minor').Count
    byKind        = ($gaps | Group-Object kind | Select-Object Name, Count)
    dimensions    = @('label','icon','color','column','handler-wiring','deferral-drain')
    discoveryProbe = [pscustomobject]@{
        description = 'Legacy attributes/class families NOT consumed by any active dimension rule pack. Top entries are candidates for the next rule pack. As coverage grows, this list shrinks toward zero and unknown-unknown parity defects approach zero.'
        total       = $discoveryEntries.Count
        top         = ($discoveryEntries | Select-Object -First 25)
        all         = $discoveryEntries
    }
    gaps          = $gaps
}

$outDir = Split-Path $OutputPath -Parent
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
$summary | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
Write-Host ""
Write-Host ("PARITY GAP SCAN COMPLETE -> {0}" -f $OutputPath) -ForegroundColor Cyan
Write-Host ("  Critical : {0}" -f $summary.criticalGaps) -ForegroundColor $(if ($summary.criticalGaps) { 'Red' } else { 'Green' })
Write-Host ("  Major    : {0}" -f $summary.majorGaps) -ForegroundColor $(if ($summary.majorGaps) { 'Yellow' } else { 'Green' })
Write-Host ("  Minor    : {0}" -f $summary.minorGaps)
Write-Host ("  Columns  : {0} legacy / {1} modern ({2} missing)" -f $summary.legacyColumnsScanned, $summary.modernColumnsScanned, $summary.unmappedColumnCount) -ForegroundColor $(if ($summary.unmappedColumnCount) { 'Yellow' } else { 'Green' })
Write-Host ("  Inert    : {0}" -f $summary.inertControlCount) -ForegroundColor $(if ($summary.inertControlCount) { 'Yellow' } else { 'Green' })
Write-Host ("  Deferred : {0} parked stub(s) surfaced (run with -CurrentStep to drain overdue ones)" -f $summary.deferredInertControlCount) -ForegroundColor $(if ($summary.deferredInertControlCount) { 'Yellow' } else { 'Green' })

if (-not $Quiet -and $gaps.Count -gt 0) {
    Write-Host ""
    Write-Host "Top 30 gaps:" -ForegroundColor Cyan
    $gaps | Sort-Object @{Expression={ switch ($_.severity) { 'Critical' { 0 } 'Major' { 1 } 'Minor' { 2 } default { 3 } } }} |
        Select-Object -First 30 severity, kind, label, legacyIcon, modernIcon |
        Format-Table -AutoSize -Wrap
}

if ($summary.criticalGaps -gt 0 -or $summary.majorGaps -gt 0) { exit 2 } else { exit 0 }





