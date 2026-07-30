<#
.SYNOPSIS
    Deterministic scaffold-debt detector: finds modernization deferral MARKERS that survive in
    shipped src/ code (stub comments, "wired in a later step" notes, placeholder bodies) so the
    kit catches unfinished behavior generically, for ANY app, without an agent eyeballing source.

.DESCRIPTION
    The dead-shell failure mode is a page migrated as a from-memory SCAFFOLD whose controls,
    forms, and handlers are stubbed and whose real behavior is deferred to "a later step". Those
    scaffolds routinely ANNOUNCE their own debt in the code with breadcrumb comments such as:
      "Handlers call empty stub methods; Step 11 wires real behavior"
      "The full row form is wired in a later step"
      "isAdmin = false  // Wired to real auth in Step 12"
      "placeholder data", "not yet wired", "TODO wire ..."
    No parity/runtime gate scanned for these surviving markers, so the debt shipped silently.

    This scanner is the generic, app-agnostic detector for that class. It walks the modern client
    source and flags high-signal deferral markers, extracting the owning step number when the
    marker names one (e.g. "Step 11 wires ..."). It is intentionally conservative: the marker
    patterns are modernization-scaffold LANGUAGE, not app terms, and an accepted-marker registry
    lets a team keep a genuinely-intentional note without turning the gate off.

    Drain semantics (identical to the parity deferral-drain gate):
      - With -CurrentStep N, any marker whose owning step is reached or passed (impliedStep <= N)
        is OVERDUE and blocks (exit 2). This is how a "Step 11 wires this" note that survives to
        Step 12 closeout fails the gate instead of shipping.
      - Markers with no owning step are always surfaced (tracked) but only block when -Strict is
        set, so early passes are not blocked while scaffolding is legitimately in progress.

    Output:
      .modernization/ignition-artifacts/discovery/scaffold-debt-scan.json

    Exit codes:
      0 = no blocking (overdue) markers
      2 = one or more overdue markers (or any tracked marker when -Strict)

    Content-only and repeatable - no running app or auth needed. This complements, not replaces,
    the runtime behavioral checkpoint: this catches DECLARED debt statically; the runtime
    interact-and-assert checkpoint catches behavioral effects a static scan cannot see.
#>
param(
    [string]$ModernClientRoot = '',
    [string]$OutputPath = '.\.modernization\ignition-artifacts\discovery\scaffold-debt-scan.json',
    # The step currently running. When > 0, a marker whose owning step has been reached or passed
    # (impliedStep <= CurrentStep) is OVERDUE and blocks.
    [int]$CurrentStep = 0,
    # Optional per-app accepted-marker registry. Defaults to 'scaffold-debt-registry.json' beside
    # the output. Shape: { "acceptedMarkers": [ { "file": "<substr>", "textContains": "<substr>", "reason": "..." } ] }
    [string]$RegistryPath = '',
    # When set, ANY surviving marker (even one with no owning step) blocks. Use at Phase-2 close.
    [switch]$Strict,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------
# Resolve the modern client root (same derivation the parity scanner uses) so this
# script stays app-agnostic: identity comes from kit-params.md, never a hard-coded name.
# ---------------------------------------------------------------
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
        $first = Get-ChildItem -Path .\src -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -match '\.Web\.Client$' -and (Test-Path (Join-Path $_.FullName 'src')) } |
            Select-Object -First 1
        if ($first) { $ModernClientRoot = (Join-Path $first.FullName 'src') }
    }
    if (-not $ModernClientRoot) {
        throw "Could not determine ModernClientRoot. Pass -ModernClientRoot or populate .modernization/.readme/kit-params.md with appName."
    }
}

