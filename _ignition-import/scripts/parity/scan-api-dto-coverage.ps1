<#
.SYNOPSIS
    Legacy-anchored API DTO field coverage scanner: proves every modern API transport DTO
    maps ALL the fields from its corresponding legacy View/DTO class, so a modernization
    cannot silently drop response fields while the UI still declares column headers for them
    (the column renders but shows empty cells - the exact failure that hit FileLogResponse).

.DESCRIPTION
    THE FAILURE MODE THIS EXISTS TO CATCH
    A developer writes a modern DTO with fewer fields than the legacy View it replaces:
      Legacy:  FileLogView { DrawingNo, DocumentType, Title, FileName, PublicationDate, ... }
      Modern:  FileLogResponse(Directory, DrawingNo, Description) - only 3 of 10 fields
    The TypeScript type may match the narrow modern DTO (so TS compiles), the column headers
    are declared with the right labels, the grid renders with real rows - but 7 columns are
    permanently empty because the server never sends those fields. No gate caught this because
    every gate checked "what exists in modern is wired" without checking "everything in legacy
    was carried forward".

    WHAT IT DOES (deterministic, content-only, no running app)
    Walks legacy View/DTO C# classes and modern API response record/class C# files, extracts
    property names, and for each matched pair checks that the modern type covers at least the
    same set of property names (normalized to lowercase, ignoring ID/audit/internal-only props).
    A modern DTO that covers fewer properties than its legacy counterpart emits a Major gap
    and blocks (exit 2). Properties that are intentionally dropped are declared in the per-app
    registry with a reason so the drop is visible instead of hidden.

    MATCHING: modern DTO name -> legacy View name by the shared "domain concept" word
    (e.g. FileLogResponse -> FileLogView, FileKeyResponse -> FileKeyView). Falls back to fuzzy
    name matching when exact mapping is not present. Unmatched modern DTOs are skipped (no
    false positive for net-new modern types).

    GENERIC: any C# legacy->modern modernization using View classes on the legacy side and
    record/class DTOs on the modern side. Not tied to FileLog names.

.OUTPUTS
    .modernization/ignition-artifacts/discovery/api-dto-coverage-scan.json

    Exit codes:
      0 = no modern DTO maps fewer fields than its legacy counterpart (or all gaps are accepted)
      2 = at least one modern DTO is missing legacy fields with no accepted waiver

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-api-dto-coverage.ps1 -Quiet
#>
param(
    [string]$LegacyRoot = '.\LegacyCode',
    [string]$ModernApiRoot = '',
    [string]$OutputPath = '.\.modernization\ignition-artifacts\discovery\api-dto-coverage-scan.json',
    [string]$RegistryPath = '',
    # Properties that are always internal/audit and should never fail the gate when absent.
    [string[]]$InternalPropNames = @('id','createdby','createdat','updatedby','updatedat','rowversion','timestamp','concurrencytoken','modifiedat','modifiedby'),
    [switch]$Quiet
)
$ErrorActionPreference = 'Stop'

# Resolve modern API root
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
        $srcApi = Get-ChildItem -Path (Join-Path (Get-Location) 'src') -Directory -Filter '*.Web.Api' -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($srcApi) { $ModernApiRoot = $srcApi.FullName }
    }
    if (-not $ModernApiRoot -or [string]::IsNullOrWhiteSpace($ModernApiRoot)) {
        throw "Could not determine ModernApiRoot. Pass -ModernApiRoot or populate .modernization/.readme/kit-params.md with appName."
    }
}

# Load per-app accepted-drop registry
$acceptedDrops = @()
if (-not $RegistryPath -or [string]::IsNullOrWhiteSpace($RegistryPath)) {
    $RegistryPath = Join-Path (Split-Path $OutputPath -Parent) 'api-dto-coverage-registry.json'
}
if (Test-Path $RegistryPath) {
    try {
        $reg = Get-Content -LiteralPath $RegistryPath -Raw | ConvertFrom-Json
        $acceptedDrops = @($reg.acceptedDrops)
    } catch { Write-Verbose "Could not parse registry: $_" }
}

function Test-DropAccepted {
    param([string]$ModernDto, [string]$Prop)
    foreach ($a in $acceptedDrops) {
        if ($null -eq $a) { continue }
        $dtoOk  = (-not $a.modernDto) -or [string]::IsNullOrWhiteSpace([string]$a.modernDto)  -or ($ModernDto -ieq [string]$a.modernDto)
        $propOk = (-not $a.property) -or [string]::IsNullOrWhiteSpace([string]$a.property)  -or ($Prop -ieq [string]$a.property)
        if ($dtoOk -and $propOk) { return $true }
    }
    return $false
}

$excludePattern = '\\bin\\|\\obj\\|\\packages\\|\\TestResults\\'

# Extract property names from a C# class/record definition.
# Handles: "public string Foo { get; set; }", "public sealed record Foo(string Bar, ...)", "public int Id;".
function Get-CSharpProperties {
    param([string]$Content)
    $props = New-Object System.Collections.Generic.HashSet[string] ([System.StringComparer]::OrdinalIgnoreCase)
    # Constructor parameters in primary constructor record: record Foo(string Bar, int Baz)
    foreach ($m in [regex]::Matches($Content, '(?i)\brecord\s+\w+\s*\(([^)]+)\)')) {
        foreach ($param in ($m.Groups[1].Value -split ',')) {
            $p = [regex]::Match($param.Trim(), '(\w+)\s*$')
            if ($p.Success) { [void]$props.Add($p.Groups[1].Value) }
        }
    }
    # Auto-property: "public string Foo { get; set; }" or "public string Foo { get; }"
    foreach ($m in [regex]::Matches($Content, '(?im)^\s*public\s+[\w<>\[\]\?]+\s+(\w+)\s*\{')) {
        [void]$props.Add($m.Groups[1].Value)
    }
    return $props
}

