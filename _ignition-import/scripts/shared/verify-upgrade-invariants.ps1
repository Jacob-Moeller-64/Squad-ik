<#
.SYNOPSIS
    Proves the single-version package invariant for a .NET upgrade workspace, and (optionally)
    cross-checks the shipped run/publish folder against the compiled package versions.

.DESCRIPTION
    A clean build does NOT prove dependency consistency. NuGet compiles each project against its
    own referenced version, so a package that is referenced at two different versions across the
    closure still builds green - but only the single highest version ships to the run folder. The
    project that compiled against the other version then calls members that no longer exist and
    faults at runtime (a diamond / split-version break), which the app's own error handling can
    disguise as an ordinary error status. The build never reveals it.

    This script catches that class of failure deterministically:

    -WorkspaceRoot (required): scans every .csproj under the workspace, resolves the effective
      version of each PackageReference (including central Directory.Packages.props management), and
      proves that no package is referenced at more than one version across the PRODUCT closure.
      Test projects are classified separately: the Step 7 test carry-forward policy keeps test-only
      packages on their existing versions, so test-only version differences are reported as
      informational and never block.

    -PublishDir (optional): after the backend is running and its assemblies are in the run/publish
      folder, compares the single resolved product version of each package against the MAJOR version
      of the same-named shipped assembly. A shipped-vs-compiled major mismatch is a runtime defect
      even when an HTTP probe returned 2xx.

.PARAMETER WorkspaceRoot
    The upgrade workspace root (for example .modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade). Required.

.PARAMETER PublishDir
    Optional run/publish output folder to cross-check shipped assemblies against compiled versions.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.OUTPUTS
    Prints "RESULT: OK" and exits 0 when the product closure is single-version (and, when
    -PublishDir is supplied, no shipped-vs-compiled major mismatch is found).
    Prints "RESULT: BLOCKED" and exits 2 when a product package is split across versions or a
    shipped assembly major does not match the compiled package major.
    Exits 2 with a clear message when the workspace cannot be resolved.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-upgrade-invariants.ps1 -WorkspaceRoot .modernization/OpXUtil/Backup/LegacyCode_NET10_Upgrade

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-upgrade-invariants.ps1 -WorkspaceRoot .modernization/OpXUtil/Backup/LegacyCode_NET10_Upgrade -PublishDir .modernization/OpXUtil/Backup/LegacyCode_NET10_Upgrade/_run5100
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$WorkspaceRoot,

  [string]$PublishDir,

  [string]$RepoRoot,

  [switch]$AsJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-RepoRoot {
  param([string]$Override)
  if (-not [string]::IsNullOrWhiteSpace($Override)) {
    return (Resolve-Path -LiteralPath $Override).Path
  }
  # This script lives at .github/scripts/shared/ ; repo root is three levels up.
  $candidate = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath '..' | Join-Path -ChildPath '..'
  return (Resolve-Path -LiteralPath $candidate).Path
}

function Resolve-WorkspacePath {
  # Accept an absolute path, a path relative to the current directory, or a path
  # relative to the repo root, and return the first one that exists on disk.
  param([string]$Value, [string]$RepoRoot)
  if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
  $candidates = @(
    $Value,
    (Join-Path -Path (Get-Location).Path -ChildPath $Value),
    (Join-Path -Path $RepoRoot -ChildPath $Value)
  )
  foreach ($candidate in $candidates) {
    if (Test-Path -LiteralPath $candidate) {
      return (Resolve-Path -LiteralPath $candidate).Path
    }
  }
  return $null
}

function Test-IsTestProject {
  # A project is treated as a test project when its file is named like a test project
  # or it references the test SDK. Test projects are exempt from the product invariant
  # because Step 7 carries them forward at their existing versions.
  param([string]$ProjectPath, [string]$RawContent)
  if ([System.IO.Path]::GetFileName($ProjectPath) -match '(?i)\.Tests?\.csproj$') { return $true }
  if ($RawContent -match '(?i)Microsoft\.NET\.Test\.Sdk') { return $true }
  if ($RawContent -match '(?i)<IsTestProject>\s*true\s*</IsTestProject>') { return $true }
  return $false
}