# ---------------------------------------------------------------
# MARKER RULE SET (generic modernization-scaffold language, never app terms)
# ---------------------------------------------------------------
# Each rule: Kind (report label) + Pattern (case-insensitive regex). Patterns are tuned for
# HIGH signal so real code is never flagged; a rule is added only when the phrase is
# unambiguous modernization-scaffold language (a deferral breadcrumb), never a domain word or
# a legitimate framework feature. The word 'placeholder' is deliberately NOT a trigger: it is
# a real input feature and appears in correct code, so matching it produced false positives on
# known-good wrappers. A genuinely shipped placeholder grid is caught by the parity scanner
# (inert/empty data) and the runtime checkpoint, and a deliberate one carries a step marker below.
$MarkerRules = @(
    [pscustomobject]@{ Kind = 'StepDeferral';      Pattern = '(?i)\bstep\s+\d+\s+(wires?|adds?|proves?|handles?|owns|will\s+wire|hooks?\s+up)\b' }
    [pscustomobject]@{ Kind = 'WiredLaterStep';    Pattern = '(?i)\bwired?\b[^.\r\n]{0,60}\b(in\s+a\s+later\s+step|in\s+step\s+\d+)\b' }
    [pscustomobject]@{ Kind = 'LaterStep';         Pattern = '(?i)\bin\s+a\s+later\s+step\b' }
    [pscustomobject]@{ Kind = 'StubHandler';       Pattern = '(?i)\b(empty\s+stub|stub\s+method|stubbed\s+(handler|method|behaviou?r)|call\s+empty\s+stub)\b' }
    [pscustomobject]@{ Kind = 'NotYetWired';       Pattern = '(?i)\bnot\s+yet\s+(wired|implemented|built|hooked|added)\b' }
    [pscustomobject]@{ Kind = 'RealBehaviorLater'; Pattern = '(?i)\breal\s+(behaviou?r|form|service|auth|data|modal|api)\b[^.\r\n]{0,50}\b(later|in\s+step\s+\d+|a\s+later\s+step)\b' }
    [pscustomobject]@{ Kind = 'FormWiredLater';    Pattern = '(?i)\bform\b[^.\r\n]{0,40}\bwired\b[^.\r\n]{0,20}\b(later|step\s+\d+)\b' }
    [pscustomobject]@{ Kind = 'WireInStep';        Pattern = '(?i)\bwire[sd]?\b[^.\r\n]{0,40}\bin\s+step\s+\d+\b' }
    # A rendered scaffold-placeholder element (exact CSS class hook) is a shipped placeholder
    # standing in for a real control/grid. Unlike the generic word 'placeholder' (deliberately
    # not a trigger), this exact class is unambiguous scaffold debt and is always blocking - a
    # placeholder that ships as final state is a defect at any step, so it is forced overdue below.
    [pscustomobject]@{ Kind = 'ScaffoldPlaceholder'; Pattern = '(?i)class\s*=\s*["''][^"'']*\bscaffold-placeholder\b' }
)

# A marker that is genuinely intentional can be accepted in the per-app registry (like the
# parity deferral registry). This keeps app facts out of this reusable script.
$acceptedMarkers = @()
if (-not $RegistryPath -or [string]::IsNullOrWhiteSpace($RegistryPath)) {
    $RegistryPath = Join-Path (Split-Path $OutputPath -Parent) 'scaffold-debt-registry.json'
}
if (Test-Path $RegistryPath) {
    try {
        $registry = Get-Content -LiteralPath $RegistryPath -Raw | ConvertFrom-Json
        $acceptedMarkers = @($registry.acceptedMarkers)
    } catch {
        Write-Verbose ("Could not parse scaffold-debt registry {0}: {1}" -f $RegistryPath, $_.Exception.Message)
    }
}

function Test-MarkerAccepted {
    param([string]$RelFile, [string]$Text)
    foreach ($a in $acceptedMarkers) {
        if ($null -eq $a) { continue }
        $fileOk = (-not $a.file) -or [string]::IsNullOrWhiteSpace([string]$a.file) -or ($RelFile -like ('*' + [string]$a.file + '*'))
        $textOk = (-not $a.textContains) -or [string]::IsNullOrWhiteSpace([string]$a.textContains) -or ($Text -like ('*' + [string]$a.textContains + '*'))
        if ($fileOk -and $textOk) { return $true }
    }
    return $false
}

$excludePattern = '\\node_modules\\|\\dist\\|\\.angular\\|\\coverage\\|\\out-tsc\\|\\bin\\|\\obj\\|\.spec\.ts$'
$files = @(Get-ChildItem -Path (Join-Path $ModernClientRoot '*') -Recurse -Include *.ts,*.html -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern })

