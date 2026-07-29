---
name: appmod-phase-agent-contract
description: Shared critical rules and chat contract for the numbered phase agents that coordinate Discovery, Modernize, and Review steps.
applyTo: ".github/agents/OpX-AppMod-P1-Discovery.agent.md,.github/agents/OpX-AppMod-P2-Modernize.agent.md,.github/agents/OpX-AppMod-P3-Review.agent.md"
---

# App Mod Phase Agent Contract

Use this file as the shared contract for the numbered phase coordinators.

## Precedence

- When this contract and `/.github/instructions/appmod-agent-personality-baseline.instructions.md` both apply to a phase agent, this contract wins for chat shape, QA routing, numbered-step execution behavior, and state persistence rules.

## Shared Critical Rules

1. Do not create new scripts. All scripts already exist in `.github/scripts/`.
2. Do not create scanners. Compliance review is handled by the code-review lane using the current review contract and evidence-backed findings, not ad hoc regex tooling or guess-based spot checks.
3. Do not create temporary scan artifacts, `_debug` files, `_bak` files, or disposable automation files.
4. Do not generate extra files outside source changes, test files, configuration files, and outputs in `.modernization/`.
5. Run the narrowest relevant proof after every change.
6. Keep generated modernization code readable, direct, and senior-developer maintainable.
7. Follow `/.github/instructions/agent-toolkit-protection.instructions.md` for protected toolkit boundaries and the `Ultimate-Ignition-edit` routing rule.
8. Treat `/.github/instructions/AppMod-Step-Contract.json` as the routing authority and `/.github/instructions/AppMod-Process.instructions.md` as the human-readable phase authority.
9. Keep the phase agents as thin routers. Step-owned execution details, self-heal rules, and completion gates belong in the numbered prompts, QA prompts, and scripts.
10. Treat `Modernization Quality Design (Step 6)` as the required Discovery completion gate before Step 7 backend execution begins.
11. Prefer the smallest trustworthy evidence set that can decide the current step: the numbered prompt, the step contract, the saved numbered-step state, and the nearest owning artifact family. Do not reopen broad repo exploration when those surfaces already control the next action.
12. Do not invent routes, ownership, blockers, completion, or next steps from memory. If current evidence is missing, stale, contradictory, or semantically hollow, refresh the controlling artifact or return `Blocked` with the exact missing proof.
13. Do not create or rely on a parallel retired Fusion-only state tracker when the numbered flow already owns state in `.modernization/portal/data/json/step-workflow-state.json`.
14. For Phase 2 modernization steps, a user may explicitly rerun a step that is already marked complete. Treat that rerun as an optimization pass: preserve the fact that the required gate is already satisfied, but continue closing the highest-value remaining measurable gaps toward 100 when truthfully possible.
15. **Explicit step invocation = full fresh execution.** When the user invokes a numbered-step prompt or handoff directly (by running the numbered prompt, clicking the agent handoff button, or typing an explicit step request such as "run Step 5" or "rerun Step 12"), always execute the full step work from scratch, regardless of completion status. This includes running scripts, regenerating reports, re-scanning code, and redetecting gaps. The user may have added new code, changed the environment, or be deliberately hunting for what you missed. Never substitute a "validation-only reconciliation" or skip substantive work because the step is already marked Completed. Treat explicit invocations as "find and close every remaining gap" mode, not "confirm existing evidence is still valid" mode.
16. Every returned portal URL, HTML report URL, and runtime URL must be a real clickable Markdown link when a valid target exists.
17. When a numbered step needs user input, a URL, a confirmation, or a numeric shortcut response, acknowledge the accepted input immediately and say what action starts next. Do not leave the user guessing whether the reply was accepted.
18. During builds, package installs, repo hydration, runtime startup, browser automation, or other long-running work that can exceed a few minutes, return short progress updates at least every few minutes. Name the current substep, whether output is still advancing, and what the step is waiting on when there is no fresh output.
19. If a numbered step cannot continue after the supported retries or waiting window, say so plainly in chat and return the blocker instead of remaining silent while the terminal appears active.

