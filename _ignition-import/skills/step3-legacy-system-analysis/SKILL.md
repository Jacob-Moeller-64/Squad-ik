# Step 3 — Legacy System Analysis

**Skill ID:** `step3-legacy-system-analysis`

**Purpose:** Execute discovery-phase legacy system analysis to produce decision-grade evidence about the legacy app's structure, behavior, and dependencies. This skill owns the schema contract for all Step 3 artifacts and gate enforcement.

## Entry Points

- **Prompt:** [03-P1-legacy-system-analysis.prompt.md](../../prompts/03-P1-legacy-system-analysis.prompt.md)
- **Agent:** OpX-AppMod-P1-Discovery
- **Gate Script:** `.github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1`

## Core Deliverables

Step 3 produces seven required artifacts across three target scopes:

1. **Service & Behavior Inventory** — public methods of controllers, services, repositories, validators, and orchestrators
2. **Interaction Wiring Inventory** — interactive controls on captured browser surfaces
3. **Workflow Trace Inventory** — high-risk control flows (api-call, export, state-mutation, etc.)
4. **API Endpoint Catalog** — controller actions in LegacyCode/
5. **UI Control Classification** — browser-interactive controls mapped to Fusion primitive compatibility
6. **Screenshot Coverage Matrix** — portal capture state for all route/screen combinations
7. **Fusion Primitive Coverage Census** — legacy control families mapped to Fusion package equivalents

## Key Contracts

### Modality Detection
Step 3 **must** detect app shape before artifact enforcement:
- `api-only` -> backend inventories required; browser surfaces not applicable
- `mvc` -> server-rendered browser-led evidence set
- `spa` -> browser-led SPA evidence set
- `hybrid` -> both browser and API families required

Detection is deterministic based on source markers (`.cshtml`, `angular.json`, `package.json`, API-only controllers, etc.).

### legacyEvidence Requirement
Every artifact entry **must** include a `legacyEvidence` object with a resolvable `filePath` pointing to `LegacyCode/` or `src/`. The gate validates this and rejects entries pointing to generated paths (`bin/`, `obj/`, `node_modules/`, `dist/`).

### Schema Source of Truth
All artifact field definitions live in:
- [Step3-Artifact-Schema-Contract.md](references/Step3-Artifact-Schema-Contract.md)

This skill owns the contract; do not re-expand schema inline in prompts.

## Gate Enforcement

The gate script (`.github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1`) validates:
1. All required artifacts exist for the detected modality
2. No generated-artifact pollution in `legacyEvidence` entries
3. All entries include resolvable file paths or explicit `cannot-locate` status
4. Three mandatory gate statuses recorded: `scanCoverageStatus`, `traceabilityStatus`, `planningReadinessStatus`

A `Blocked` status prevents progression to Step 4.

## Applicability Matrix

Browser-only artifacts (Artifacts 2, 3, 5, 6, 7) are not required for `api-only` apps:

| Artifact | browser-led | api-only | spa | hybrid |
|---|---|---|---|---|
| 1 service-behavior-inventory | ✓ | ✓ | ✓ | ✓ |
| 2 interaction-wiring-inventory | ✓ | X | ✓ | ✓ |
| 3 workflow-trace-inventory | ✓ | X | ✓ | ✓ |
| 4 apiEndpointCatalog | ✓ | ✓ | ✓ | ✓ |
| 5 uiControlClassification | ✓ | X | ✓ | ✓ |
| 6 screenshotCoverageMatrix | ✓ | X | ✓ | ✓ |
| 7 fusionPrimitiveCoverageCensus | ✓ | X | ✓ | ✓ |

## Related Materials

- **Reference:** [Step3-Artifact-Schema-Contract.md](references/Step3-Artifact-Schema-Contract.md) — full field definitions for all 7 artifacts
- **Process:** [AppMod-Process.instructions.md](../../instructions/AppMod-Process.instructions.md) — 24-step workflow context
- **Step Contract:** [AppMod-Step-Contract.json](../../instructions/AppMod-Step-Contract.json) — QA workflow mapping and step ownership