$repoRootFull = (Get-Location).Path
$findings = New-Object System.Collections.Generic.List[object]

foreach ($f in $files) {
    $lines = Get-Content -LiteralPath $f.FullName -ErrorAction SilentlyContinue
    if (-not $lines) { continue }
    $rel = $f.FullName
    if ($rel.StartsWith($repoRootFull)) { $rel = $rel.Substring($repoRootFull.Length).TrimStart('\', '/') }
    $rel = $rel -replace '\\', '/'
    $lineNo = 0
    foreach ($line in $lines) {
        $lineNo++
        foreach ($rule in $MarkerRules) {
            $m = [regex]::Match($line, $rule.Pattern)
            if (-not $m.Success) { continue }
            $text = $line.Trim()
            if ($text.Length -gt 200) { $text = $text.Substring(0, 200) }
            $accepted = Test-MarkerAccepted -RelFile $rel -Text $text
            # Owning step: the step named in the marker line, if any.
            $impliedStep = $null
            $stepMatch = [regex]::Match($line, '(?i)\bstep\s+(\d+)\b')
            if ($stepMatch.Success) { $impliedStep = [int]$stepMatch.Groups[1].Value }

            $severity = 'tracked'
            if ($accepted) {
                $severity = 'accepted'
            } elseif ($rule.Kind -eq 'ScaffoldPlaceholder') {
                $severity = 'overdue'    # a rendered scaffold-placeholder element is shipped debt now, at any step
            } elseif ($CurrentStep -gt 0 -and $null -ne $impliedStep -and $impliedStep -le $CurrentStep) {
                $severity = 'overdue'    # owning step reached/passed but debt survives -> block
            } elseif ($Strict) {
                $severity = 'overdue'    # closeout strictness: any surviving marker blocks
            }

            $findings.Add([pscustomobject]@{
                file        = $rel
                line        = $lineNo
                kind        = $rule.Kind
                impliedStep = $impliedStep
                severity    = $severity
                text        = $text
            }) | Out-Null
            break   # one finding per line is enough
        }
    }
}

$overdue  = @($findings | Where-Object { $_.severity -eq 'overdue' })
$tracked  = @($findings | Where-Object { $_.severity -eq 'tracked' })
$accepted = @($findings | Where-Object { $_.severity -eq 'accepted' })

$summary = [pscustomobject]@{
    generatedUtc     = (Get-Date).ToUniversalTime().ToString('o')
    modernClientRoot = ($ModernClientRoot -replace '\\', '/')
    currentStep      = $CurrentStep
    strict           = [bool]$Strict
    filesScanned     = $files.Count
    totalMarkers     = $findings.Count
    overdueMarkers   = $overdue.Count
    trackedMarkers   = $tracked.Count
    acceptedMarkers  = $accepted.Count
    byKind           = ($findings | Group-Object kind | Select-Object Name, Count)
    findings         = $findings
}

$outDir = Split-Path $OutputPath -Parent
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
$summary | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $OutputPath -Encoding UTF8

if (-not $Quiet) {
    Write-Host ""
    Write-Host ("SCAFFOLD-DEBT SCAN COMPLETE -> {0}" -f $OutputPath) -ForegroundColor Cyan
    Write-Host ("  Files scanned : {0}" -f $summary.filesScanned)
    Write-Host ("  Overdue       : {0}" -f $summary.overdueMarkers) -ForegroundColor $(if ($summary.overdueMarkers) { 'Red' } else { 'Green' })
    Write-Host ("  Tracked       : {0} (surviving markers not yet owed)" -f $summary.trackedMarkers) -ForegroundColor $(if ($summary.trackedMarkers) { 'Yellow' } else { 'Green' })
    Write-Host ("  Accepted      : {0}" -f $summary.acceptedMarkers)
    if ($overdue.Count -gt 0) {
        Write-Host ""
        Write-Host "Overdue markers (owning step reached but debt survives):" -ForegroundColor Red
        $overdue | Select-Object -First 30 | ForEach-Object { Write-Host ("  {0}:{1}  [{2}]  {3}" -f $_.file, $_.line, $_.kind, $_.text) }
    }
}

if ($overdue.Count -gt 0) { exit 2 } else { exit 0 }