20. **Evidence Contract (anti-hallucination).** Never claim a file was changed, a command ran, a test passed, a report refreshed, an inventory populated, a screenshot was captured, a component was swapped, an endpoint connected, an auth flow validated, or any other concrete action without one of these proofs attached in chat or in the linked artifact: (a) the file path plus the exact line range that proves the change; (b) the exact command and its actual exit code from the most recent run; (c) the artifact path plus its current `lastUpdatedUtc` or file mtime; (d) the screenshot path that was actually produced. Forbidden without evidence: "I verified", "I tested", "I ran", "I confirmed", "should now work", "is complete", "is wired", "is fully covered". When evidence cannot be produced, state `UnverifiedClaim` and stop the affected substep instead of paraphrasing intent as outcome.
21. **Self-check before reporting Completed.** Before any numbered-step response moves a step to `Completed` (or any reused-language equivalent), re-read the artifact that proves completion and capture the proof inline. For code edits this means re-reading the edited file region. For tests this means rerunning the narrowest proof and capturing the exit code. For inventories this means reading the current row count and at least one randomly selected row back. A step that cannot produce the self-check proof must return `Blocked` or `Partial`, never `Completed`.
22. **Modernization Progress Metric (mandatory).** Every numbered-step response in Phase 2 (Step 9 through Step 20) must include concrete counts and percentages so the user can see how much is done, how much remains, and how much is total without asking. Use the contract defined in ### Modernization Progress Metric below. Discovery steps (Step 5 through Step 8) must populate the underlying totals so Phase 2 has real denominators to report against.

## Shared Phase Discipline

Use this as the phase-ownership source of truth for the numbered phase agents:

- **Discovery (Steps 1 through 6) owns planning and derivation.** Discovery captures inventories, behavior truth, traceability seams, and executable planning rules that later phases consume.
- **Modernize (Steps 7 through 18) is execution against the Discovery plan.** Do not derive new scenarios from legacy code in Phase 2. Execute the catalog and decision artifacts produced by Discovery.
- **Review (Steps 19 through 24) is verification and disposition.** Do not hide missing planning by inventing new derivation in Phase 3.
- **Mandatory upstream loop:** When Phase 2 or Phase 3 finds a missing plan item, stop the active step, report the concrete gap, and route upstream to the owning Discovery step:
  - Route to Step 3 or Step 4 when the missing item is missing source truth, inventory evidence, or baseline criterion evidence.
  - Route to Step 5 or Step 6 when the missing item is a planning, catalog, ownership, or QA-design derivation gap.
- Keep analytical language and derivation heuristics out of Phase 2 and Phase 3 prompts; keep those prompts execution- and verification-focused.
## Shared Chat Contract

For each numbered phase step:

1. Only do a live runtime continuity check when the user explicitly asks for build or run proof, the mapped QA workflow requires a running app, or current evidence says the dependent runtime is down. Do not start or probe the Angular client as a default numbered-step preflight.
2. Before the handoff work starts, say what is about to run in very simple terms.
3. That pre-run update should include three short plain-language bullets in this order: `Context`, `Dev work`, and `QA plan`.
4. Run the handoff work.
5. End with a clear `Step Status` section instead of a generic completion heading.
6. For long-running work, keep the user informed with short progress updates until the step completes or blocks.
7. Return the concrete modernization delta for the active pass.
8. Return the requested result data.
9. Ask for the short change summary only when the active pass actually changed repo files.
10. Run the exact mapped QA workflow at the timing required by `/.github/instructions/AppMod-Step-Contract.json`. For `InLoopCheckpoint` steps, keep QA inside the active numbered-step loop at meaningful checkpoints, blockers, and closeout proof refreshes instead of presenting it as a separate lane that only starts after all dev work stops.
11. Summarize QA in one compact section that says what ran, what it validated, and any remaining blocker. Do not include a portal-publication line; portal refresh is manual-only and is not part of QA closeout for any numbered step.
12. For Discovery steps 1 through 6, if the user includes the exact phrase `No QA` in the numbered-step request, skip the mapped QA workflow for that run, say QA was skipped by operator request, and point to the matching manual `@xQA` prompt.
13. Keep the workflow-state snapshot explicit so the user can see the recommended next step without hunting for it.
14. Return numeric shortcut `1` only when the lane contract expects it and it materially helps the user act from the current reply.
15. Keep numbered-step replies readable in about 60 seconds for a typical operator. Prefer short bullets or a compact table, omit empty headings, and do not repeat the same next-step information in multiple sections.
16. Always return the full required chat shape for numbered-step responses, even when the user asks a short status question.

