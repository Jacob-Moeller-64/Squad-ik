---
name: appmod-process-sequence
description: Human-readable 3-phase, 24-step Dominion modernization workflow with QA route expectations, evidence requirements, and exit criteria.
---

# Modernization Process Sequence

<!-- Purpose: Shared modernization map for Copilot agents and operators. Keep this file aligned to the real step sequence, expected outcomes, and QA routing. -->

This file is the durable human-readable authority for the modernization process. It explains which numbered step comes next, what each phase owns, what evidence must exist, and how QA fits into the flow.

## How Agents Should Use This File

Use this file to answer these questions before acting:

1. Which phase is active: Discovery, Modernize, or Review?
2. Which numbered step is active, and what should that step accomplish?
3. What evidence or artifact family should already exist before this step starts?
4. Does this step use a dedicated QA prompt handoff, or does validation stay inside the step-owned evidence and gates?
5. What is the next numbered step when the current step succeeds?

If the current request conflicts with this sequence, surface the conflict instead of inventing a new path.

## Process At A Glance

| Phase | Primary Goal | What "Done" Looks Like |
| --- | --- | --- |
| Discovery | Establish local readiness, align the starter workspace to the real app identity, capture baseline truth, and produce the execution plan. | The workspace is renamed, the copied legacy runtime and current system behavior are understood well enough to plan, and the modernization plus quality design packs are ready. |
| Modernize | Execute the approved backend and frontend migration plan with embedded QA and current proof. | Approved modernization slices are implemented, validated, and captured in the expected parity, verification, and QA artifacts. |
| Review | Rebuild final verification, acceptance, readiness, and technical sign-off evidence. | Final review evidence is current, explicit, and strong enough for sign-off or a truthful blocked decision. |

## Core Outcome Priorities

When trade-offs arise, optimize for these outcomes first:

- Reverse engineering quality: Discovery must produce decision-grade understanding of behavior, routes, controls, dependencies, and source-stack treatment.
- Forward engineering quality: Modernization must rebuild in the approved target architecture while preserving required behavior.
- QA quality: every major step must be backed by current, explicit evidence instead of prose confidence.

## Core Principles

- This is a 3-phase workflow with one global numbered sequence through Step 24.
- Phase ownership is strict: Discovery (Steps 1 through 6) owns planning and derivation, Modernize (Steps 7 through 18) executes that plan, and Review (Steps 19 through 24) verifies and dispositions outcomes.
- Each numbered step is a readable process unit. Prompts, agents, and helper workflows support the step model; they do not replace it.
- Preserve evidence as you go. Important modernization truth belongs in repo artifacts, not only in chat.
- Start each numbered step from current evidence, not remembered intent. Missing or stale upstream proof should be refreshed or reported as `Blocked`.
- Mandatory upstream loop: if Phase 2 or Phase 3 finds a missing inventory fact, baseline input, planning decision, or catalog rule, stop the active step and route the gap back to the owning Discovery step instead of patching derivation into Modernize or Review.
- Keep `Pass`, `Partial`, `Blocked`, and `Fail` distinct. Skipped coverage or stale artifacts are not equivalent to current proof.
- Use the app-named starter-derived target under `src/<AppName>.*` as the modernization destination.
- After Step 1 captures copied-legacy runtime truth, treat `LegacyCode/` as an immutable baseline reference except for the allowed `LegacyCode/<LegacyTestProject>/Characterization/Baseline` subtree.
- Do not perform modernization-owned writes under `LegacyCode/` after Step 1. When Step 7 needs backend uplift, do it in a separate mutable workspace named `LegacyCode_NETXX_Upgrade`, where `XX` is the approved highest even .NET major version.
- When modernizing the UI, prefer a human-readable migration pattern: scaffold, identify legacy behavior, port incrementally, and verify.
- Follow one canonical frontend sequence and do not reorder it:
  1. Re-architect the browser surface into `src/` using the Fusion starter standards (Steps 8 through 13).
  2. Make the modern UI resemble the **legacy** app through a legacy visual contract — Step 10 applies it (app-owned design tokens from the legacy palette and typography, Fusion theme bound to those tokens, branded header, nav populated from the route inventory, and footer), and Step 13 stabilizes it.
  3. Verify the modern app still **functions** (runtime parity), **exposes the same fields, columns, and controls** as legacy (field parity), and **looks like the legacy app** (visual parity) against the legacy answer key.
  4. Only then map and swap to Fusion components (Steps 14 through 16).
