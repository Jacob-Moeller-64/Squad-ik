# `.github/instructions/AppMod-Artifact-Contract.json` — PARTIAL transcription

**Status:** lines 1–291 read from 5 photos. File continues past 291 (step 19's
`producedOutputs` array is still open). Steps 20–24 not yet photographed.

## Transcription caveat — READ THIS BEFORE TRUSTING THE BODY

This file was photographed with **word wrap OFF**. It is JSON with very long
single lines, so on most `{ "path": ... }` entries the **right-hand portion runs
off the screen edge and is unrecoverable from these photos**. Every such line is
marked `[CUT]` below at the point the photo ends.

What is lost to the cut, per line, is typically the tail of `"consumedBySteps"`
and/or the tail of `"note"`. In a few cases the `"schema"` value is also partly
cut.

**Requested re-shoot:** open this file and press `Alt+Z` (Toggle Word Wrap) in
VS Code, then re-photograph from line 1. With wrap on, nothing is lost off the
right edge and this file can be promoted from `_wip/` to a real
`instructions/AppMod-Artifact-Contract.json`.

A second, subtler artifact of these photos: the screen was shot at an angle, so
the right-hand half of each row appears vertically offset by about one row.
Where a `"path"` and its `"note"` appeared on visually different rows, the
pairing below was reconstructed **semantically** (e.g. `decisions.json` pairs
with `fusion-decisions.schema.json`, `migration-plan.json` with
`fusion-migration-plan.schema.json`). Every such pairing was self-consistent, so
confidence is high, but it is a reconstruction, not a direct read.

## Body (lines 1–291)

