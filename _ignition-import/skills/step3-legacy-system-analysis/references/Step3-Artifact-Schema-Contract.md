# Step 3 Artifact Schema Contract

Schema Contract Version
- `step3ArtifactSchemaContractVersion`: `1.0.1`
- This version must match `.github/prompts/03-P1-legacy-system-analysis.prompt.md`.

Purpose
- Single owned schema reference for Step 3 `Legacy System Analysis` artifact payloads.
- Keep `.github/prompts/03-P1-legacy-system-analysis.prompt.md` thin and deterministic.

Scope
- Applies to all Step 3 runs regardless of app modality.
- Modality requiredness still comes from the prompt's modality matrix.




## Shared field definitions

### legacyEvidence object
All three deep inventories (Artifacts 1, 2, 3) require a `legacyEvidence` object on every entry. The gate evaluates `legacyEvidence` entries by reading `filePath` to detect generated-artifact pollution. To pass the pollution check, every `legacyEvidence` object MUST include `filePath` as a resolvable path to a real source file under `LegacyCode/` or `src/`:

```json
{
  "legacyEvidence": {
    "filePath": "LegacyCode/App/Controllers/MyController.cs",
    "file": "LegacyCode/App/Controllers/MyController.cs",
    "lineRange": "1-end"
  }
}
```

Rules:
- `filePath` is the canonical field the gate reads first. Always include it.
- `file` may be included for backward compatibility but DOES NOT substitute for `filePath`.
- Evidence pointing to generated paths (`coverage/`, `node_modules/`, `bin/`, `obj/`, `dist/`) will cause the gate to classify the inventory as polluted.
- Evidence that cannot be resolved to a file in `LegacyCode/` must use `wiringStatus: cannot-locate` (or equivalent) on the entry.

## Artifact 1: service-behavior-inventory.json
- One entry per public method of controllers, services, repositories, helpers, validators, and orchestrators in manifest scope.
- Required fields:
  - `className`
  - `methodName`
  - `returnType`
  - `parameters`
  - `branchingParameters`
  - `throwGuards`
  - `nullCoalescingDefaults`
  - `listOrCollectionReturn`
  - `displayDecorators`
  - `delegationPaths`
  - `legacyEvidence`

### Artifact 1 DB typing hints (recommended for DB-backed methods)

For repository and service methods that execute SQL or stored procedures, include these optional fields when evidence is available:

- `dbParameterTypeHints[]`: one row per SQL parameter with `name`, `sqlTypeHint`, and `evidence`.
- `dbResultColumnTypeHints[]`: one row per selected/result column with `column`, `sqlTypeHint`, `targetClrTypeHint`, and `evidence`.

Purpose:
- Preserve data-type evidence discovered in Step 3 so Step 8 and Step 9 do not infer incorrect row model types.
- Reduce Dapper constructor materialization failures caused by SQL/CLR type mismatches.

## Artifact 2: interaction-wiring-inventory.json
- One entry per interactive control on each captured surface.
- Required fields:
  - `controlId`
  - `surface`
  - `label`
  - `controlKind`
  - `triggerEvent`
  - `wiringKind`
  - `target`
  - `sideEffects`
  - `authGate`
  - `legacyEvidence`
  - `wiringStatus`
- Rule: untraced controls must use `wiringStatus: "cannot-locate"`.

## Artifact 3: workflow-trace-inventory.json
- One entry per high-risk control (`api-call`, `state-mutation`, `export`, `print`, `upload`, `download`).
- Required fields:
  - `workflowId`
  - `controlId`
  - `surface`
  - `triggerEvent`
  - `clientHandler`
  - `confirmDialog`
  - `preCallStateMutations`
  - `requestShape`
  - `serverHandler`
  - `responseShape`
  - `postCallStateMutations`
  - `visibleStateLabels`
  - `sideEffects`
  - `parityRisks`
  - `legacyEvidence`
  - `workflowStatus`
- Rule: partial traces are allowed only when missing fields are explicitly named.

## Artifact 4: apiEndpointCatalog (in inventory.json)
- One entry per controller action in `LegacyCode/`.
- Required fields:
  - `controller`
  - `action`
  - `httpVerb`
  - `routeTemplate`
  - `authRequired`
  - `parameterShape`
- Rule: if none found, emit an empty array.

## Artifact 5: uiControlClassification (in inventory.json)
- One row per interactive control from Artifact 2.
- Required fields:
  - `controlId`
  - `migrationEligible`
  - `controlKind`
  - `compositeGroupId`
  - `requiresWrapperCapability`
  - `a11yContract.testIdPattern`

## Artifact 6: screenshotCoverageMatrix (in legacy-system-analysis-report.json)
- One row per expected screenshot capture target.
- Required fields:
  - `routeId`
  - `state` (`idle`, `populated`, `empty`, `validationError`, `postAction`, `dialogOpen`, `focus`, `authStateVariant`)
  - `captureStatus` (`captured`, `captured-user-provided`, `pending-capture`, `blocked`)
  - `blockerReason` when capture status is not captured
- Rule: when portal capture has not run yet, emit all rows as `captureStatus: "pending-capture"` and include `blockerReason` describing the pending portal refresh state.

## Artifact 7: fusionPrimitiveCoverageCensus (in inventory.json)
- One row per distinct legacy UI control family.
- Required fields:
  - `capabilityId`
  - `legacyControlFamily`
  - `fusionEquivalent` (package + component name, or `null`)
  - `gapState` (`covered`, `needsWrapperExtension`, `needsFusionFeatureRequest`, `noFusionEquivalent`)
  - `mcpVerifiedUtc`

Validation expectation
- `.github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1` is the executable enforcement path.
- This file is the canonical human-readable schema contract for Step 3 artifacts.
