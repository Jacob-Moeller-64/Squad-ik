<#
.SYNOPSIS
    Detects step-number drift left over from the 26-step -> 24-step renumbering across the
    reusable toolkit (prompts, agents, instructions, scripts), and validates that every
    prompt slash-command / referenced prompt file actually resolves on disk.

.DESCRIPTION
    The kit was originally a 26-step flow and was later compressed to 24 steps. The H1 headers
    and file names were corrected, but many in-body self-references, cross-references, agent
    button labels, script output strings, and instruction notes still carry the OLD numbers.
    Hand-sweeping that drift is error-prone (long files hide stragglers), so this script does
    the enumeration deterministically and flags the violations it can prove.

    It runs THREE deterministic checks plus one completeness enumeration:

      Check A - Self-reference consistency (numbered prompt files only)
        A numbered prompt `NN-...prompt.md` must refer to ITSELF as Step NN. The H1
        `# Step M ...` and the frontmatter `description:` "Step M" must have M == NN.

      Check B - Reference resolution (all scanned files)
        Every prompt slash-command (`/NN-slug`) and every "run `NN-slug`" prompt reference
        must resolve to a real file under .github/prompts/. This deterministically catches
        broken or dangling invocations (the highest-severity drift, because a developer who
        clicks one gets nothing).

      Check C - Title-anchored step number (all scanned files)
        When text says `Step N <Title>` and <Title> matches a canonical step's readableName,
        the cited N must equal that step's number. This is the workhorse that catches drift in
        agent labels, script output, and instruction notes - anywhere a title travels with a
        number - without needing to understand the surrounding prose.

      Enumeration - Every `Step \d+` reference (review backstop)
        Lists each reference with a classification tag so a maintainer can review the residue
        that carries no title (bare "Step 14 or later") which no automated rule can safely judge.

    Canonical step titles are read at runtime from AppMod-Artifact-Contract.json, so this script
    stays data-driven and never hard-codes the step list.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.PARAMETER IncludeEnumeration
    Include the full per-reference enumeration in the output. Off by default to keep the
    routine gate output focused on violations.

.OUTPUTS
    Exit code 0 when no deterministic violations (A/B/C) are found.
    Exit code 2 when at least one deterministic violation is found.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/maintenance/audit-step-number-drift.ps1

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/maintenance/audit-step-number-drift.ps1 -IncludeEnumeration -AsJson
#>
[CmdletBinding()]
param(
  [string]$RepoRoot,
  [switch]$AsJson,
  [switch]$IncludeEnumeration
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-67 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