function Get-CentralPackageVersion {
  # Reads every Directory.Packages.props so PackageReference entries that omit a Version
  # (central package management) can still be resolved to their effective version.
  param([string]$WorkspaceRoot)
  $central = @{}
  $propsFiles = @(Get-ChildItem -LiteralPath $WorkspaceRoot -Recurse -File -Filter 'Directory.Packages.props' -ErrorAction SilentlyContinue)
  foreach ($props in $propsFiles) {
    try { $xml = [xml](Get-Content -LiteralPath $props.FullName -Raw) } catch { continue }
    foreach ($node in $xml.SelectNodes('//PackageVersion')) {
      $id = $node.GetAttribute('Include')
      $ver = $node.GetAttribute('Version')
      if ([string]::IsNullOrWhiteSpace($id) -or [string]::IsNullOrWhiteSpace($ver)) { continue }
      $central[$id] = $ver.Trim()
    }
  }
  return $central
}

function Get-PackageReferenceVersion {
  # The version may be a Version attribute or a child <Version> element; fall back to the
  # central package version when neither is present.
  param($Node, [hashtable]$Central, [string]$PackageId)
  $ver = $Node.GetAttribute('Version')
  if ([string]::IsNullOrWhiteSpace($ver)) {
    $child = $Node.SelectSingleNode('Version')
    if ($null -ne $child) { $ver = $child.InnerText }
  }
  if ([string]::IsNullOrWhiteSpace($ver) -and $Central.ContainsKey($PackageId)) {
    $ver = $Central[$PackageId]
  }
  if ([string]::IsNullOrWhiteSpace($ver)) { return $null }
  return $ver.Trim()
}

function Get-MajorVersion {
  param([string]$Version)
  if ([string]::IsNullOrWhiteSpace($Version)) { return $null }
  $head = ($Version -split '[.\-+]')[0]
  $parsed = 0
  if ([int]::TryParse($head, [ref]$parsed)) { return $parsed }
  return $null
}

# --- Resolve roots ---------------------------------------------------------
$repoRootResolved = Resolve-RepoRoot -Override $RepoRoot
$workspaceResolved = Resolve-WorkspacePath -Value $WorkspaceRoot -RepoRoot $repoRootResolved

if ($null -eq $workspaceResolved) {
  if ($AsJson) {
    [pscustomobject]@{ result = 'BLOCKED'; reason = "WorkspaceRoot not found: $WorkspaceRoot" } | ConvertTo-Json -Compress
  }
  else {
    Write-Host "Single-version invariant"
    Write-Host "  WorkspaceRoot not found: $WorkspaceRoot"
    Write-Host "RESULT: BLOCKED"
  }
  exit 2
}

# --- Scan project files ----------------------------------------------------
$projectFiles = @(Get-ChildItem -LiteralPath $workspaceResolved -Recurse -File -Filter '*.csproj' -ErrorAction SilentlyContinue)
$central = Get-CentralPackageVersion -WorkspaceRoot $workspaceResolved

# productMatrix: package -> (version -> [project names]) for product projects only.
# testMatrix:    package -> [versions] for test projects only (informational).
$productMatrix = @{}
$testMatrix = @{}
$productCount = 0
$testCount = 0

foreach ($proj in $projectFiles) {
  $raw = Get-Content -LiteralPath $proj.FullName -Raw
  try { $xml = [xml]$raw } catch { continue }
  $isTest = Test-IsTestProject -ProjectPath $proj.FullName -RawContent $raw
  if ($isTest) { $testCount++ } else { $productCount++ }

  foreach ($node in $xml.SelectNodes('//PackageReference')) {
    $id = $node.GetAttribute('Include')
    if ([string]::IsNullOrWhiteSpace($id)) { $id = $node.GetAttribute('Update') }
    if ([string]::IsNullOrWhiteSpace($id)) { continue }
    $ver = Get-PackageReferenceVersion -Node $node -Central $central -PackageId $id
    if ([string]::IsNullOrWhiteSpace($ver)) { continue }

    if ($isTest) {
      if (-not $testMatrix.ContainsKey($id)) { $testMatrix[$id] = @{} }
      $testMatrix[$id][$ver] = $true
    }
    else {
      if (-not $productMatrix.ContainsKey($id)) { $productMatrix[$id] = @{} }
      if (-not $productMatrix[$id].ContainsKey($ver)) { $productMatrix[$id][$ver] = New-Object System.Collections.Generic.List[string] }
      [void]$productMatrix[$id][$ver].Add($proj.BaseName)
    }
  }
}

# --- Evaluate the product single-version invariant -------------------------
$productSplits = New-Object System.Collections.Generic.List[object]
$resolvedProductVersion = @{}
foreach ($pkg in ($productMatrix.Keys | Sort-Object)) {
  $versions = @($productMatrix[$pkg].Keys)
  if ($versions.Count -gt 1) {
    $detail = New-Object System.Collections.Generic.List[string]
    foreach ($v in ($versions | Sort-Object)) {
      $detail.Add(("{0} ({1})" -f $v, (($productMatrix[$pkg][$v]) -join ', ')))
    }
    $productSplits.Add([pscustomobject]@{ Package = $pkg; Detail = ($detail -join '; ') })
  }
  else {
    $resolvedProductVersion[$pkg] = $versions[0]
  }
}