```json
{
  "schemaVersion": "1.0",
  "purpose": "Per-step artifact input/output contract for the 24-step modernization workflow. Drives the shared verifier (.github/scripts/shared/verify-step-artifacts.ps1) and the per-step self-check wording in each[CUT]
  "appNamePlaceholder": "<AppName>",
  "appNameSource": ".modernization/.readme/kit-params.md",
  "producerLegend": {
    "dev-agent": "Authored directly by the step's owning agent. Always produced on a normal run, including No QA runs.",
    "dev-script": "Produced by the step's own helper script under .github/scripts/. Runs as part of the step, independent of QA.",
    "qa-script": "Historically produced by .github/scripts/QA/qa-refresh-portal.ps1. Only runs when QA runs.",
    "tool": "Produced by a parity/test runner (parity-score.mjs, run-visual-parity.mjs, dotnet/npm test). Any control-plane file here MUST also have a dev-agent or dev-script owner so No QA runs are not blocked."
  },
  "gateLegend": {
    "hardStop": "Required upstream input. If missing/empty, the step must self-heal via the selfHeal command or report Blocked.",
    "advisory": "Read when present. If missing, the step self-heals deterministically and continues without QA.",
    "conditional": "Required only when the matching condition holds (for example a browser surface exists, or MVC/Angular source is detected)."
  },
  "verifyNote": "Entries with verify=false are source-tree or glob outputs that the verifier does not presence-check. The verifier only asserts presence and non-emptiness of concrete JSON and Markdown artifacts.",
  "schemaNote": "An entry may declare an optional 'schema' pointing to a lightweight opx-field-contract/v1 file under .github/contracts/schemas/. When present and the artifact exists, the shared verifier validates re[CUT]
  "restorePointPolicy": {
    "invariant": "A",
    "purpose": "Isolation and reversibility for mutating steps. Before a step that changes src/ or LegacyCode/ runs, a workspace baseline must exist so the repository can be restored to the last known-good state if t[CUT]
    "manifest": ".modernization/OpXUtil/Backup/WorkspaceBaseline/workspace-baseline.manifest.json",
    "ensureCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step <N> -Mode Ensure",
    "verifyCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step <N> -Mode Verify",
    "recoverCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step <N> -Mode Recover",
    "backupCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/backup-src-and-legacy-baseline.ps1 -Target All",
    "restoreCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/restore-src-and-legacy-baseline.ps1 -Target All",
    "note": "Steps that set restorePoint.required true must have a baseline before they mutate. Mode Ensure creates the baseline if absent and is non-destructive. Mode Verify blocks with exit code 2 when no baseline[CUT]
  },
  "steps": [
    {
      "step": 1,
      "readableName": "Workstation Readiness",
      "requiredInputs": [],
      "producedOutputs": []
    },
    {
      "step": 2,
      "readableName": "Rename Starter To <AppName>",
      "requiredInputs": [
        { "path": ".modernization/.readme/kit-params.md", "gate": "hardStop", "selfHeal": null, "note": "Source of appName for all rename targets." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/rename-verification.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [], "note": "Deterministic rename verification record. Authored by the step[CUT]
        { "path": ".modernization/portal/data/json/step-workflow-state.json", "producer": "dev-script", "noQaSafe": true, "schema": ".github/contracts/schemas/step-workflow-state.schema.json", "consumedBySteps": [3,4[CUT]
      ]
    },
    {
      "step": 3,
      "readableName": "Legacy System Analysis",
      "requiredInputs": [
        { "path": ".modernization/.readme/kit-params.md", "gate": "hardStop", "selfHeal": null, "note": "Resolves the live QA/DEV URL and appName." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/discovery/service-behavior-inventory.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [5,11,12], "note": "Legacy service and behavior inventor[CUT]
        { "path": ".modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [5,10,12], "note": "UI control to handler wiring inver[CUT]
        { "path": ".modernization/ignition-artifacts/discovery/workflow-trace-inventory.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [5,10,12], "note": "End-to-end workflow traces." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [5,14], "note": "apiEndpointCatalog, uiControlClassifi[CUT]
        { "path": ".modernization/portal/data/json/legacy-system-analysis-report.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [10,12], "note": "screenshotCoverageMatrix baseline. Seeded by ge[CUT]
      ],
      "selfHealCommand": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/P1-Discovery/generate-manifest.ps1 -RepoPath ./LegacyCode -LegacySystemAnalysis"
    },
    {
      "step": 4,
      "readableName": "Baseline Acceptance-Criteria Review",
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/discovery/review-manifest.json", "gate": "hardStop", "selfHeal": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/P1-Discovery/generate-manifes[CUT]
        { "path": ".modernization/portal/data/json/rename-verification.json", "gate": "advisory", "selfHeal": "Re-run Step 2 when rename proof is missing or stale.", "note": "Step 2-owned rename proof context. Advisc[CUT]
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/discovery/baseline-review.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [5,22], "note": "Baseline acceptance findings." },
        { "path": ".modernization/portal/data/json/BASELINE-COMPLIANCE-REPORT.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [22], "note": "Baseline compliance snapshot." }
      ]
    },
    {
      "step": 5,
      "readableName": "Modernization Solution Design",
      "requiredInputs": [
        { "path": ".github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md", "gate": "hardStop", "selfHeal": null, "note": "Acceptance standard." },
        { "path": ".modernization/ignition-artifacts/discovery/service-behavior-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 3.", "note": "Step 3 legacy-analysis pack." },
        { "path": ".modernization/ignition-artifacts/discovery/baseline-review.json", "gate": "hardStop", "selfHeal": "Re-run Step 4.", "note": "Step 4 baseline evidence." },
        { "path": ".modernization/ignition-artifacts/discovery/review-manifest.json", "gate": "hardStop", "selfHeal": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/P1-Discovery/generate-manifes[CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 3.", "note": "Fusion-first planning inputs." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/Modernization-Solution-Design.md", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [6,8], "note": "Primary human-readable development plan." },
        { "path": ".modernization/ignition-artifacts/Modernization-Execution-Contract.md", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [6,7,8], "note": "Authoritative workspace roots and execution r[CUT]
        { "path": ".modernization/ignition-artifacts/Modernization-Phase-Assessment.md", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [6,7,8], "note": "Step 8 Skip/ValidateOnly/Execute disposition. S[CUT]
        { "path": ".modernization/ignition-artifacts/addendums/Architecture-Structure.md", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [6,7,8], "note": "Chosen backend target structure." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/fusion-decisions.schema.json", "consu[CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/fusion-migration-plan.schema.jsc[CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/fusion-control-point-in[CUT]
        { "path": ".modernization/portal/data/json/modernization-execution-contract.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/modernization-execution-contract.schema.json"[CUT]
        { "path": ".modernization/portal/data/json/modernization-phase-assessment.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/modernization-phase-assessment.schema.json", "c[CUT]
        { "path": ".modernization/portal/data/json/modernization-solution-design.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/modernization-solution-design.schema.json", "cor[CUT]
      ]
    },
    {
      "step": 6,
      "readableName": "Modernization Quality Design",
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/Modernization-Solution-Design.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Step 5 planning outputs." },
        { "path": ".modernization/ignition-artifacts/Modernization-Phase-Assessment.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Step 5 disposition." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/qa-test-plan.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [8,11,12,13,14,17], "note": "Authoritative test planning and execution-status surfa[CUT]
        { "path": ".modernization/portal/data/json/executable-testcase-catalog.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/executable-testcase-catalog.schema.json", "consume[CUT]
        { "path": ".modernization/ignition-artifacts/characterization-test-planning.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [11,12,17], "note": "Characterization plan." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [8,9,17], "note": "Layering gate forbidden [CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [8,9,17], "note": "Layering gate closed-slice status[CUT]
        { "path": ".modernization/portal/data/json/per-route-behavior-plan.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/per-route-behavior-plan.schema.json", "consumedBySteps[CUT]
        { "path": ".modernization/portal/data/json/test-accumulation-tracker.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [12,17], "note": "Accumulating test coverage tracker." },
        { "path": ".modernization/ignition-artifacts/discovery/testing-ownership-matrix.generated.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [17], "note": "Per-step test ownership matrix." }
      ]
    },
    {
      "step": 7,
      "readableName": "Backend - Upgrade .NET",
      "requiredInputs": [
        { "path": ".modernization/portal/data/json/modernization-execution-contract.json", "gate": "advisory", "selfHeal": "powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artif[CUT]
        { "path": ".modernization/ignition-artifacts/Modernization-Phase-Assessment.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Phase disposition." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/step-workflow-state.json", "producer": "dev-agent", "noQaSafe": true, "schema": ".github/contracts/schemas/step-workflow-state.schema.json", "consumedBySteps": [8], [CUT]
        { "path": ".modernization/portal/data/json/step-response-ledger.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [8,24], "note": "Numbered-flow response ledger." }
      ]
    },
    {
      "step": 8,
      "readableName": "Backend - Modernization Formation",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/Modernization-Solution-Design.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Backend formation scope." },
        { "path": ".modernization/ignition-artifacts/Modernization-Phase-Assessment.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Skip/ValidateOnly/Execute disposition. Step 8 fails fast without it.[CUT]
        { "path": ".modernization/ignition-artifacts/Modernization-Execution-Contract.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Authoritative workspace roots." },
        { "path": ".github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md", "gate": "hardStop", "selfHeal": null, "note": "Acceptance standard." },
        { "path": ".modernization/ignition-artifacts/addendums/Architecture-Structure.md", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Chosen backend target structure." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Migration decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Migration plan." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json", "gate": "hardStop", "selfHeal": "Re-run Step 6.", "note": "Layering gate forbidden references baseline." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json", "gate": "hardStop", "selfHeal": "Re-run Step 6.", "note": "Layering gate closed-slice status baseline." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/Backend-Modernization-Formation-Report.md", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [24], "note": "Backend formation evidence." },
        { "path": ".modernization/portal/data/json/CURRENT-COMPLIANCE-REPORT.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [24], "note": "Mid-run compliance snapshot." },
        { "path": ".modernization/portal/data/json/test-accumulation-tracker.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [12,17], "note": "Step 8 unit-test growth and coverage tracker update.[CUT]
        { "path": "tests/backend/unit/<AppName>.Library.Tests/<AppName>.Library.Tests.csproj", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [9,17], "note": "Executable Step 8 backend unit test lane p[CUT]
        { "path": "src/<AppName>.Library", "producer": "dev-agent", "noQaSafe": true, "verify": false, "consumedBySteps": [9,17], "note": "Formed domain library." },
        { "path": "src/<AppName>.Web.Api", "producer": "dev-agent", "noQaSafe": true, "verify": false, "consumedBySteps": [9,12,17], "note": "Formed API project." }
      ]
    },
    {
      "step": 9,
      "readableName": "Backend - .NET Integration Hardening",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points for auth/config/logging seam[CUT]
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/backend-load-smoke.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [11], "note": "Backend startup/load smoke proc[CUT]
      ]
    },
    {
      "step": 10,
      "readableName": "Frontend Foundation & Scaffold",
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Browser-shell decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 3.", "note": "Every interactive control must map to an inventory entry.[CUT]
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [11,13,14], "note": "Design foundation." },
        { "path": ".modernization/portal/data/json/frontend-runtime-comparison.generated.json", "producer": "tool", "noQaSafe": true, "consumedBySteps": [13], "note": "Parity comparison metrics." }
      ]
    },
    {
      "step": 11,
      "readableName": "Frontend Migration",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Migration decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json", "gate": "hardStop", "selfHeal": "Re-run Step 10.", "note": "Styling foundation." },
        { "path": ".modernization/portal/data/json/per-route-behavior-plan.json", "gate": "hardStop", "selfHeal": "Re-run Step 6.", "note": "Per-route behavior checklist." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/dead-code-trace.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [18], "note": "Static reachability trace." }
      ]
    },
    {
      "step": 12,
      "readableName": "Frontend Platform Integration",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Browser auth decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/discovery/workflow-trace-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 3.", "note": "Workflow traces for wiring." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/discovery/ui-api-wiring-map.json", "producer": "dev-script", "noQaSafe": true, "consumedBySteps": [], "note": "UI to API wiring map (generate-ui-api-map.ps1)." },
        { "path": ".modernization/portal/data/json/test-accumulation-tracker.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [17], "note": "Refreshed test accumulation tracker." },
        { "path": ".modernization/ignition-artifacts/discovery/behavioral-parity-checkpoint.json", "producer": "e2e-spec", "noQaSafe": false, "consumedBySteps": [], "note": "Runtime behavioral-parity verdict from beh[CUT]
      ]
    },
    {
      "step": 13,
      "readableName": "Frontend Shell Stabilization",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json", "gate": "hardStop", "selfHeal": "Re-run Step 10.", "note": "Styling foundation." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/frontend-parity-status.generated.json", "producer": "tool", "noQaSafe": true, "consumedBySteps": [14], "note": "Frontend parity status." }
      ]
    },
    {
      "step": 14,
      "readableName": "Frontend UI Inventory & Fusion Map",
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json", "gate": "hardStop", "selfHeal": "Re-run Step 10.", "note": "Styling foundation." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-inventory.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [15,16], "note": "UI control census." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [15,21], "note": "Measurable visual contract.[CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [15,16,19,21,23], "note": "Control to Fusion primit[CUT]
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [15,16], "note": "Dependency-safe migration or[CUT]
      ]
    },
    {
      "step": 15,
      "readableName": "Fusion UI Integration",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json", "gate": "hardStop", "selfHeal": "Re-run Step 14.", "note": "Fusion map." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json", "gate": "hardStop", "selfHeal": "Re-run Step 14.", "note": "Visual contract." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json", "gate": "hardStop", "selfHeal": "Re-run Step 14.", "note": "Migration order." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/wrapper-versions.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [16], "note": "Fusion wrapper versions." }
      ]
    },
    {
      "step": 16,
      "readableName": "Next Fusion UI Upgrade Slice",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json", "gate": "hardStop", "selfHeal": "Re-run Step 14.", "note": "Migration order." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json", "gate": "hardStop", "selfHeal": "Re-run Step 14.", "note": "Fusion map." }
      ],
      "producedOutputs": []
    },
    {
      "step": 17,
      "readableName": "Rewire All Tests & Verify",
      "requiredInputs": [
        { "path": ".modernization/portal/data/json/executable-testcase-catalog.json", "gate": "hardStop", "selfHeal": "Re-run Step 6.", "note": "Executable catalog." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/step19-gate-results.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [23,24], "note": "Comprehensive quality-gate results. Filename retains the l[CUT]
        { "path": ".modernization/portal/data/json/pom-inventory.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [], "note": "Page Object Model inventory." }
      ]
    },
    {
      "step": 18,
      "readableName": "Deployment & Clean Up",
      "restorePoint": { "required": true, "invariant": "A" },
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Migration plan." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." }
      ],
      "producedOutputs": [
        { "path": ".modernization/portal/data/json/step20-rollback-dryrun.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [19,20], "note": "Rollback dry-run record. Filename retains the legacy st[CUT]
        { "path": ".modernization/portal/data/json/step20-perf-verification.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [19,20], "note": "Performance verification record." }
      ]
    },
    {
      "step": 19,
      "readableName": "Final Fusion Restructure Review",
      "requiredInputs": [
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Decisions." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Control points." },
        { "path": ".modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json", "gate": "hardStop", "selfHeal": "Re-run Step 5.", "note": "Migration plan." }
      ],
      "producedOutputs": [
        { "path": ".modernization/ignition-artifacts/reviews/final-fusion-restructure-review.json", "producer": "dev-agent", "noQaSafe": true, "consumedBySteps": [20], "note": "Final restructure review proof." }
```