- Hard rule: do not begin Fusion primitive swapping (Step 14 and later) until functional, field, and visual parity to the legacy app are met, or the residual gap is explicitly accepted with recorded reasons. Field parity means every legacy grid column/field, filter, and control is present and wired in the modern route - a grid that loads real data but in fewer or more generic columns than legacy (column collapse), or a control whose handler is stubbed, is a parity defect, not an accepted default.
- Answer-key principle: the visual-parity reference is always the **legacy application in `LegacyCode/`** plus the extracted legacy visual contract, never a finished modern reference. The legacy visual language is mechanically derivable from legacy source for any application, so "the modern app does not resemble the legacy app" is a gate failure, not an accepted default.
- Treat testability as part of forward engineering, not as cleanup.

## Step Model

- Step numbers are global across the full process and do not reset per phase.
- A numbered step includes its obvious same-step remediation loop.
- A step should be marked `Blocked` only after the step-owned deterministic remediation path has been attempted or ruled out with explicit evidence.
- The readable sequence here must stay aligned with `/.github/instructions/AppMod-Step-Contract.json`.

## Phase 1: Discovery

Discovery prepares the workstation and workspace, captures current-state truth, and converts that truth into a decision-grade modernization and QA plan.

### Discovery Steps

| Step | Current Step Name | Purpose | Expected End State | QA Prompt After Step |
| --- | --- | --- | --- | --- |
| 1 | Workstation Readiness | Validate local tools, feed access, Sonatype readiness, and the manual starter plus copied-legacy setup and verification prerequisites before numbered work continues. | The workstation state is explicit, the user has the exact manual run guidance from `/.modernization/.readme/HowToRun.md`, legacy code has been copied into `LegacyCode/` before local run validation, copied-legacy verification is called out as required, and the recommended next step is Step 2. | `None` |
| 2 | Rename Starter To `<AppName>` | Align the starter-derived workspace to the intended app identity from `/.modernization/.readme/kit-params.md`. | The active `src/` workspace, project names, and reusable references reflect the real app identity, and rename evidence captures what changed and what was intentionally excluded. | `None` |
| 3 | Legacy System Analysis | Inspect the imported legacy application and capture how the current system behaves, how routes and controls work, and where high-risk seams live. | Discovery artifacts describe screens, routes, workflows, source-stack families, high-risk controls, traceability seams, confidence, and unresolved gaps. `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` is current enough for planning. | `None` |
| 4 | Baseline Acceptance-Criteria Review | Measure the current application against the modernization acceptance criteria before implementation begins. | Baseline acceptance findings are ranked into planning blockers versus lower-priority deltas, and Step 5 receives decision-grade planning inputs. | `None` |
| 5 | Modernization Solution Design | Turn the Discovery evidence into one simple, reviewable modernization plan with target structure, ownership decisions, movement strategy, and execution order. | The development plan, migration structure, control-point decisions, and Fusion-first ownership contract are explicit enough for implementation to proceed without reopening core architecture questions. | `None` |

### Required Discovery Companion Gate

- `Modernization Quality Design` is Step 6.
- It runs after Step 5 and before Step 7.
- It is the required Discovery completion gate before backend execution begins.
- It owns the shareable requirements document, `.modernization/portal/data/json/qa-test-plan.json`, `.modernization/artifacts/generated/testing-ownership-matrix.generated.json`, `.modernization/portal/data/json/executable-testcase-catalog.json`, `.modernization/portal/data/json/characterization-test-planning.json`, the phased characterization ladder, regression planning, risk planning, tool rationale, and ADO CI/CD planning.
- It does not expose a standalone QA prompt handoff. When Step 6 needs helper verification, it reuses `[WORKFLOW] Modernization Solution Design` and then `[WORKFLOW] Modern Build Planned QA Tests` inside the step itself.

