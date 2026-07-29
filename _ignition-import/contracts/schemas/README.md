# Artifact field-contract registry

This folder holds **field contracts** for the modernization workflow's JSON artifacts. A
field contract is a small, machine-checkable description of an artifact's required shape. The
shared verifier ([`.github/scripts/shared/verify-step-artifacts.ps1`](../../scripts/shared/verify-step-artifacts.ps1))
loads the matching contract for an artifact and, when the artifact exists, checks that its
required fields and types are present and correct.

## Why a custom dialect instead of JSON Schema

The kit must run on **Windows PowerShell 5.1**, where `Test-Json -Schema` is not available
(it needs PowerShell 7+). Rather than add a dependency or require a newer shell from every
developer who receives the kit, the verifier uses a tiny, dependency-free dialect called
`opx-field-contract/v1`, implemented in [`field-contract.ps1`](../../scripts/shared/field-contract.ps1).
It runs on both Windows PowerShell 5.1 and PowerShell 7.

## What a present-but-invalid artifact means for a gate

The verifier already checked artifact **presence** (Missing / Hollow / Present). Field
contracts add **content** checking on top:

- A required input (`hardStop`) or any produced output that is **present but invalid** is
  treated like a missing one: it blocks (exit code 2).
- A present-but-invalid **advisory** or **conditional** input is reported as a warning and
  does not block.
- A tooling problem (contract file missing or itself corrupt) is reported as a loud
  `SchemaError` warning and never silently passes and never hard-blocks a developer.

This is the line between "the file exists" and "the file is actually usable by the next step".

## The golden authoring rule

> A field contract MUST pass on a **legitimately initialized** artifact.

Many state and control-plane files are created with empty strings or empty arrays before any
step enriches them (for example, `step-workflow-state.json` is reset with `updatedAt = ""`,
`lastExecutedStep.step = 0`, and `stepResponses.steps = []`). Only mark a field `notEmpty`
when it is non-empty **even at init**. A contract that is too strict is worse than no contract,
because it blocks valid runs and trains developers to ignore the gate.

Ground every contract in real producers and readers (writer scripts, reader scripts, the step
readback contract) and record those sources in the contract's `groundedBy` field. Never invent
fields that no producer emits.

## Dialect reference (`opx-field-contract/v1`)

A contract is a node. The root node is usually an `object`. The verifier understands these keys
on a node; everything else (`dialect`, `contractId`, `title`, `appliesTo`, `groundedBy`,
`authoringNote`, comments, ...) is ignored metadata.

| Key         | Applies to  | Meaning |
|-------------|-------------|---------|
| `type`      | any node    | One of `object`, `array`, `string`, `number`, `boolean`, `any`. A mismatch is a violation. |
| `required`  | object      | Array of property names that must be present. |
| `fields`    | object      | Map of `propertyName` -> child contract. Present children are validated; absent ones are covered by `required`. |
| `notEmpty`  | any node    | `true` => string not whitespace, array length > 0, object has at least one property, value not null. |
| `enum`      | scalar      | Array of allowed values. |
| `minItems`  | array       | Minimum element count. |
| `arrayOf`   | array       | A child contract applied to every element. |
| `rootPath`  | root only   | Optional label used as the root of violation messages (e.g. `step-workflow-state`). |

### Minimal example

```json
{
  "dialect": "opx-field-contract/v1",
  "contractId": "example",
  "rootPath": "example",
  "type": "object",
  "required": ["status", "items"],
  "fields": {
    "status": { "type": "string", "notEmpty": true, "enum": ["Ready", "Blocked"] },
    "items": {
      "type": "array",
      "arrayOf": {
        "type": "object",
        "required": ["id"],
        "fields": { "id": { "type": "number" } }
      }
    }
  }
}
```

## Adding a new contract

1. Identify the artifact's real producers and readers. Confirm the **initialized** shape.
2. Create `<artifact-name>.schema.json` here, using the smallest required floor that the
   consumers truly depend on. Record sources in `groundedBy`.