## Line-number anchors verified against the photos

| Source line | Content |
|---|---|
| 30 | `"steps": [` |
| 32 | `"step": 1,` |
| 38 | `"step": 2,` |
| 49 | `"step": 3,` |
| 64 | `"step": 4,` |
| 76 | `"step": 5,` |
| 99 | `"step": 6,` |
| 117 | `"step": 7,` |
| 129 | `"step": 8,` |
| 154 | `"step": 9,` |
| 165 | `"step": 10,` |
| 178 | `"step": 11,` |
| 192 | `"step": 12,` |
| 207 | `"step": 13,` |
| 220 | `"step": 14,` |
| 235 | `"step": 15,` |
| 248 | `"step": 16,` |
| 258 | `"step": 17,` |
| 269 | `"step": 18,` |
| 282 | `"step": 19,` |
| 291 | last line read (final `producedOutputs` entry of step 19) |

## Uncertain / reconstructed reads

1. **Line 108 path.** Read as
   `.modernization/ignition-artifacts/characterization-test-planning.json`. The
   photo shows `.modernization/portal/data/json/characterization-test-planning.json`
   on the visually-adjacent row; because of the keystone shift this could belong
   to either root. Flagged for confirmation on re-shoot — it matters, because it
   decides whether the characterization plan is a portal artifact or an
   ignition-artifact.
2. **`consumedBySteps` tails.** Any array shown ending at the cut (e.g. line 45's
   `[3,4[CUT]`) is truncated, not complete.
3. **Step 2 line 44 `consumedBySteps": []`.** Read as empty. Adjacent greyed
   text in the photo suggested a trailing comment about "(not QA) so a N…" which
   is part of the cut `note`, not a separate field.