### Discovery Handoff Discipline

- Step 3 must hand forward the best-known downstream seams for high-risk control families, the exact cannot-locate backlog, and the confirmations still needed before planning is decision-grade.
- Step 4 must turn acceptance findings into ranked planning input that separates Step 5 blockers from lower-priority deltas.
- Step 5 must explicitly dispose of each material Step 3 or Step 4 carry-forward item as a planning decision, user-input gate, later-step owner, or explicit blocker.

### Discovery Exit Criteria

Discovery is complete when all of the following are true:

- Step 1 recorded the workstation state honestly, preserved visible feed and credential gaps, and returned the manual starter plus copied-legacy verification instructions without overstating proof.
- The toolkit workspace has been aligned to the real app identity using `kit-params.md`.
- Step 3 captured current-state routes, workflows, screenshots, source-stack families, high-risk controls, and unresolved gaps strongly enough that later steps do not guess through missing legacy truth.
- Step 4 ranked baseline acceptance findings into concrete planning input.
- Step 5 produced a developer-facing modernization solution design, migration structure, target folder map, movement sequencing, control-point inventory, and ownership decisions that later steps can consume directly.
- Step 5 refreshed `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` and kept them aligned.
- When `browserSurfaceApplicability` is `Required`, Step 5 also refreshed the browser planning pack: `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-inventory.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json`. `styling-foundation.json` and `ui-visual-contract.json` must carry the extracted legacy visual contract (theme palette, typography including any `@font-face` families, header/nav/footer chrome regions, the nav route model, and per-route reference screenshots) so it can serve as the answer key for the Step 13 visual-parity gate.
- Step 6 produced the testing and quality design pack strong enough for backend execution to begin at Step 7.

## Phase 2: Modernize

Modernize begins by proving the backend uplift in a separate mutable workspace, then incrementally moving validated backend and frontend concerns into app-named `src/<AppName>.*` roots while preserving current proof.

### Modernize Execution Posture

- Treat Steps 7 through 18 as step-owned execution lanes, not as a user-confirmed pause after every micro-slice.
- Keep QA inside the active step loop at meaningful checkpoints, blockers, and closeout proof refreshes.
- Re-entering a completed modernization step is allowed when the user explicitly wants a higher-confidence or higher-quality pass.
- For browser-led apps, keep navigation smoke and client-to-API proof current as route families and UI slices land.

### Current Phase 2 Understanding