### Modernization Delta Rule

- Insert a `Modernization Added` section immediately before `Returned Data`.
- For active modernization work, list the exact concrete delta created, moved, wired, hardened, or validated in that pass.
- Prefer flat bullets that name the changed surface explicitly, such as controllers, routes, views, pages, UI components, APIs, tables, tests, selectors, configuration seams, or integrations.
- Use user-facing wording first, then include the concrete technical surface when helpful.
- If no new modernization surface was added and the step is review-only, say `No new modernization surface added in this pass.`

### Short-Question Handling Rule

- If the user asks a brief follow-up such as "did it complete?" after a numbered step run, do not return a short-form yes/no response.
- Return the complete required chat shape and include the completion verdict inside `Step Status` and `Returned Data`.

### Step Response Ledger Contract

- Persist the latest full numbered-step response inside `.modernization/portal/data/json/step-workflow-state.json`.
- Keep one latest record per numbered step.
- Each step entry should include:
  - step number
  - step label
  - status
  - updated timestamp
  - latest full response text
  - optional source context or evidence link
- Treat this ledger as report data so the portal can show each step and its latest full response.

### Step Execution State Contract

- Persist the current numbered-step state to `.modernization/portal/data/json/step-workflow-state.json`.
- Update it after every numbered step run, even when the step remains blocked or the next recommended step stays on the same numbered prompt.
- After persisting state, run `.github/scripts/shared/Invoke-StepReconciliation.ps1 -Step <N>` so `.modernization/.readme/.StepSummary.md` is regenerated from the saved state for every completed numbered step.
- Read back the regenerated Step Summary and confirm it reflects the current step instead of appending a duplicate historical block.
- Treat the numbered-step ledger and workflow-state artifacts as the authoritative active workflow state. When an optional helper lane, compatibility mirror, or stale generated artifact disagrees, refresh the numbered-step artifacts and follow them.
- Keep these top-level facts current:
  - updated timestamp
  - last executed step
  - last completed step when the current step actually completed
  - recommended next step
  - decision basis explaining why that next step is still correct
- Treat this state file as the numbered-workflow state artifact used by the active step-entry prompts.
- Phase agents should enforce this contract for the numbered prompts they route even when the prompt body does not restate the generic state-update bullets.
- Keep prompt-local state text only for true step-specific delta behavior.

### Modernization Progress Metric

- Every Phase 2 numbered-step response must include a `Modernization Progress` section with concrete counts and a percentage in the form `done / remaining / total (percent%)` for at least:
  - `backend.movedFiles` — count of legacy files moved into the target architecture vs Step 7 `Planned-File-Inventory` total.
  - `backend.endpointsHardened` — count of endpoints wired in `Web.Api` with auth, error envelope, and contract test vs Step 5 `apiEndpointCatalog` total.
  - `frontend.routesMigrated` — count of routes rebuilt vs Step 5 inventory total.
  - `frontend.componentsClassified` — count of components carrying full Step 5 `uiControlClassification` vs `componentCensus.totalComponents`.
  - `frontend.componentsMigrated` — count of components with `migrationEligible: true` actually swapped to a Fusion primitive vs total `migrationEligible: true`.
  - `frontend.subPatternsClosed` — count of sub-patterns whose `expectedPassCount` was reached vs total sub-patterns from `ui-migration-order.json`.
  - `frontend.screenshotsCaptured` — count of required capture states actually captured vs `screenshotCoverageMatrix` total.
  - `frontend.fusionPrimitiveCoverage` — count of `requiresWrapperCapability` entries with an MCP-verified Fusion primitive bound vs total.
  - `tests.pomCoverage` — count of routes with a `{Route}Page.ts` POM vs total routes.
  - `tests.gherkinCoverage` — count of user-facing features with a feature file vs total features.
  - `tests.ariaCoverage` — interactive controls with `aria-label` or `aria-labelledby` vs total interactive controls.
  - `tests.testIdCoverage` — testable controls with `data-testid` vs total testable controls.
  - `tests.backendUnitCoveragePercent` — current line-coverage percent on `Library` business logic vs the > 80 target.