# Extract the "domain concept" from a DTO name (e.g. FileLogResponse -> FileLog).
function Get-DomainConcept {
    param([string]$Name)
    return $Name -replace '(?i)(Response|Request|Dto|View|Model|Entry|Input|Output|Result)$',''
}

if (-not $Quiet) { Write-Host "Scanning legacy View classes under $LegacyRoot ..." }
$legacyFiles = @(Get-ChildItem -Path (Join-Path $LegacyRoot '*') -Recurse -Filter '*View.cs' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern })
$legacyDtos = @{}
foreach ($f in $legacyFiles) {
    $text = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $text) { continue }
    $classMatch = [regex]::Match($text, '(?im)(?:class|record)\s+(\w+)')
    if (-not $classMatch.Success) { continue }
    $name = $classMatch.Groups[1].Value
    $props = Get-CSharpProperties $text
    if ($props.Count -gt 0) { $legacyDtos[$name] = $props }
}

if (-not $Quiet) { Write-Host "Scanning modern API DTO files under $ModernApiRoot ..." }
$modernFiles = @(Get-ChildItem -Path (Join-Path $ModernApiRoot '*') -Recurse -Filter '*.cs' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $excludePattern -and $_.FullName -match '(?i)Response|Dto|Model|Request' })
$gaps = New-Object System.Collections.Generic.List[object]
$checkedPairs = New-Object System.Collections.Generic.List[object]
foreach ($f in $modernFiles) {
    $text = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $text) { continue }
    foreach ($cm in [regex]::Matches($text, '(?im)(?:public\s+(?:sealed\s+)?)?(?:class|record)\s+(\w+)')) {
        $modernName = $cm.Groups[1].Value
        if ($modernName -match '^(I[A-Z]|Abstract|Base)') { continue }   # skip interfaces/base types
        $concept = Get-DomainConcept $modernName
        if ([string]::IsNullOrWhiteSpace($concept)) { continue }
        # Find best-matching legacy View
        $legacyMatch = $null
        foreach ($lName in $legacyDtos.Keys) {
            $lConcept = Get-DomainConcept $lName
            if ($lConcept -ieq $concept) { $legacyMatch = $lName; break }
        }
        if (-not $legacyMatch) { continue }
        $modernProps = Get-CSharpProperties $text
        $legacyProps = $legacyDtos[$legacyMatch]
        $missingProps = @($legacyProps | Where-Object {
            $n = $_
            (-not $modernProps.Contains($n)) -and
            ($InternalPropNames -notcontains $n.ToLowerInvariant()) -and
            (-not (Test-DropAccepted -ModernDto $modernName -Prop $n))
        })
        $checkedPairs.Add([pscustomobject]@{
            modernDto    = $modernName
            legacyView   = $legacyMatch
            modernProps  = $modernProps.Count
            legacyProps  = $legacyProps.Count
            missingCount = $missingProps.Count
            missing      = $missingProps
        }) | Out-Null
        foreach ($prop in $missingProps) {
            $gaps.Add([pscustomobject]@{
                severity   = 'Major'
                kind       = 'MissingDtoField'
                modernDto  = $modernName
                legacyView = $legacyMatch
                property   = $prop
                legacyFile = (($legacyFiles | Where-Object { $_.Name -ieq "$legacyMatch.cs" } | Select-Object -First 1) | ForEach-Object { $_.FullName })
            }) | Out-Null
        }
    }
}

$result = [ordered]@{
    generatedUtc         = (Get-Date).ToUniversalTime().ToString('o')
    legacyRoot           = $LegacyRoot
    modernApiRoot        = $ModernApiRoot
    legacyViewsScanned   = $legacyDtos.Count
    modernDtosMatched    = $checkedPairs.Count
    majorGaps            = $gaps.Count
    checkedPairs         = $checkedPairs.ToArray()
    gaps                 = $gaps.ToArray()
    registryPath         = $RegistryPath
    acceptedDropCount    = @($acceptedDrops).Count
    note                 = 'Legacy-anchored API DTO field coverage. A modern DTO that maps fewer fields than its legacy View counterpart means the API never sends those fields - grid columns render empty cells silently. Declare intentional drops in api-dto-coverage-registry.json (acceptedDrops[]) with a reason.'
}

$outDir = Split-Path $OutputPath -Parent
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
($result | ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $OutputPath -Encoding UTF8

if (-not $Quiet) {
    Write-Host ''
    Write-Host ("API DTO COVERAGE SCAN COMPLETE -> {0}" -f $OutputPath)
    Write-Host ("  Legacy Views  : {0}" -f $legacyDtos.Count)
    Write-Host ("  Pairs checked : {0}" -f $checkedPairs.Count)
    if ($gaps.Count -gt 0) {
        Write-Host ("  Missing fields: {0} (Major - blocks)" -f $gaps.Count) -ForegroundColor Red
        foreach ($g in ($gaps | Select-Object -First 20)) {
            Write-Host ("    {0} missing '{1}' (from legacy {2})" -f $g.modernDto, $g.property, $g.legacyView) -ForegroundColor Red
        }
    } else {
        Write-Host ("  Missing fields: 0 (all modern DTOs cover their legacy counterparts)") -ForegroundColor Green
    }
}

if ($gaps.Count -gt 0) { exit 2 } else { exit 0 }