| Step | Current Step Name | Purpose | Expected End State | QA After Step |
| --- | --- | --- | --- | --- |
| 7 | Backend - Upgrade .NET | Upgrade the backend in a separate mutable workspace derived from the frozen baseline before anything moves into `src/`. The `src/` baseline check is operator attestation only, not an execution surface for Step 7 build or runtime probes. Step 7 runs in a declared topology mode: `RunnableRuntime` (full runtime proof required) or `ConstrainedLegacyHost` (legacy System.Web host is non-runnable for net10 in-place, so build/invariant/handoff proof is required). | The raw backend uplift is proven in the Step 7 mutable upgrade workspace, characterization lanes are current, and host/runtime disposition is explicit before Step 8 begins. Constrained legacy-host topology is a valid Step 7 completion path when required handoff evidence is present. | `[WORKFLOW] Backend - Upgrade .NET` |
| 8 | Backend - Modernization Formation | Move validated backend concerns into `src/<AppName>.Library` first and `src/<AppName>.Web.Api` second, validating both moves. | The modern backend now lives in app-named `src/` roots, current backend characterization is preserved, and the separated backend is proven against the retained legacy frontend checkpoint. | `[WORKFLOW] Backend - Modernization Formation` |
| 9 | Backend - .NET Integration Hardening | Finalize auth, logging, caching, configuration, and integration behavior after backend formation is stable. | The backend is hardened for real .NET runtime operation, and contract plus integration proof are current before frontend-heavy work consumes it. | `[WORKFLOW] Backend - .NET Integration Hardening` |
| 10 | Frontend Foundation & Scaffold | Establish the destination browser shell, styling foundation, screenshots, locator contracts, and scaffolded client structure, and make the modern shell inherit the legacy visual language by construction. | The modern client shell is formed, app-owned design tokens are generated from the legacy palette and typography, the Fusion theme is bound to those tokens, the shell chrome (branded header, route-populated nav, footer, layout density) renders, decomposition artifacts are current when required, and the browser surface is ready for feature migration. An empty nav or a raw default framework theme is a Step 10 failure. | `[WORKFLOW] Frontend Foundation & Scaffold` |
| 11 | Frontend Migration | Move shared client code and route families into the approved target root while preserving behavior and legacy markup. Deliberate Fusion primitive-family swaps are Step 14-16, not Step 11. | Approved route families and shared client code have moved into the target client, and unresolved gaps are explicitly classified instead of hidden. | `[WORKFLOW] Frontend Migration` |
| 12 | Frontend Platform Integration | Align auth, callback/logout, protected API ownership and per-route data wiring. | Migrated routes use real protected backend calls, auth and control points match the Step 5 contract, and placeholder data is no longer silently shipped. | `[WORKFLOW] Frontend Platform Integration` |
| 13 | Frontend Shell Stabilization | Repair shell-level parity drift after migration and platform integration, then run the field-parity reconciliation and the visual-parity gate against the legacy answer key. | The browser shell is stable enough for UI-planning and UI-replacement work, the runtime-parity-checkpoint `fieldParity` roll-up is `pass` (every legacy column/field and control is present and wired - no column collapse, no inert control), and `.modernization/ignition-artifacts/modernize/fusion-restructure/visual-parity-report.json` shows `overall: pass` (visual parity to the legacy app is met, or every residual gap is explicitly accepted with reasons). | `[WORKFLOW] Frontend Shell Stabilization` |
| 14 | Frontend UI Inventory & Fusion Map | Build the execution-grade browser planning pack for deliberate Fusion UI replacement. Do not start until the Step 13 visual-parity gate is `pass`. | Inventory, visual contract, Fusion map, and dependency-safe order are current enough for deliberate primitive-family replacement. | `[WORKFLOW] Frontend UI Inventory & Fusion Map` |
| 15 | Fusion UI Integration | Execute one deliberate Fusion primitive-family replacement pass. | Exactly one primitive family advances with current component-level proof and explicit wrapper or bridge status. | `[WORKFLOW] Fusion UI Integration` |
| 16 | Next Fusion UI Upgrade Slice | Continue deliberate primitive-family replacement one eligible family at a time. | One additional eligible family advances, or the lane truthfully reports that no eligible family remains. | `[WORKFLOW] Next Fusion UI Upgrade Slice` |
| 17 | Rewire All Tests & Verify | Refresh modern test ownership, rerun critical proof, and verify browser-to-API wiring after UI work settled. | Modern verification is current, skipped proof is explicit, and the combined test plus runtime pack is strong enough for cleanup. | `[WORKFLOW] Rewire All Tests & Verify` |
| 18 | Deployment & Clean Up | Update deployment-facing references, remove validated leftovers, and make cleanup truth explicit before review. | Deployment references, cleanup disposition, and validated leftovers are current and explicit enough for review entry. | `[WORKFLOW] Deployment & Clean Up` |

### Frontend Parity Gate (before Step 14)

The frontend chain enforces a dedicated parity gate between shell stabilization and Fusion primitive swapping, covering two distinct dimensions: **field parity** (the modern route exposes the same grid columns/fields, filters, and controls as legacy) and **visual parity** (the modern shell looks like legacy). It is the **COMPARE** step of the legacy-parity contract.

