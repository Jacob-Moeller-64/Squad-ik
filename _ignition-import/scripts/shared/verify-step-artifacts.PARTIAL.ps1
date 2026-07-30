<#
.SYNOPSIS
    Verifies that a numbered modernization step has the upstream artifacts it needs (inputs)
    and has produced the artifacts that later steps consume (outputs), independent of QA.

.DESCRIPTION
    Reads the per-step artifact contract at .github/instructions/AppMod-Artifact-Contract.json,
    resolves the current application name from .modernization/.readme/kit-params.md (or the
    -AppName override), and checks presence and non-emptiness of each declared artifact for the
    requested step.

    This is the deterministic, QA-independent self-check surface for the workflow. Every numbered
    prompt can call it at entry (-Mode Input) to confirm it ingested what it needs, and at closeout
    (-Mode Output) to confirm it produced what later prompts consume. Running with QA disabled never
    changes the result, because the contract only depends on DEV-authored and DEV-script artifacts.

.PARAMETER Step
    The numbered step (1-24) to verify. Provide either -Step or -StepId, not both.

.PARAMETER StepId
    6-char lowercase hex ID from .github/instructions/step-registry.json (e.g. '26b4e1').
    Resolved to the numeric step number at runtime. Provide either -StepId or -Step, not both.

.PARAMETER Mode
    Input  - verify required upstream inputs only.
    Output - verify produced outputs only.
    Both   - verify inputs then outputs (default).

.PARAMETER AppName
    Optional application name. When omitted, it is read from kit-params.md.

.PARAMETER EnsureControlPlane
    When set, deterministically materializes a generic, app-agnostic skeleton for any missing
    control-plane JSON (modernization-execution-contract.json, modernization-phase-assessment.json,
    modernization-solution-design.json) so a No QA run is never blocked by a missing control file.
    The skeleton is a placeholder the owning step enriches; it never fabricates application routes.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.OUTPUTS
    Exit code 0 when all checked artifacts are present and non-empty.
    Exit code 2 when a required input or a declared output is missing or empty.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 8 -Mode Input

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 5 -Mode Output

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -StepId '26b4e1' -Mode Input
#>
[CmdletBinding()]
param(
  # Numeric step (1-24). Provide either -Step or -StepId, not both.
  [int]$Step = 0,

  # 6-char hex token from step-registry.json. Resolved to a numeric step at runtime.
  [string]$StepId = '',

  [ValidateSet('Input', 'Output', 'Both')]
  [string]$Mode = 'Both',

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-66 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
