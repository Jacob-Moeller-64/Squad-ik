---
description: Step 14 browser UI planning lane that builds the execution-grade inventory, visual contract, Fusion map, and migration order for later deliberate UI replacement.
agent: OpX-AppMod-P2-Modernize
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - agent
  - browser
  - edit/editFiles
  - todo
  - vscode/vscodeAPI
  - fusion/copilot-docs/*
---

# Step 14 Frontend UI Inventory & Fusion Map

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 14 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 14 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Builds the execution-grade plan for the Fusion UI migration - it catalogs every UI control family (buttons, form controls, grids, dialogs, nav...), measures the visual contract, maps each family to a Fusion-owned / wrapper / bridge / keep decision, and sets a dependency-safe replacement order. No app behavior changes in this step.
- **Why it matters:** Steps 15-16 each advance exactly ONE family without rediscovery. If the inventory, contract, or order is vague here, every later slice has to re-investigate and the swap order can break dependencies.
- **What you will have when it is done:**
  - `ui-inventory.json` - every primitive family with per-control classification.
  - `ui-visual-contract.json` - the measurable visual answer key (sizing, spacing, palette, typography).
  - `ui-fusion-map.json` - each primitive mapped to Fusion-owned / wrapper / bridge / keep.
  - `ui-migration-order.json` - the dependency-safe order Steps 15-16 follow.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 14 OWNS the UI migration plan** - the decision-grade inventory, measurable visual contract, Fusion map, and replacement order.
- **This step does NOT own:** any code change (Steps 15-16 execute the plan), data or auth (Step 12), or shell stabilization (Step 13). It is planning only: no `src/` behavior changes here.
- **This step CONSUMES:** the Step 13 visual-parity verdict (entry gate - do not begin until `visual-parity-report.json overall: pass`), plus the Step 3 control classification and the Step 5 wrapper-capability plan and sub-pattern order. If the inventory has to invent a field the upstream artifacts never captured, that is an upstream gap - route it back to Step 3 or Step 5, do not absorb it here.

**Desired completed state:** a planning pack explicit enough that Step 15 can advance one eligible family without rediscovering the inventory, the visual contract, or the replacement strategy - `inventoryCoverageStatus: DecisionGrade`, `visualContractStatus: Measured`, and a dependency-safe `ui-migration-order.json`.

About To Do
- Context: Step 14 is the execution-grade UI planning lane. It must prove the UI inventory, measurable visual contract, and replacement map are explicit enough that Step 15 can advance one family without rediscovery.
- Dev work: Refresh the UI planning pack from current browser evidence, make ownership and migration order explicit, and stop only when the pack is decision-grade or blocked.
- QA plan: Use `[WORKFLOW] Frontend UI Inventory & Fusion Map` inside the active Step 14 loop at meaningful checkpoints and at closeout to confirm the pack is usable enough for deliberate UI replacement instead of broad-but-incomplete documentation.

Objective
- Execute Step 14 `Frontend UI Inventory & Fusion Map` as the execution-grade planning lane for deliberate Fusion UI adoption.
- Build or refresh the browser-surface planning pack so later primitive-family work does not rediscover the UI contract.
- Classify Step 14 completion explicitly with these statuses:
  - `inventoryCoverageStatus`: `DecisionGrade`, `Partial`, or `Blocked`
  - `visualContractStatus`: `Measured`, `Partial`, or `Blocked`
  - `step15HandoffStatus`: `ReadyForUIReplacement`, `NotReadyForUIReplacement`, or `Blocked`
- Do not report Step 14 ready when primitive families are cataloged loosely, when measurable contract values are still missing for high-risk surfaces, or when migration order is not safe enough to select the next family confidently.

Execution mode
- This prompt is operational, not advisory. Refresh the planning-pack artifacts until they are explicit enough to drive deliberate UI replacement truthfully.
- Entry discipline (visual-parity gate): Step 14 begins the Fusion map-and-swap block, so do not start it until the Step 13 visual-parity gate passed. Require a current `.modernization/fusion-restructure/visual-parity-report.json` with `overall: pass` (visual parity to the legacy answer key met, or every residual gap explicitly accepted with reasons). If it is missing, stale, or `fail`, stop and route back to Step 13 to finish shell visual parity instead of mapping and swapping over a shell that does not yet resemble the legacy app.
- Treat the mapped QA workflow as the Step 14 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json` before building the planning pack.
- Confirm the Step 13 visual-parity gate is satisfied before mapping primitives: `.modernization/fusion-restructure/visual-parity-report.json` must be current and `overall: pass`. A failing or missing report routes back to Step 13.
- Catalog every significant primitive family currently in use, at minimum:
  - buttons and actions
  - form controls
  - cards and containers
  - dialogs and modals
  - navigation
  - data tables and grids
  - charts and visualizations
  - shared wrappers, directives, badges, toasts, tooltips, and similar surfaces

**Accessibility Inventory (MANDATORY)**
For each primitive family, catalog:
- Current ARIA attributes (or lack thereof)
- Current `data-testid` patterns (or lack thereof)
- Keyboard interaction support status
- Screen reader compatibility notes
- Required accessibility remediation before/during replacement
- Inventory without accessibility gaps documented is incomplete Step 15 coverage.

**Playwright Test Inventory (MANDATORY)**
For each primitive family, catalog:
- Existing POM coverage (or gaps)
- Existing Gherkin scenarios (or gaps)
- Required test updates during family replacement
- High-risk families (grids, charts, forms) MUST have explicit test plans
- Inventory without test gap analysis is incomplete Step 15 coverage.
- Flag grids, charts, heavily customized tables, and composite forms as high-risk families when present.

**Upstream Source Of Truth (MANDATORY)**
Step 14 is a refresh, not a discovery. The per-control classification, sub-pattern catalog, and wrapper-capability requirements are Discovery deliverables:
- Per-control classification fields originate in Step 3 `uiControlClassification` (see `/.github/instructions/ui-capture-reverse-engineering.instructions.md` Form Control And Primitive Classification).
- Wrapper-capability requirements originate in Step 5 Wrapper Capability Plan (see `decisions.json.wrapperCapabilityPlan`).
- Sub-pattern order originates in Step 5 UI Migration Sub-Pattern Order (see `ui-migration-order.json`).
Step 14 reads those artifacts and carries the fields forward into `ui-inventory.json` and `ui-fusion-map.json`. Any field Step 14 has to invent from raw source is an upstream gap and must route back to Step 3 or Step 5 instead of being absorbed here.

**Per-Control Classification (MANDATORY)**
For every interactive control in every primitive family, the inventory MUST carry:
- `bindingShape`: one of `twoWayNgModel`, `oneWayNgModel`, `uncontrolledValueEvent`, `reactiveFormControl`, or `uncontrolledNoModel`. Step 15 and Step 16 selection depends on this.
- `optionsAreLiteralModelValues`: `true` when `<option>` elements have no `value` attribute and the option text is the bound model value. Replacement option arrays must satisfy `label === value` and bind with `valuePrimitive=true`.
- `migrationEligible`: `false` for parity-scaffold and reverse-engineering capture controls (`*-parity-*`, `*-selector-capture-*`, `*-hidden-*` naming families when present). Ineligible controls must never surface as Step 15 or Step 16 candidates.
- `compositeGroupId`: shared id for visually paired controls that form one semantic unit (numeric input with flanking adjuster buttons, search input with embedded action). Step 15 and Step 16 swap composite groups as a unit or explicitly defer the unmigrated members with a recorded reason.
- `dynamicId`: `true` when `id` is template-interpolated per row or per index (`id="lrSum-{{i}}"`). Controls flagged `dynamicId: true` require a documented `testIdFn` or interpolation contract before swap.
- `requiresWrapperCapability`: array of wrapper kinds or features the slice depends on (for example `["kind:file"]`, `["disabled-input"]`, `["generic-options"]`). Step 16 must skip slices whose required capability is not yet present in the wrapper and either close the gap or record the skip with a reason.
- `dialogContext`: `true` when the control lives inside a dialog or modal. Dialog controls belong in a dialog family or sub-family, not in the main-shell control family.
Inventory without these per-control fields populated is incomplete Step 15 coverage and Step 16 must not advance.

**Sub-Pattern Cataloging (MANDATORY)**
For each primitive family, catalog its sub-patterns explicitly so Step 15 and Step 16 can advance one sub-pattern per pass without rediscovery:
- group controls by binding shape, value type (boolean, numeric, string-literal, lookup-object), and wrapper-capability requirement
- record each sub-pattern as `{subPatternId, description, controls[], requiresWrapperCapability[], suggestedPassOrder}`
- a family with three or more sub-patterns must declare a dependency-safe `suggestedPassOrder` so Step 16 selection is deterministic
- families without sub-pattern cataloging are incomplete Step 14 coverage
- Record the measurable visual contract for the current browser surface, including sizing, spacing, typography, colors or token references, border values, shadows, transitions, and breakpoint-sensitive layout rules. Keep `.modernization/fusion-restructure/ui-visual-contract.json` aligned to the legacy answer key so it stays the comparison source for the visual-parity gate: palette, typography (including `@font-face` families), header/nav/footer chrome presence, the nav route model, and the per-route reference screenshots must be present alongside the sizing and layout values.
- Map each significant primitive to exactly one of `Fusion-owned final state`, `App-owned wrapper over Fusion`, `Temporary bridge`, or `Keep as app-owned`.
- Define a dependency-safe migration order that keeps the one-primitive-family-per-pass rule explicit for later deliberate replacement work.
- Refresh `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-inventory.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`.

Completion gate
- Return `Ready for Step 15 Fusion UI Integration: Yes` only when the planning pack is explicit enough that one eligible primitive family can be executed without rediscovering the inventory, the measurable visual contract, or the replacement strategy.
- Otherwise keep the exact next step on `Step 14 Frontend UI Inventory & Fusion Map`.
- In the numbered-step response, include explicit `inventoryCoverageStatus`, `visualContractStatus`, and `step15HandoffStatus` values.

Component Reuse Analysis (MANDATORY)
- After the per-route inventory is built, cluster components across routes by shape signature: input props, emitted events, content slots, control composition, layout role. Tools may include hashing of normalized template ASTs, similarity comparison of `@Input`/`@Output` surfaces, or visual signature comparison of captured screenshots.
- Emit ``/.modernization/ignition-artifacts/modernize/fusion-restructure/component-reuse-clusters.json`` with each cluster row: ``clusterId``, ``signatureSummary``, ``members[]`` (controlId, route, file), ``similarityScore`` (0..1), ``recommendation`` (``unify-now``, ``unify-at-step-15``, ``keep-distinct``, ``needs-review``), and ``recommendationReason``.
- Clusters with ``similarityScore`` at or above 0.85 default to ``unify-at-step-15`` so Step 15 wrapper work consolidates the duplicate surfaces into a single Fusion-backed wrapper instead of shipping N near-identical wrappers.
- Generic across MVC partials, Razor Pages partial views, Web Forms user controls, AngularJS directives, Angular components, React components, Vue SFCs, Blazor components, and server-rendered HTML fragments. Signature extraction is data-driven from ``componentCensus`` and ``uiControlClassification``, not from hard-coded component names.

If You Hit A Blocker (finish this step, do not drift)
- An incomplete or loosely-cataloged plan forces every Step 15/16 slice to re-investigate and risks an unsafe swap order, so finish the plan here instead of advancing.
- Name the exact missing piece (an uncataloged family, an unmeasured high-risk contract value, a per-control field the inventory could not populate), the most likely cause in plain language, and the concrete fix to finish Step 14. If a required field can only come from raw source because an upstream artifact never captured it, route it back to Step 3 or Step 5 rather than inventing it here.
- Only advance when the planning pack is decision-grade. Otherwise keep the exact next step on `Step 14 Frontend UI Inventory & Fusion Map`.

## Step 14 DEV complete - next action

Step 14 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 14 QA will:** Quick schema and content validation of the artifacts Step 14 DEV produced. Fast and side-effect-free, safe to chain automatically after Step 14 DEV completes.
**Lanes:** Artifact schema validation only (no test execution)
**Expected ETA:** Under 1 min ET. Chainable / auto-runnable.

Reply with the number of your choice:
1. `QA` - run `14-QA-frontend-ui-inventory-and-fusion-map` now (recommended).
2. `next` - continue to Step 15 DEV (Fusion UI Integration).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/14-QA-frontend-ui-inventory-and-fusion-map`.