3. Add a `"schema": ".github/contracts/schemas/<artifact-name>.schema.json"` field to that
   artifact's entry (or entries) in
   [`.github/instructions/AppMod-Artifact-Contract.json`](../../instructions/AppMod-Artifact-Contract.json).
   The verifier builds a path -> schema map from the whole contract, so you only declare the
   schema once (normally on the producer's output entry) and it is enforced everywhere that
   path is referenced, including downstream `hardStop` inputs.
4. Validate with a golden example and at least one deliberately broken example before relying
   on it.

## Floor strength: ground it, do not guess it

The floor must be only as strict as the artifact's **real producer and consumers** justify.
Two grounding situations recur:

- **Deterministic producer exists** (a script writes a known shape, e.g. the control-plane
  trio's `New-ControlPlaneSkeleton`, or `step-workflow-state.json`'s reset writer). Ground the
  required floor in that writer's guaranteed fields and the runtime readers. Generate the golden
  by running the real writer.
- **Agent-authored, no deterministic producer, no committed sample** (e.g. the high-fan-out
  `decisions.json`, `migration-plan.json`, `control-point-inventory.json`). Keep the floor
  **conservative**: assert a non-empty object (`type: object`, `notEmpty: true`) to catch the
  real failure modes - empty `{}`, `[]`, blank, or truncated-to-non-object - and add a
  `notEmpty`/type check only on a field a consumer provably depends on, kept **non-required** so
  legitimate variation (e.g. a backend-only app with no browser sections) still passes. Record
  the prime tightening candidate in `authoringNote` and promote it to required only after you
  observe a real produced sample. A floor that false-blocks a valid run is worse than no floor.

## Current registry

| Contract | Artifact | Floor | Grounding |
|----------|----------|-------|-----------|
| `step-workflow-state` | `step-workflow-state.json` | Required identity + nested state fields (init-safe) | Deterministic reset writer + reader + readback contract |
| `modernization-execution-contract` | control-plane execution contract | Identity (`reportId` + `title`) | Deterministic skeleton + Step 5 prompt |
| `modernization-phase-assessment` | control-plane phase assessment | Identity (`reportId` + `title`) | Deterministic skeleton + Step 5 prompt |
| `modernization-solution-design` | control-plane solution design | Identity (`reportId` + `title`) | Deterministic skeleton + Step 5 prompt |
| `fusion-decisions` | `decisions.json` | Non-empty object + `browserSurfaceApplicability` non-empty if present | Agent-authored (conservative); browser-lane gate field |
| `fusion-migration-plan` | `migration-plan.json` | Non-empty object | Agent-authored (conservative); all reads are defensive |
| `fusion-control-point-inventory` | `control-point-inventory.json` | Non-empty object | Agent-authored (conservative); presence-only consumers |
| `per-route-behavior-plan` | `per-route-behavior-plan.json` | Non-empty (array or object root) | Agent-authored (conservative); root container unproven; entries reconciled, not schema-pinned |
| `executable-testcase-catalog` | `executable-testcase-catalog.json` | Non-empty object | Two producers, two root keys (`entries` vs `testCases`); reconciled, not schema-pinned |

## Shape vs. truth: schemas and reconciliation are two layers

A field contract proves an artifact is well **formed**. It cannot prove the artifact is **true**
against the rest of the workspace - a catalog entry can be perfectly valid JSON yet name a test
file that was never created. That second failure mode (hallucinated-but-believable content) is
caught by the **reconciliation engine** at
[`.github/scripts/shared/Invoke-StepReconciliation.ps1`](../../scripts/shared/Invoke-StepReconciliation.ps1).

- **Schema (verify-step-artifacts.ps1)** = does the file have the right shape and required fields?
- **Reconciliation (Invoke-StepReconciliation.ps1)** = does the file's content agree with the
  source tree and the other artifacts?

Reconciliation rules are registered per step. The first rule runs at **Step 17**: every
non-deferred testcase in `executable-testcase-catalog.json` must name a test file that exists on
disk. Each violation prints developer-guiding remediation (implement the test, or mark the case
`Deferred` and re-run Step 6), so a step that cannot self-heal still tells the developer exactly
how to finish it by hand. Use the same conservative-grounding discipline when adding rules:
reconcile only against facts a real producer guarantees.

