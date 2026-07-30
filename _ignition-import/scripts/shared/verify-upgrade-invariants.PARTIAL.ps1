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

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-66 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