- **Where it gates:** Step 13 confirms both at closeout - it **owns** visual parity outright and **confirms** field parity, whose underlying content work is owned upstream by Step 11 (control/column presence) and Step 12 (live data); a field-parity `fail` surfaced here is a Step 11/12 regression to fix at its source, not new Step 13 work. Step 14 must not begin the map-and-swap block until field parity and visual parity are `pass`.
- **Field parity (content):** for every in-scope route, the runtime-parity-checkpoint `fieldParity` roll-up must be `pass` - every legacy grid column/field is rendered (no column collapse, where a grid loads real data but in fewer or more generic columns than legacy) and every legacy filter/action control is present and wired to a real handler (no inert stubbed-handler control). Additionally, `filterEffectParity` must be `pass` - every filter/search control actually changes the visible row set when applied (a filter that returns identical rows before and after is a dead filter, not a working one). And `siblingListDistinctnessOverall` must be `pass` - every route with multiple sibling list sections returns distinct data per section (identical rows across tabs/sections indicates a wrong discriminator and is a functional parity failure). Derive the answer key from the per-route inventory, or extract it from the legacy route source when the inventory lacks column grain. A side-by-side dual-port comparison against the runnable legacy app (`LegacyCode_NETXX_Upgrade` when the original `LegacyCode/` host is not runnable) is the recommended way to confirm it.
- **What it compares:** the modern shell against the legacy visual answer key - palette, typography, header/nav/footer presence, the nav route model, and layout density - using the extracted legacy visual contract in `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json` and `styling-foundation.json`.
- **How it runs:** boot the modern app and, when runnable, the legacy app on a second port (dual-port), capture matching routes, and diff computed styles plus screenshots against the contract. When the legacy app is not runnable, compare against the static contract values and the captured legacy reference screenshots. Reuse `/.github/skills/visual-parity-gate/SKILL.md`, which composes the `runtime-parity-checkpoint` and `screenshot-capture` skills. The live dual-port side-by-side view is a developer aid; the enforced gate is the automated diff.
- **Evidence:** `.modernization/ignition-artifacts/modernize/fusion-restructure/visual-parity-report.json` with per-route `pass`, `partial`, or `fail` across palette, typography, header/nav/footer presence, and layout, plus roll-ups.
  - `pass` - every dimension meets the contract.
  - `partial` - chrome and nav render and the screen is recognizably the legacy screen, but a lower-priority style dimension still drifts.
  - `fail` - an empty nav, a raw default framework theme, missing header/footer chrome, or a screen that is not recognizably the legacy screen.
- **Decision:** `overall` is `pass` only when every route is `pass`, or every non-`pass` route is covered by an explicit accepted residual-gap entry with a recorded reason and owner. A `fail` route without an accepted gap blocks Step 14.

### Modernize Exit Criteria

Modernize is complete when all of the following are true:

- The backend uplift happened in the separate Step 7 mutable workspace and only validated seams moved into app-named `src/` roots.
- When `browserSurfaceApplicability` is `Required`, the Step 13 visual-parity gate reached `overall: pass` (or every residual gap is explicitly accepted) before Step 14 began the Fusion map-and-swap block.
- Backend and frontend characterization evidence stayed current as ownership moved from legacy to modern roots.
- Backend formation moved through `Library` before `Web.Api` and left integration hardening explicit.
- When `browserSurfaceApplicability` is `Required`, the browser shell, route families, platform integration, stabilization, UI planning, deliberate Fusion replacement, final verification, and cleanup passes are all current.
- When `browserSurfaceApplicability` is `NotApplicable`, the later browser-led steps returned lightweight proof passes with explicit reasons.
- Step 17 produced or refreshed the modern verification pack strongly enough for review to consume.
- Step 18 made deployment references and cleanup disposition explicit instead of implied.

## Phase 3: Review

Review rebuilds final verification, acceptance, readiness, and technical sign-off evidence from the accepted modernization state.

### Review Steps