- Also include three rollups:
  - `Phase 2 overall`: weighted average of the rows above, expressed as `done / remaining / total (percent%)`.
  - `Current step`: percent of this step's own exit-criteria items satisfied with evidence vs total exit-criteria items.
  - `Trend since last run`: per-row delta vs the previous step-response ledger entry, expressed as `+N` or `-N`.
- Source the underlying totals from these artifacts in order: `.modernization/portal/data/json/step-workflow-state.json` for current state, `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` and `ui-fusion-map.json` for component and route totals, `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` for endpoint and wrapper totals, `.modernization/portal/data/json/qa-test-plan.json` and `executable-testcase-catalog.json` for test totals.
- Persist the populated metric block into `step-workflow-state.json` under `modernizationProgress` so `Trend since last run` can be computed without rescanning the repo.
- For Discovery steps (Step 5 through Step 8), the obligation is to populate or refresh the denominators (`totalComponents`, `totalRoutes`, `totalEndpoints`, `totalSubPatterns`, `totalRequiredScreenshots`, `totalRequiredCaptures`, `totalRequiredAuthClaims`, etc.) so Phase 2 percentages compute against real totals.
### Required Chat Shape

- `Step Status`
- `Modernization Added`
- `Modernization Progress`
- `Returned Data`
- `QA Summary`
- `Step Execution State`

Use these optional sections only when they add real value for the current pass:

- `Evidence Links`
- `Change Summary Needed`
- `Reply Shortcut`

### Evidence Links Rule

- When `Evidence Links` is present, prefer durable proof artifacts, current state artifacts, runtime URLs, HTML report pages, or other user-meaningful evidence surfaces.
- Do not include internal toolkit implementation files such as `qa-refresh-portal.ps1` as end-user evidence links unless the script itself is the thing being debugged, changed, or named as the blocker.
- When portal publication is disabled, prefer the source-of-truth JSON or step-state artifact over the portal publication script path.
- Keep evidence links short and relevant. One or two strong links are better than a long implementation-heavy list.
### Quality Portal Rule

- The Quality Portal under .modernization/portal/ is manual-only. No numbered step, helper lane, agent, or QA workflow may auto-run qa-refresh-portal.ps1, qa-report-portal.prompt.md, or any other portal republish flow, regardless of the OPX_ENABLE_QA_PORTAL_REFRESH shell flag.
- Numbered steps must complete from source artifacts (step ledger, step-workflow-state, fusion-restructure JSON, runtime-comparison JSON, live code and tests) and must never block on, wait for, or require a portal page refresh.
- When source artifacts are newer than the matching portal page, complete the step from source truth and report the staleness in chat with the name of the stale portal surface, the name of the newer source artifact, and a one-line note that portal refresh is a manual user action.
- Do not refresh the portal yourself to fix staleness. Reporting it in chat is the fix from the numbered-step side.
- See /.github/instructions/qa-portal-reporting.instructions.md for the canonical rule.


## Usage Notes

- Keep phase-agent bodies focused on phase-specific rules, QA maps, and exceptions.
- Do not duplicate the full per-step QA routing table from `/.github/instructions/AppMod-Step-Contract.json` inside phase-agent bodies. Keep the contract as the routing source of truth and restate only true phase-specific exceptions that help the reader.
- Put shared rules here instead of repeating them across P1, P2, and P3.
- If one phase truly needs stronger requirements than the others, add only the delta in that phase agent.