# --- Test-only differences (informational, non-blocking) -------------------
$testOnlyDifferences = New-Object System.Collections.Generic.List[object]
foreach ($pkg in ($testMatrix.Keys | Sort-Object)) {
  $versions = @($testMatrix[$pkg].Keys)
  if ($versions.Count -gt 1) {
    $testOnlyDifferences.Add([pscustomobject]@{ Package = $pkg; Versions = (($versions | Sort-Object) -join ', ') })
  }
}

# --- Optional shipped-vs-compiled cross-check (-PublishDir) ----------------
$shippedMismatches = New-Object System.Collections.Generic.List[object]
$publishResolved = $null
if (-not [string]::IsNullOrWhiteSpace($PublishDir)) {
  $publishResolved = Resolve-WorkspacePath -Value $PublishDir -RepoRoot $repoRootResolved
  if ($null -ne $publishResolved) {
    foreach ($pkg in ($resolvedProductVersion.Keys | Sort-Object)) {
      $dllPath = Join-Path $publishResolved ("{0}.dll" -f $pkg)
      if (-not (Test-Path -LiteralPath $dllPath)) { continue }
      $referencedMajor = Get-MajorVersion -Version $resolvedProductVersion[$pkg]
      $shippedFileVersion = (Get-Item -LiteralPath $dllPath).VersionInfo.FileVersion
      $shippedMajor = Get-MajorVersion -Version $shippedFileVersion
      if ($null -ne $referencedMajor -and $null -ne $shippedMajor -and $referencedMajor -ne $shippedMajor) {
        $shippedMismatches.Add([pscustomobject]@{
            Package           = $pkg
            ReferencedVersion = $resolvedProductVersion[$pkg]
            ShippedVersion    = $shippedFileVersion
          })
      }
    }
  }
}

# --- Decide result ---------------------------------------------------------
$blocked = ($productSplits.Count -gt 0) -or ($shippedMismatches.Count -gt 0)
$result = if ($blocked) { 'BLOCKED' } else { 'OK' }

if ($AsJson) {
  [pscustomobject]@{
    result              = $result
    workspaceRoot       = $workspaceResolved
    publishDir          = $publishResolved
    productProjectCount = $productCount
    testProjectCount    = $testCount
    productSplits       = @($productSplits)
    testOnlyDifferences = @($testOnlyDifferences)
    shippedMismatches   = @($shippedMismatches)
  } | ConvertTo-Json -Depth 6
  if ($blocked) { exit 2 } else { exit 0 }
}

Write-Host "Single-version invariant"
Write-Host ("  Workspace: {0}" -f $workspaceResolved)
Write-Host ("  Scanned {0} project(s): {1} product, {2} test." -f $projectFiles.Count, $productCount, $testCount)

if ($productSplits.Count -gt 0) {
  Write-Host "  [SPLIT] One or more product packages are referenced at more than one version:"
  foreach ($split in $productSplits) {
    Write-Host ("    {0}: {1}" -f $split.Package, $split.Detail)
  }
}
else {
  Write-Host "  [OK] No product package is split across versions."
}

if ($testOnlyDifferences.Count -gt 0) {
  Write-Host "  Test-only version differences (non-blocking; carried forward per Step 7 policy):"
  foreach ($diff in $testOnlyDifferences) {
    Write-Host ("    {0}: {1}" -f $diff.Package, $diff.Versions)
  }
}

if (-not [string]::IsNullOrWhiteSpace($PublishDir)) {
  if ($null -eq $publishResolved) {
    Write-Host ("  [PublishDir] Not found, shipped-vs-compiled cross-check skipped: {0}" -f $PublishDir)
  }
  elseif ($shippedMismatches.Count -gt 0) {
    Write-Host "  [SHIPPED MISMATCH] A shipped assembly major does not match the compiled package major:"
    foreach ($mismatch in $shippedMismatches) {
      Write-Host ("    {0}: referenced {1}, shipped {2}" -f $mismatch.Package, $mismatch.ReferencedVersion, $mismatch.ShippedVersion)
    }
  }
  else {
    Write-Host "  [OK] Shipped assemblies match the compiled package majors."
  }
}

Write-Host ("RESULT: {0}" -f $result)
if ($blocked) { exit 2 } else { exit 0 }