| Step | Current Step Name | Purpose | Expected End State | QA After Step |
| --- | --- | --- | --- | --- |
| 19 | Final Fusion Restructure Review | Review the current `src/` state for Fusion package usage, starter-shell alignment, and temporary-bridge validity. | A specialist Fusion review exists with prioritized findings, safe remediation candidates, and explicit starter-shell plus bridge-status evidence. | `[WORKFLOW] Final Fusion Restructure Review` |
| 20 | Final Verification | Run the final build, suite, runtime, and control-point proof pass before broader review. | Final verification evidence is current enough for visual and acceptance review to proceed. | `[WORKFLOW] Final Verification` |
| 21 | Figma Review | Compare the final browser experience against the approved visual direction, or record why visual review does not apply. | Visual drift is explicit by severity, or a truthful not-applicable proof exists. | `[WORKFLOW] Figma Review` |
| 22 | Final Acceptance-Criteria Review | Re-check the modernized application against the modernization acceptance criteria and the approved control-point contract. | The final acceptance matrix, baseline-to-final deltas, blocker severity, starter-shell preservation, and bridge status are decision-grade. | `[WORKFLOW] Final Acceptance-Criteria Review` |
| 23 | Final Readiness Review | Rebuild the release-decision evidence pack and make the release decision explicit. | The final readiness artifact records current QA, build and packaging proof, deployment-readiness posture, cleanup disposition, bridge status, and one explicit release decision. | `[WORKFLOW] Final Readiness Review` |
| 24 | Technical Review | Run the final technical quality gate, apply bounded remediation, and publish the remaining issue set with disposition. | The final technical review artifact rates quality, records deterministic remediation outcomes, and leaves release decisions with explicit technical truth. | `[WORKFLOW] Technical Review` |

### Review Entry Discipline

- Review is not the place to rediscover missing modernization truth that Step 17 or Step 18 should have made explicit.
- Reuse prerequisite review proof when it still matches the same accepted source state.
- Step 19 requires current Step 17 verification proof and Step 18 cleanup disposition.
- Step 20 requires the current Step 19 Fusion review artifact plus the prerequisite proofs it depended on.
- Step 21 requires current Step 20 final verification evidence plus the latest working-versus-visible interaction inventory for the reviewed scope.
- Step 22 requires current Step 20 final verification evidence and Step 21 visual-review or explicit not-applicable proof.
- Step 23 requires current Step 17 verification proof, Step 18 cleanup disposition, Step 20 final verification evidence, and the Step 22 final acceptance artifact.
- Step 24 requires current Step 23 final readiness evidence and all prior review gate artifacts.

### Review Exit Criteria

Review is complete when all of the following are true:

- Step 19 Fusion review evidence exists for the final numbered-lane state.
- Step 20 final verification evidence exists for build, suites, runtime, and control-point alignment.
- Step 21 visual review evidence exists when browser review applies, or an explicit not-applicable proof exists when it does not.
- Step 22 final acceptance evidence exists as a criterion-by-criterion matrix with current control-point and bridge status.
- Step 23 final readiness evidence includes current QA, build and packaging proof, deployment-readiness proof, cleanup disposition, and one explicit release decision.
- Step 24 technical review evidence includes bounded remediation outcomes, focused post-remediation reruns, and an issue disposition ledger using `Resolved`, `Deferred`, `Blocked`, and `AcceptedRisk`.
- The final review lane returns an explicit `Pass`, `Blocked`, or `Fail` decision instead of prose-only readiness language.

## Workflow Routing Guidance

### Workflow-Count Rule

- Prefer the minimum number of workflows.
- Steps 7 through 24 should expose one primary QA workflow named after the step unless the process file explicitly defines a chained helper model.
- Discovery steps 1 through 6 close from step-owned evidence and gates instead of dedicated QA prompt associations.
- Reuse helper workflows such as `Modern Build Planned QA Tests`, `Modern Runtime Smoke`, `Validate Current Slice`, and `Validate Modernization Milestone` inside the named step workflow instead of duplicating their logic.

