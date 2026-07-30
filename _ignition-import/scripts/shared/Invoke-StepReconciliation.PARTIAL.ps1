<#
.SYNOPSIS
    Cross-artifact reconciliation for the modernization workflow. Catches "plausible but
    wrong" content that passes shape (schema) checks - for example a well-formed testcase
    catalog that names a test file which does not exist on disk.

.DESCRIPTION
    Field contracts (.github/contracts/schemas/ via verify-step-artifacts.ps1) prove an
    artifact is well FORMED. Reconciliation proves it is TRUE against the rest of the
    workspace. This is the second half of the artifact-reliability story: it is the only
    layer that catches a hallucinated-but-believable entry, because such an entry is valid
    JSON and passes every schema check.

    Rules are registered per numbered step. The engine loads the rules for the requested
    step, runs them, and prints DEVELOPER-GUIDING remediation for every violation - so when
    a step cannot self-heal, the developer is still told exactly how to finish the step by
    hand and proceed. A step with no registered rules reconciles to OK (nothing to check).

    This self-check is QA-independent and safe on `No QA` runs: it reads only DEV-authored
    artifacts and the source tree.

.PARAMETER Step
    The numbered step (1-24) whose reconciliation rules should run. Provide either -Step or -StepId, not both.

.PARAMETER StepId
    6-char lowercase hex ID from .github/instructions/step-registry.json (e.g. '26b4e1').
    Resolved to the numeric step number at runtime. Provide either -StepId or -Step, not both.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.OUTPUTS
    Exit code 0 when every registered rule passes (or the step has no rules).
    Exit code 2 when any rule raises a blocking violation.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -Step 17

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -StepId '0576c8'

.NOTES
    Add a rule:
      1. Write a function Invoke-Recon-<Name> that takes -RepoRoot and -Violations (a
         System.Collections.Generic.List[object]) and calls Add-Violation for each problem.
      2. Register it in $RuleRegistry under the step(s) it applies to.
    Each violation should carry actionable remediation text, not just a description.
#>
[CmdletBinding()]
param(
  # Numeric step (1-24). Provide either -Step or -StepId, not both.
  [int]$Step = 0,

  # 6-char hex token from step-registry.json. Resolved to a numeric step at runtime.
  [string]$StepId = '',

  [string]$RepoRoot,

  [string]$StepSummaryPath,

  [switch]$AsJson
)

Set-StrictMode -Version Latest

# ---------------------------------------------------------------------------
# TRANSCRIPTION NOTE -- NOT PART OF THE SOURCE FILE.
# This import covers source lines 1-67 only; 1 of the 5 photos in the batch was
# read. Deliberately incomplete; must not be executed.
# ---------------------------------------------------------------------------