### Routing Authority

- Use `/.github/instructions/AppMod-Step-Contract.json` for the exact step-to-workflow mapping and the machine-checkable Discovery-to-Modernize gate used between Steps 6 and 7.
- Use `/.github/prompts/qaTestPrompts/qa-core-workflows.prompt.md` for the detailed behavior of each named QA workflow.
- Discovery steps 1 through 6 do not route to dedicated QA prompts after the step completes.
- Discovery requires `Modernization Quality Design (Step 6)` as the required completion gate before Step 7. Inside Step 6, reuse `[WORKFLOW] Modernization Solution Design` and `[WORKFLOW] Modern Build Planned QA Tests` in that order.

### Convenience Runner

- `/.github/prompts/01-P1-workstation-readiness.prompt.md` is the convenience entrypoint that resolves the next eligible numbered step from current evidence and `/.modernization/portal/data/json/step-workflow-state.json`.
- It does not replace the numbered prompts as the readable source of workflow execution.

### Supplemental QA Workflows

| Workflow | Purpose |
| --- | --- |
| `[WORKFLOW] Legacy Baseline Evidence` | Recovery-only baseline refresh after the dedicated Discovery QA workflows have already run. |
| `[WORKFLOW] Modern Build Planned QA Tests` | Helper workflow used inside step-specific modern QA flows when the current step owns executable suite creation or refresh. |
| `[WORKFLOW] Modern Runtime Smoke` | Helper workflow used inside step-specific modern QA flows when runtime wiring, route availability, startup, or browser-to-API connectivity changed. |
| `[WORKFLOW] Validate Current Slice` | Helper workflow used inside step-specific modern QA flows when the gate needs the smallest focused slice proof. |
| `[WORKFLOW] Validate Modernization Milestone` | Helper workflow used inside step-specific modern QA flows when the gate needs broader milestone confidence. |
| `QA Test Hub` | Router used to select the named workflow mapped to the step that just completed. |

## Required Evidence Pack

When the full modernization flow is complete, the evidence in `.modernization/` should include at minimum:

- `ignition-artifacts/discovery/review-manifest.json`
- `ignition-artifacts/generated/parity-report.generated.json`
- `ignition-artifacts/generated/frontend-parity-status.generated.json` when `browserSurfaceApplicability` is `Required`
- `ignition-artifacts/modernize/fusion-restructure/visual-parity-report.json` when `browserSurfaceApplicability` is `Required` (the Step 13 visual-parity gate output)
- `reports/Legacy-System-Analysis-Report.*`
- `reports/Manifest-Coverage-Report.*`
- `reports/Current-State-Classification-Report.*`
- `reports/Enterprise-Target-State-Report.*`
- `reports/App-Target-Delta-Report.*`
- `reports/Modernization-Distance-Assessment.*`
- `reports/Lane-Recommendation-Report.*`
- `reports/Modernization-Solution-Design.*`
- `reports/Gap-and-Exception-Register.*`
- `reports/Parity-and-Proof-Status-Report.*`
- `reports/Leadership-Summary.*`

## Relationship To Other Files

- Use `/.github/instructions/AppMod-Step-Contract.json` for the machine-readable step, owner, and QA mappings consumed by agents.
- Use `/.modernization/portal/data/json/step-workflow-state.json` as the runtime artifact that records the last executed step, the last completed step when applicable, the recommended next step, and the latest full response history.
- Every numbered step should update `step-workflow-state.json` and regenerate `/.modernization/.readme/.StepSummary.md` once the step-owned work and QA handoff are truthfully complete.
- Use `/.modernization/.readme/kit-params.md` for app-specific identity and deployment values.
- Use `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` for the baseline and final acceptance-criteria view used during readiness and review.

## Known Current-State Note

This sequence is the readable modernization authority. Keep it aligned with `/.github/instructions/AppMod-Step-Contract.json` and the named QA workflow catalog instead of maintaining duplicate routing tables in multiple files.
