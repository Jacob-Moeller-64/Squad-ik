# Ignition Kit import (photo transcriptions)

Prompts from the OpX-Ignition-Kit, transcribed from screen photographs supplied by the
kit owner (work-machine transfer restrictions prevent direct file transfer). Content is
reconstructed faithfully; per-file transcription uncertainties are listed below.
No credentials appear in these files (env-var *names* like SONATYPE_USERNAME are
references, not values).

## Index

| File | Phase/Step | Status |
|---|---|---|
| `prompts/01-P1-workstation-readiness.prompt.md` | P1 Discovery, Step 1 | transcribed from 2 photos |
| `prompts/02-P1-rename-starter-to-appname.prompt.md` | P1 Discovery, Step 2 | transcribed from 3 photos |
| `prompts/03-P1-legacy-system-analysis.prompt.md` | P1 Discovery, Step 3 | transcribed from 6 photos |
| `prompts/04-P1-baseline-acceptance-criteria-review.prompt.md` | P1 Discovery, Step 4 | transcribed from 4 photos |
| `prompts/05-P1-modernization-solution-design.prompt.md` | P1 Discovery, Step 5 | transcribed from 7 photos; 2 values redacted (see below) |
| `prompts/06-P1-modernization-quality-design.prompt.md` | P1 Discovery, Step 6 | transcribed from 13 photos |
| `prompts/07-P2-backend-upgrade-dotnet.prompt.md` | P2 Modernize, Step 7 DEV | transcribed from 7 photos |
| `prompts/08-P2-backend-modernization-formation.prompt.md` | P2 Modernize, Step 8 DEV | transcribed from 11 photos |
| `prompts/09-P2-backend-dotnet-integration-hardening.prompt.md` | P2 Modernize, Step 9 DEV | transcribed from 4 photos |
| `prompts/10-P2-frontend-foundation-and-scaffold.prompt.md` | P2 Modernize, Step 10 DEV | transcribed from 8 photos |
| `prompts/11-P2-frontend-migration.prompt.md` | P2 Modernize, Step 11 DEV | transcribed from 4 photos |
| `prompts/12-P2-frontend-platform-integration.prompt.md` | P2 Modernize, Step 12 DEV | transcribed from 9 photos |
| `prompts/13-P2-frontend-shell-stabilization.prompt.md` | P2 Modernize, Step 13 DEV | transcribed from 5 photos |

## Structural facts about the Ignition Kit learned from transcription

- Prompts are **VS Code Copilot prompt files** (`.github/prompts/NN-Px-name.prompt.md`)
  with frontmatter: description, name, argument-hint, **agent** (per-phase custom agents,
  e.g. `OpX-AppMod-P1-Discovery`), and a tools allowlist.
- Steps carry **per-prompt model-tier recommendations** ("Light (low thinking)") and
  estimated run times.
- The kit already has **artifact gates**: `.github/scripts/shared/verify-step-artifacts.ps1
  -Step N -Mode Input|Output` with `RESULT: OK` (exit 0) / `RESULT: BLOCKED` (exit 2) —
  input prechecks and output verification per step.
- **Step registry**: `/.github/instructions/step-registry.json` maps opaque step ids
  (e.g. `step:1fc2ba`) to human labels; prompts reference next steps by id.
- **State tracking**: `step-workflow-state.json` with a mandated human-readable readback
  block (Updated At / Recorded Step / Recommended Next Step).
- Conventions: legacy app copied to `LegacyCode/`; target is `src/<AppName>.Web.Api`
  (dotnet, **Scalar at https://localhost:4200/scalar**) + `src/<AppName>.Web.Client`
  (npm, https://localhost:5001). Docs under `/.modernization/.readme/`
  (Prerequisites.md, HowToRun.md). Package source: Sonatype (env creds + .npmrc/NuGet
  source checks). "Fusion G1" identifies a legacy Fusion generation.

## Structural facts added by prompt 02

- **The real Fusion Starter Kit layout** (corrects the reference kit's assumed
  `src/{Library,API,Client}`): `src/<App>.Library`, `src/<App>.Web.Api`,
  `src/<App>.Web.Client` — PascalCase backend naming, client as an `.esproj`
  (JS project system), scaffolded from `Starter.*` templates that Step 2 relabels.
- **Client baseline policy**: Angular even-major baseline, currently **Angular 20**.
- **Fusion specifics**: `AppInfo.xml` per project; `appsettings.json` Fusion keys
  (`Fusion.DataDirectory.PathBase`, `Fusion.Web.Api.OpenApi.Title`,
  `Fusion.Web.Client.Config.ApplicationName`); `<fusion-header label>` component;
  per-environment `fusion.config.*.ts` (e.g. `.dvl`) carrying Fusion OAuth hostnames
  that MUST NOT change during identity rename (later auth step owns them).
- **Run params**: `/.modernization/.readme/kit-params.md` holds `appName`;
  `.StepSummary.md` is a per-run human-readable step log; toolkit self-edits governed
  by `/.github/instructions/kit-update.instructions.md`.
- **Dual-surface completion model** (step 2): `physicalRenameStatus` +
  `referenceRewriteStatus` must both pass or the step reports `Blocked` — a
  two-column done-definition, not a single flag.
- Step ids observed: `step:1fc2ba`, `step:261769`.

## Structural facts added by prompt 03

- **Per-prompt model pins in frontmatter**: Step 3 carries `model: Claude Opus 4.6 (copilot)`
  directly in the prompt-file frontmatter — the kit pins specific models per step, not just
  tier hints in prose. (Step 3's prose tier is "Premium reasoning (high thinking)", 20-40 min.)
- **Schema contract versioning**: `step3ArtifactSchemaContractVersion: 1.0.1` in the prompt
  must match `.github/skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`
  — schemas are versioned artifacts owned by a *skill folder*, and prompts only keep an
  inline "minimum field floor". The kit has `.github/skills/` (screenshot-capture with
  SKILL.md + scripts/, step3-legacy-system-analysis with references/).
- **Hard Stops pattern**: numbered STOP gates inside the prompt (STOP 1 live-QA-URL
  resolution with exact priority order currentQaUrl → currentDevUrl → ask in chat → halt,
  plus a mandatory `qaUrlSource` echo; STOP 2 preflight limited to step-owned inputs, with
  non-step dependencies reported as "contract drift blockers"; STOP 2.5 modality branch;
  STOP 3 artifact completeness). STOP 2.5 classifies `detectedModality` as
  `api-only|mvc|spa|hybrid` from deterministic file-evidence criteria and everything
  downstream (artifact requiredness, response sections) branches on it.
- **Portal report system**: `.modernization/portal/data/json/` holds 9 named JSON reports
  (legacy-system-analysis, manifest-coverage, current-state-classification,
  runtime-topology, integration-contract-catalog, environment-and-secrets-map,
  data-and-cutover-risk, gap-and-exception-register, leadership-summary) seeded as
  skeletons by scripts and *enriched* by the agent; screenshots live under
  `.modernization/portal/data/images/<page>/`; portal publication is manual-only and
  never part of the done-definition. State files `step-workflow-state.json` and
  `step-response-ledger.json` also live under portal data and are written gate-authoritatively.
- **Ignition artifact layout**: structured analysis artifacts live in
  `.modernization/ignition-artifacts/discovery/` (service-behavior-inventory,
  interaction-wiring-inventory, workflow-trace-inventory) and
  `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json`
  (apiEndpointCatalog, uiControlClassification, fusionPrimitiveCoverageCensus fields).
  Every entry must carry `legacyEvidence` with a real file path + line range; no
  fabricated placeholder rows.
- **Modality applicability matrix**: a Required/Conditional/notApplicable grid per
  artifact × modality feeds STOP 3; `notApplicable` artifacts must still exist with an
  explicit `{notApplicable: true, reason}` marker — absence is never a valid encoding.
- **Screenshot progression rule**: partial capture may proceed only with (1) ≥1 image,
  (2) explicit user review, (3) explicit user approval; zero images + none user-provided
  = blocked. User evidence goes under `.modernization/.readme/user-provided-info/` and is
  referenced as `captured-user-provided` matrix rows.
- **Legacy Visual Contract Capture**: Step 3 extracts a `legacyVisualContract` block
  (palette, typography, shellChromeRegions, navRouteModel, controlAndLabelRules, per-route
  field sets with `headerLabel`+`boundField`) in two layers — static (always, from source)
  and runtime (Playwright computed styles + per-route reference screenshots when the app
  is reachable; `runtimeMeasured: false` marker when not). Step 5 consolidates it into
  `.modernization/fusion-restructure/styling-foundation.json` + `ui-visual-contract.json`;
  Step 13 uses it as the field-parity/visual-parity answer key ("column-collapse parity
  defect" is a named failure class).
- **Deterministic response shape**: 10 exact response headings in fixed order with
  placeholder vocabulary (`NotApplicable`/`NoneDetected`/`Blocked`), mandatory counts
  (`cannotLocateCount`, `unknownBacklogCount`, `blockedArtifactCount`), and a fixed
  closing sentence for the readiness decision — response format is contract, not style.
- **Gate statuses**: the step gate yields three axes (`scanCoverageStatus`,
  `traceabilityStatus`, `planningReadinessStatus`), each `Ready|Constrained|Blocked`;
  `Constrained` still allows planning to proceed, `Blocked` stops Step 4.
- **Governing Sources section**: prompts end by delegating policy to canonical
  `.github/instructions/*.instructions.md` files (AppMod-Process,
  ui-capture-reverse-engineering, testing-design-contract, fusion-restructure,
  qa-portal-reporting, appmod-phase-agent-contract) + `.github/skills/*/SKILL.md` —
  "do not re-derive the rules here".
- **Config/deployment conventions**: `connectionStringRuntimeInput` in kit-params.md;
  `OCPEnv` is the default final-state mode (alternatives `OpX`, `LocalIntegrated`/`OpEx`);
  default split SQL env var names `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`
  for the OpenShift/Kubernetes final state; Dapper row-model type hints
  (`dbParameterTypeHints[]`, `dbResultColumnTypeHints[]`) captured at discovery for
  Steps 8-9.

## Structural facts added by prompt 13

- **The last shell-level gate before UI planning** (same agent + browser tools; Balanced
  tier, 10-25 min). Owns visual, layout, navigation, and responsive parity of the
  stabilized shell. Four status axes: `shellParityStatus` (Stable|Drifting|Blocked),
  `shellGuardStatus` (Aligned|Stale|Blocked), `fieldParityStatus`
  (Reconciled|Drifting|Blocked), `step14HandoffStatus`
  (ReadyForUIPlanning|NotReadyForUIPlanning|Blocked).
- **"Regression guard, not re-derivation"** — the cleanest ownership statement in the kit:
  Step 13 CONSUMES Step 11's control/column verdict and Step 12's live-data verdict. If a
  dropped column or unfilled grid shows up here, it is "a **Step 11/12 regression** to
  route back to its owner and fix at the source, **not new Step 13 work**." Same for the
  styling foundation (Step 10). Three adjacent steps, three non-overlapping jobs, with the
  routing rule stated explicitly.
- **Visual Parity Gate** (`/.github/skills/visual-parity-gate/SKILL.md`) — composes the
  runtime-parity-checkpoint and screenshot-capture skills, **boots the modern app AND the
  legacy app on a second port when runnable**, captures matching routes, and diffs
  computed styles + screenshots against `ui-visual-contract.json` +
  `styling-foundation.json`. Per-route `pass`/`partial`/`fail` across palette, typography,
  header/nav/footer presence, nav route model, layout density. `overall: pass` only when
  every route passes or every non-pass route is in `acceptedResidualGaps[]` with a real
  reason and owner — "do not silently downgrade a `fail` route to an accepted gap."
- **Field & Control Parity Reconciliation Gate** — side-by-side comparison in the
  integrated browser, booting the modern app and the runnable legacy app
  (`LegacyCode_NETXX_Upgrade` when the original `LegacyCode/` host is not runnable) on
  separate ports, comparing "column-for-column and control-for-control". Records
  `fieldParity` roll-up plus `columnsMissing[]` / `inertControls[]` per route.
- **Two behavioral gates carried from Step 12's assertion families** now as binary
  completion gates: `filterEffectParity = pass` ("a filter that does nothing is a
  `filterEffect: fail` regardless of whether the API call returns 200") and
  `siblingListDistinctnessOverall = pass` (two tab/accordion sections showing identical
  rows "indicate a wrong discriminator or shared endpoint bug").
- **Responsive Breakpoint Parity Gate (MANDATORY)** — new dimension: capture every route
  at 375/768/1440 (overridable via `responsive-breakpoints.json`), emit
  `responsive-parity/<routeId>.json` with `breakpointPx`, legacy/modern screenshot paths,
  `pixelDiffPercent`, `layoutShifts[]`, `overflowEvents[]`, `horizontalScrollDetected`,
  `parityState` (pass|warn|fail). Legacy breakpoints reverse-engineered from
  `componentCensus` media-query evidence and "may add to (not replace) the default trio."
- **Self-Audit Checklist (MANDATORY)** — a genuinely new pattern: before closeout the
  agent must emit a self-attestation block answering every checklist row with `YES` + a
  one-line evidence pointer (file path, test id, command output line, artifact field),
  `NO` + deferral rationale + a carry-forward entry, or `N/A` + rationale. Nine rows
  covering artifact reads, style entry points, framework class-hook resolution, shell
  a11y, shell POM extraction, Gherkin scenarios, visual-regression baseline commit,
  layout/breakpoint/z-index audit, and temporary-UI-bridge classification with
  `retirementStep`. Backed by an **Agent Contract Rule (HARD GATE)** that invalidates the
  ready status when any row is `NO` without both artifacts.
- **Shell accessibility mandate** with a sharp anti-false-green clause: the `<nav>`
  landmark must render every link in the route menu metadata and each must navigate — "a
  present-but-empty `<nav>` landmark (the element and its test id exist but no links
  render) passes the landmark check yet is a navigation parity defect."
- **Unbacked framework class hooks** restated as a shell-level check (Bootstrap
  `nav-tabs`/`panel`/`dropdown`/`btn-*`/`col-*`): they "render as bare DOM (bullet lists
  where tabs are expected, always-open dropdowns, stacked blocks where grid columns are
  expected) and silently defeat visual parity."
- **Closing menu**: QA twin `13-QA-frontend-shell-stabilization` (Lanes: Browser-contract
  regression, Navigation smoke; ETA 3-5 min) / `next` → Step 14 DEV / `stop`. Step 14's
  name confirmed: "Frontend UI Inventory & Fusion Map".

## ⚠ Cross-step numbering drift found in prompt 13 (HIGH fork-risk — same class as prompt 12)

Transcribed **as photographed**, not corrected. This is the second prompt in a row with
renumbering drift, which makes it a systemic pattern rather than a one-off:

- **The Self-Audit `Agent Contract Rule (HARD GATE)` references a status field the prompt
  never defines.** The prompt declares `step14HandoffStatus`, but the hard gate says
  "`step16HandoffStatus: ReadyForUIPlanning` is INVALID when…", "an explicit **Step 16**
  carry-forward entry", and "the agent MUST downgrade **`step16HandoffStatus`** to
  `NotReadyForUIPlanning`". An agent following this literally must either error or invent
  a field.
- **The Self-Audit section contradicts itself on its own block name.** Its opening line
  requires "a `Step 13 Self-Audit` block in the chat reply"; its closing line requires
  "the literal **`Step 15 Self-Audit`** heading… A closeout without this block is treated
  as a skipped **Step 15** and must be re-run." Both cannot be satisfied.
- **The Responsive Breakpoint Parity Gate is written against Step 15**: "every **Step 15**
  stabilized route", "`fail` at any breakpoint blocks **Step 15** closeout", "a documented
  variance row in the **Step 15** stabilization report" — inside the Step 13 prompt.
- **Mixed carry-forward targets**: the Self-Audit `NO` branch says "a **Step 14**
  carry-forward entry" while checklist row 8 says "**Step 17** carry-forward" and the hard
  gate says "**Step 16** carry-forward".
- Path divergence for the same artifacts: the Required-behavior section reads them from
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` while the checklist
  and the runtime/visual gates write to `.modernization/fusion-restructure/…`.

Combined with prompt 12's 9 × "Step 14" references, this strongly suggests the frontend
block was renumbered (platform integration 14→12, stabilization 15→13, and the UI
inventory/upgrade lanes shifted with it) without the prompt bodies being updated. Every
one of these is a fork point where different developers' models will resolve the
contradiction differently, and the `-CurrentStep <n>` drain gates depend on step numbers
being literal.

## Transcription uncertainties (prompt 13)

- The drift references above are transcribed exactly as photographed and are the highest
  priority items to re-read against the source before acting.
- Window title reads `IgnitionKit1.2` (as in prompt 12's later photos) while the
  breadcrumb still reads `OpX-Ignition-Kit`.
- Double-backtick identifier styling in the Responsive Breakpoint Parity Gate preserved as
  shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  53-59, 105-110, 154-161, and 177-192.
- File ends at line 220.

## Structural facts added by prompt 12

- **The authoritative live-data + auth gate of record** for the whole app (same
  `OpX-AppMod-P2-Modernize` agent + browser tools; Premium reasoning *medium-high*
  thinking, 15-30 min). Steps 11 and 13 explicitly defer to it.
- **The two-verdict model** — the kit's strongest anti-false-green design:
  - `routeContractStatus` = the deterministic, **auth-free GATE OF RECORD** from
    `generate-ui-api-map.ps1 -FailOnBrokenCalls`. Proves every client call resolves to a
    real controller action+verb with no credentials. `brokenCallCount = 0` → `Clean`
    (required to close); `> 0` → `BrokenCalls` (closure-blocking, "a guaranteed runtime
    failure"); method-built/dynamic URLs → `UnresolvedOnly` (advisory).
  - `liveDataRenderStatus` = the authenticated render confirmation, **"never faked"**.
    `Verified` only when a route is *observed* rendering real rows under a real session.
    Explicitly NOT `Verified`: a `401`, a scanner result, a `200`, or a carried-forward
    prior observation. No usable auth session → `UnverifiedPendingAuth` (honest Partial),
    "never infer `live` from a protected `401`."
  - **Closure requires `Clean` AND `Verified`.** `Clean` + `UnverifiedPendingAuth` keeps
    the step Partial. Canonical render path: operator completes the real sign-in in the
    shared integrated-browser page, then each route's live render is observed.
- **Five status axes total**: the two above plus `protectedApiOwnershipStatus`
  (Aligned|DriftDetected|Blocked), `authRuntimeStatus` (Verified|403GapOpen|Blocked),
  `perRouteApiWiringStatus` (LiveAllInScope|PartialPerRouteList|Blocked — `LiveAllInScope`
  only when `liveDataRenderStatus: Verified`).
- **Two more MANDATORY self-check scanners** (now 6 total on this step):
  `scan-backend-parity.ps1` (dropped-mutation detection — "the UI still shows
  Add/Edit/Delete buttons over placeholder modals while no backend endpoint exists";
  waivers in `backend-parity-registry.json` `acceptedDrops[]`) and
  **`scan-functional-parity-ledger.ps1`** — new: answers "are ALL legacy behaviors
  implemented?" across Step 3 `effectClass` (mutate/filter/navigate/export/dialog), not
  just endpoints and fields. Catches "missing buttons, dead filters, or filter controls
  that show identical rows before and after applying"; waivers in
  `functional-parity-registry.json`.
- **Runtime-checkpoint assertion families** (new, behavioral not structural):
  `filterAssertions[]` must show `rowsChanged: true` per filter control (identical rows
  before/after = `filterEffect: fail`); `siblingListDistinctness[]` must confirm sibling
  list sections backed by separate calls return distinct first-row content;
  `mutateWiringAssertions[]` must show `networkCallObserved: true` ("a modal that opens
  but never fires a write call is a `mutateWiring: fail`").
- **Full Playwright auth infrastructure shipped inline**: `LoginPage` / `CallbackPage` /
  `UnauthorizedPage` POMs plus a 4-case `auth.journey.spec.ts` (sign-in, sign-out,
  unauthorized redirect, 403-insufficient-permissions) with `STEP12-E2E-AUTH-00N` CaseIds
  in JSDoc and Given/When/Then comments. Explicit rule: **"NO .feature files"** — all
  scenarios live inline as comments, no step definitions. (Note this contradicts Step 6's
  Gherkin `.feature`-per-journey planning; see uncertainties.)
- **Angular 20+ code-quality mandate**: standalone components with `imports: []` (no
  NgModules), signals (`signal()`/`computed()`/`effect()`), `@let`, `inject()` over
  `@Inject()`, `@if`/`@for`/`@switch`, `DestroyRef` + `takeUntilDestroyed()`. "Platform
  code with NgModules or legacy patterns is incomplete Step 12 coverage."
- **A11y & testability mandate**: `aria-label`/`aria-labelledby`, `data-testid`, `role`
  when semantic HTML is insufficient, focus management for auth flows/callbacks, error
  messages linked via `aria-describedby`.
- **API Smoke re-run before any integration work**: re-run the Step-8-planned
  `tests/backend/smoke/` probes at 100% pass against `progressDenominators.totalApiEndpoints`
  — "the cheapest signal that the backend process actually loaded the current build
  (a stale-DLL / stale-process regression …)". Honors the T1-T5 safety tiers; sub-100%
  must be a tracked `deferralId`, "not a silent skip."
- **Deferral-drain gate — "Step 12 owns 'no button is dead'"**: `scan-ui-parity-gaps.ps1
  -CurrentStep 12` re-flags any deferral whose `ownerStep <= 12` as a Major InertControl;
  `deferredInertControlCount` for Step-12-or-earlier owners must reach 0. "A
  `majorGaps = 0` with parked stubs still owed here is not a pass."
- **Per-Route HAR Diff Gate (MANDATORY)** — new proof technique: record a HAR for the same
  scripted journey against BOTH legacy and modern runtimes, diff into
  `route-har-diff/<routeId>.json` (`apiCallSequenceLegacy/Modern[]`, `extraCallsInModern`,
  `missingCallsInModern`, `reorderedCalls`, `payloadShapeDeltas`, `authHeaderDeltas`,
  byte/count totals). Any extra/missing/reordered call or auth-header drift blocks the
  route unless approved as an intentional plan delta. Journey script comes from
  `screenshotCoverageMatrix` + a new `userJourneyCatalog`, "not from hand-written per-app
  scripts."
- **Workflow Trace coverage gate (state-machine parity, not just edge parity)**: for every
  `fully-traced` row, a spec must assert (a) verb+URL, (b) payload structure matches
  `requestShape` **exactly** incl. nested-vs-flat and casing ("the most common parity
  400"), (c) response bound to documented UI surfaces, and (d) every `visibleStateLabels`
  entry appeared *and disappeared* at the correct state-machine point. "Asserting only
  that the API was called is insufficient and has shipped parity defects to users."
- **Parameterized/detail routes: "never defer"** — a detail route marked "route-verified,
  deferred to UAT because it needs a real record" hides a `404` (client calls a
  path-parameter endpoint the backend only registered as a query-string GET).
- **Runtime Error Watch**: integrated browser DevTools console + backend log stream open
  side by side; a route that "looks loaded" while the console shows a swallowed `400` or
  the backend logged a `500` is not `live`.
- **Closing menu**: QA twin `12-QA-frontend-platform-integration` (Lanes: Contract, Auth
  interceptor checks; ETA 5-8 min) / `next` → Step 13 DEV / `stop`. Step 13's name
  confirmed: "Frontend Shell Stabilization".

## ⚠ Cross-step numbering drift found in prompt 12 (HIGH fork-risk)

This is the most consequential drift found so far and is transcribed **as photographed**,
not corrected:

- **"Step 14" appears 9 times inside the Step 12 prompt** — "resolve every broken call
  before Step 14 closes", "the Step 14 hard gate is machine-enforced", "Step 14 cannot
  close while `summary.brokenCallCount > 0`", "Step 14 owns the gate that every migrated
  route's primary data calls actually reach the real protected backend", "Step 14 must
  also load `workflow-trace-inventory.json`", "Step 14 cannot close while any
  `fully-traced` row lacks a passing spec", "keep Step 14 open" (403 gap), "When Step 14
  cites current startup-proof evidence…", "For every route exercised by Step 14 platform
  integration". Meanwhile the header, ownership boundary, verdict model, completion gate,
  and closing menu all say **Step 12**.
- Companion drift in the same region: "the **Step 8** per-route behavior plan" (that
  artifact is Step 6's `per-route-behavior-plan.json`), "the **Step 13**
  `perRouteBehaviorList`" (that list is Step 11's), "`workflow-trace-inventory.json`
  (produced in **Step 5**)" (Step 3 produces it per prompt 03), "an intentional plan delta
  in **Step 7's** `apiIntegrationPlan`" (Step 5 owns `apiIntegrationPlan` per prompt 05),
  "record an explicit **Step 8** retirement decision" (retirement decisions are Step 8 in
  prompt 11's wording, so this one may be correct), and a `workflow-trace-inventory.json`
  path under `.modernization/legacy-analysis/` where prompt 03 puts it under
  `.modernization/ignition-artifacts/discovery/`.
- **Why it matters:** this reads like content authored when platform integration was
  numbered Step 14 (and analysis/planning sat at different numbers), then renumbered
  without updating the body. Every one of these is a fork point — two developers' models
  will resolve "Step 14 cannot close" differently inside a step labelled 12, and the
  `-CurrentStep` drain gates depend on step numbers being literal.

## Transcription uncertainties (prompt 12)

- The step-number references above are transcribed exactly as photographed; several are
  in heavily-wrapped lines, so the *specific* numbers in the "Step 8 per-route behavior
  plan / Step 13 perRouteBehaviorList" clause are the least legible of the set and should
  be re-read against the source before acting on them.
- The window title changes from `OpX-Ignition-Kit [Administrator]` (photos 1-5) to
  `IgnitionKit1.2` (photos 6-9) while the breadcrumb still reads `OpX-Ignition-Kit`;
  possibly a second workspace or version folder. Both photo sets agree on the overlapping
  lines 237-256, so the content is consistent.
- The Step-12 "NO .feature files" rule directly contradicts prompt 06's Gherkin planning
  (`{feature-name}.feature` per user journey, `@smoke`/`@regression` tags); preserved
  as-is in both files.
- `generate-integration-tests.ps1` writes to `tests/frontend/e2e/integration/generated/`
  in one clause and `tests/frontend/integrationFrontend/` in the next; both transcribed
  as shown.
- Double-backtick identifier styling in the HAR Diff Gate section preserved as shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  237-256, 287-301, 323-327, and 347-363.
- File ends at line 381.

## Structural facts added by prompt 11

- **The route-family move lane** (same `OpX-AppMod-P2-Modernize` agent + browser/agent/todo/
  vscodeAPI/fusion-copilot-docs tools as Step 10; Premium tier this time, 20-45 min).
  Moves the *real* legacy pages and shared client code into the target root "one route
  family at a time," explicitly NOT re-creating thinner versions from memory: "Parity is
  the starting state you preserve, not a percentage you climb toward."
- **A new self-check: content reconciliation** (`Invoke-StepReconciliation.ps1 -Step 11`)
  — proves every `LegacyRoute` in `per-route-behavior-plan.json` actually existed in the
  Step 3 legacy analysis ("a shape check cannot catch a behavior plan that invents a
  route that never existed"). Each failure prints a `Fix:` line routing back to Step 3
  (real route) or Step 6 (wrong plan). First appearance of semantic (not just structural)
  input validation.
- **A new self-check: scaffold-debt scan** (`scan-scaffold-debt.ps1 -CurrentStep 11`) —
  flags surviving "Step N wires this" markers / placeholder bodies whose owning step has
  been reached; exit 2 = overdue markers survive; a scaffold-debt registry holds
  genuinely-intentional notes. Same `-CurrentStep <n>` drain pattern as Step 10's
  `deferral-drain` dimension.
- **The single-authoritative-data-gate boundary is spelled out**: Step 11 OWNS control/
  column/field presence + wiring each data call site to its real service; it does NOT own
  the authoritative live-data verdict — that's **Step 12's single authoritative data
  gate**. A wired-but-empty grid is acceptable *provisionally*; a shipped placeholder as
  *final* state is a defect. `dataBindingParity = pass (provisional)` is a distinct gate
  value. This is the cleanest example yet of two adjacent steps deliberately NOT
  re-litigating each other's territory.
- **Move-and-preserve, NOT Fusion-conversion**: deliberate primitive-family swaps belong
  to Step 14 planning + Step 15/16 execution; an opportunistic single-control swap is
  allowed only if incidental AND reaches legacy visual parity in the same pass. "Never
  leave a half-configured Fusion control behind" — a `fusion-*` primitive with wrong
  variant/color/width is a parity defect, not progress.
- **Forbidden per-route hand-offs** (must be fixed or named as blockers): surviving
  `javascript:void(0)`/`href="#"`/`onclick="return false"` inline handlers; unwired
  legacy modal/banner/toast/confirmation triggers (incl. "authorized users only"
  banners); data-bound controls rendering placeholder/seed/fixture instead of the real
  call site; **column collapse** (real data but fewer/more-generic columns than legacy —
  "every legacy column is part of the parity contract"); export/print/upload controls
  that call no service; keyboard shortcuts/focus traps that no longer fire. Each
  unresolved one → `perRouteBehaviorList` row `{route, interactiveElement,
  dispositionInStep11, ownerStepIfDeferred}`.
- **Framework-class-hook verification**: Bootstrap `nav-tabs`/`panel`/`dropdown`/`btn-*`/
  `col-*` etc. copied from legacy templates must be backed by a stylesheet actually
  loaded in the modern shell — otherwise "bare DOM that renders as unstyled lists or
  stacked blocks." (Exactly the FieldServe-style gotcha from our rehearsals.)
- **Guard redirect-target audit**: every `canActivate` denial-redirect (e.g.
  `FusionRoleGuard(GROUPS, 'access-denied')`) must point at a *declared* route — an
  undeclared target silently falls through to the wildcard/home route and "hides the
  access-denied condition entirely." A routing-integrity defect owned here, not Step 12.
- **Parameterized/detail-route wiring**: wire every path-param route (e.g.
  `filekeys/log/:keyNo/:changeNo`) and reach it from its parent grid; Step 12 is the gate
  of record for the `404` case (client calls a path-param endpoint the backend only
  registered as a query-string GET) — a concrete route-contract failure class.
- **`deferredInertControlCount` vs `majorGaps`**: `majorGaps=0` with a nonzero deferred
  count means behavior is "PARKED, not done"; every parked handler needs a truthful
  `ownerStep` whose gate actually verifies it ("a dead export/add/delete button belongs
  to Step 12 'no button is dead', not a vague 'later'"). The `ui-deferral-registry.json`
  is the same registry Step 10's scanner reads.
- **Dead-Code Trace Gate (MANDATORY)**: static reachability sweep from the modern router
  roots (Angular `Routes` / React `createBrowserRouter` / Vue `createRouter` / Blazor
  `Router` / MVC route table / Razor Pages folders — data-driven from `componentCensus`)
  → `dead-code-trace.json` with `filePath`/`reachableFromRoot`/`rootChain[]`/`keepReason?`.
  `reachableFromRoot:false` + no `keepReason` blocks closeout (wire it, document a
  reviewer-approved keepReason, or delete). A modernization-specific dead-code gate we
  didn't have.
- **Four-axis status**: `sharedCodeMigrationStatus` (Validated|Partial|Blocked),
  `routeFamilyStatus` (Validated|Partial|Blocked), `behaviorPreservationStatus`
  (Preserved|PartialPerRouteList|Blocked), `step12HandoffStatus`
  (ReadyForPlatformIntegration|NotReadyForPlatformIntegration|Blocked). Fixed closing
  gate line: `Ready for Step 12 Frontend Platform Integration: Yes`.
- **Closing menu**: QA twin `11-QA-frontend-migration` (Lanes: Browser-contract, Visual
  parity; ETA 5-10 min) / `next` → Step 12 DEV (Frontend Platform Integration) / `stop`.
  Step 12's name confirmed: "Frontend Platform Integration".

## Transcription uncertainties (prompt 11)

- This prompt is unusually dense with very long wrapped lines (the forbidden-handoffs and
  runtime-checkpoint bullets each wrap 4-6 visual lines); reconstructed from wrap
  positions with overlaps verified at 46-53, 84-94, and 118-120.
- Double-backtick identifier styling appears in the Dead-Code Trace Gate section (as in
  prompts 04-10); preserved as shown.
- `4xx`/`5xx` and `≈`-free inline code transcribed exactly as shown.
- File ends at line 158 (content through line 157 + trailing blank).

## Structural facts added by prompt 10

- **First frontend prompt; expanded tools list**: same `OpX-AppMod-P2-Modernize` agent,
  Balanced tier (15-30 min, no model pin), but the frontmatter `tools` now adds `agent`,
  `browser`, `todo`, `vscode/vscodeAPI`, and `fusion/copilot-docs/*` — the first prompt
  that drives a live browser and the Fusion copilot-docs MCP.
- **Plain-language framing**: opens with a "What This Step Does (plain language)" block
  (what/why-it-matters/what-you'll-have) per `step-confidence-contract.instructions.md`
  ("open in plain language, end on binary gates, prove `src/` changes against the running
  app"). This is a different rhetorical register from the backend prompts.
- **Anti-drift ownership contract made explicit**: "Each numbered step owns exactly one
  concern so a defect always has one home and no two steps re-litigate the same
  territory." Step 10 **OWNS the styling foundation outright**; Steps 11-16 consume it,
  never re-author it. Steps 11/12/13 must re-run `scan-styling-foundation.ps1` as an
  entry check — a regressed foundation is a "Step 10 regression" fixed at the foundation,
  never patched in one page.
- **Shared decomposition-skill router**: `/.github/skills/browser-source-decomposition/SKILL.md`
  classifies the legacy source (server-rendered / browser-led SPA / Fusion G1 / mixed /
  static-document / already-modern / validate-only). Each branch routes to a dedicated
  sub-prompt that must run in full before shell formation closes:
  `.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md` (→
  `MVC-To-Browser-Client-Decomposition-Contract.generated.json`) and
  `angular-to-browser-client.prompt.md` (→
  `Angular-To-Browser-Client-Decomposition-Contract.generated.json`). Mixed/hybrid runs
  both. A whole family of decomposition contracts we hadn't seen.
- **`browserSurfaceApplicability` from Step 7** gates the lane: `Required` = full
  foundation+scaffold loop; `NotApplicable` = lightweight proof pass. Portal republish is
  never automatic — staleness is reported in chat for manual refresh.
- **Two deterministic parity scanners** (both under `.github/scripts/parity/`):
  - `scan-styling-foundation.ps1 -ModernClientRoot <root>` — statically fails on OS
    `prefers-color-scheme` following instead of pinned legacy scheme, no style
    `includePaths`, no shared partials, header not bound to legacy brand color, or a data
    grid with all auto-sized columns.
  - `scan-ui-parity-gaps.ps1 -Quiet` — multi-dimensional control-parity scanner. Pairs
    every legacy `<a>`/`<button>`/`<li>` with every modern `<app-*>`/`<fusion-*>` wrapper
    (incl. inline `template:` blocks and tab-data arrays) across a **registry of named
    parity dimensions**, each a self-contained rule pack (legacy extractor / modern
    extractor / normalizer / comparator / allowlist). Built-in dimensions: `label`
    (MissingLabel Major), `icon` (FA4 alias + semantic-vocab normalization → MissingIcon
    Critical / IconMismatch Minor), `color` (Bootstrap `btn-*` ↔ Fusion `color=` via
    `$BootstrapColorMap` → ColorMismatch Minor), `column` (MissingColumn Major — the
    "column-collapse" defect), `handler-wiring` (empty/TODO `(click)` or
    `[disabled]="true"` → InertControl Major), `deferral-drain` (per-app deferral registry
    `ui-deferral-registry.json` with `{handler, ownerStep, reason}`; `-CurrentStep <n>`
    re-flags any deferral whose `ownerStep <= n` — "a deferral cannot survive past the
    step that promised to wire it"). Gate fails on `criticalGaps>0 || majorGaps>0`.
- **"Discovery probe" for unknown-unknowns**: the same scan emits a `discoveryProbe` block
  ranking every legacy attribute/class-token family that NO active dimension consumed, by
  frequency — the kit's mechanism for surfacing parity dimensions it has never seen
  (`confirm`, `tooltip`, `ng-disabled`, `accesskey`...). Plus a documented "Adding a new
  dimension (recipe)" (alias map → `$rec.X` in both Scan-File branches → copy the color
  DIMENSION PASS block → append to `summary.dimensions`). This is a self-extending gate.
- **Render-verified over field-recorded**: the Runtime Parity Checkpoint insists gates be
  proved by *observed browser render*, not by trusting `colorSchemeForced` /
  `brandBindingVerified` JSON claims. "A clean build, a scanner `majorGaps=0`, or an HTTP
  200 are necessary but never sufficient" — a gate recorded `pass` from those proxies is
  invalid; unrenderable → `blocked`/`unverified`, keep the step open. Strongest
  false-green guard in the kit so far.
- **Interaction Wiring + Workflow Trace enforcement at scaffold time**: every rendered
  control must map to a Step 5 `interaction-wiring-inventory.json` entry (reproduce
  `target`/`sideEffects`/`authGate`); high-risk `wiringKind` controls must reproduce the
  `workflow-trace-inventory.json` `requestShape` EXACTLY (verb/URL/payload nesting+casing
  — "flat-vs-nested mismatches ... are the most common parity 400") and every
  `visibleStateLabels` entry. "A button that looks right but has no handler" is a parity
  defect, not cosmetic.
- **Design Tokens Extraction (MANDATORY)**: first pass extracts
  `styling-foundation.tokens.json` (families: color/spacing/typography/borderRadius/
  shadow/zIndex/motion; each row `tokenId`/`valueLight`/`valueDark?`/`sourceEvidencePath`/
  `usageCount`/`mapsToFusionToken?` verified via Fusion MCP), emitted as CSS custom
  properties in `src/<App>.Web.Client/src/styles/_tokens.css`. Raw hex/pixels/font-stacks
  in component CSS are a violation caught by Step 13 + Step 17.
- **"Legacy Visual Language By Construction"**: the goal is the modern shell resembles the
  legacy app "from the first page paste rather than being restyled to parity later." Bind
  the legacy palette through the theme system's **actual consumed API** (`@fusion/theme`
  override map + `root/main` header-branding, or Bootstrap `$bootstrap-config`), NOT as
  orphan CSS custom properties ("a generated `--color-brand-*` that no generator reads
  changes nothing"). Force the legacy color scheme — never inherit OS
  `prefers-color-scheme` (the starter `index.html` ships a `dark-theme`-from-OS script
  that must be neutralized). Five named failure conditions (empty nav / raw default theme
  / wrong scheme / wrong header color or field sizing / missing chrome) = exactly what the
  Step 13 visual-parity gate measures.
- **Per-Slice Shell Parity + Repeat-Run Recommendation (both MANDATORY)**: Phase 2
  frontend advances incrementally from Step 10, one shell slice per pass targeting +5-10pp
  of screenshot/visual/inventory parity, ROI-scored
  `(visibilityScore + interactionScore) - riskScore`; first 3 passes must produce a
  user-visible change. Each pass emits per-slice pixel+structural diffs under
  `parity-diffs/step10-pass-{passId}/` and a `step10-pass-log.json`. Closeout `Suggestions`
  must recommend rerunning with the next slice + expected gain (same wording as Steps
  15/16). New instructions files: `frontend-modernization-learning.instructions.md`
  (Slice Parity And ROI Rules) and `testing-design-contract.instructions.md` (Slice
  Parity Floor And Flake Budget).
- **Fixed response spine**: `About To Do` (Context/Dev work/QA after) → `Modernization
  Added` → `UI Parity Snapshot` (screenshot coverage / visual parity / inventory parity /
  selector coverage / overall rating/10) → `Suggestions` → `Returned Data` (~35 named
  fields incl. the 3 status axes, parity percentages, and `controlParity*` gap counts).
- **Portal surface rename**: canonical Step 10 page is now `frontend-foundation-and-scaffold`
  (`.html`+`.json` under `portal/data/pages/`); the old `frontend-modernization-parity.*`
  is retired and any lingering reference is "dead-surface drift."
- **Three-axis status**: `decompositionContractStatus`
  (Current|NotApplicable|Blocked), `shellFoundationStatus` (Validated|Partial|Blocked),
  `step11HandoffStatus` (ReadyForMigration|NotReadyForMigration|Blocked). Fixed closing
  gate line: `Ready for Step 11 Frontend Migration: Yes`.
- **Closing menu**: QA twin `10-QA-frontend-foundation-and-scaffold` (Lanes:
  Browser-contract shell smoke; ETA 3-5 min) / `next` → Step 11 DEV (Frontend Migration) /
  `stop`. Step 11's name confirmed: "Frontend Migration".

## Transcription uncertainties (prompt 10)

- Double-backtick identifier styling appears in the Design Tokens and Legacy-Visual
  sections (as in prompts 04-09); preserved as shown.
- The `deferral-drain` and `column`/`handler-wiring` dimension bullets wrap heavily and
  were reconstructed from wrap positions; wording verified across the 216-221 overlap
  between the two photo batches.
- `≈` (approximately-equal) used in the icon FA4 alias examples renders faintly in the
  photo; transcribed as `≈`.
- A couple of long completion-gate / visual-language paragraphs were reconstructed from
  wrap positions; overlaps verified at 249-255 and 274-294.
- File ends at line 313 (content through line 311 + trailing blanks).

## Structural facts added by prompt 09

- **Step 9 = production-style backend hardening lane** after Step 8 formation (same
  `OpX-AppMod-P2-Modernize` agent, GPT-5.3-Codex model requirement, Premium tier,
  20-40 min). Frontmatter uses the full `description`/`name`/`argument-hint`/`agent`
  form (like prompts 01-03), not the inline-array style of 07.
- **New MANDATORY self-check: backend functionality-parity scan** — a fourth self-check
  bullet beyond input/restore-point/output. `scan-backend-parity.ps1 -Quiet` proves
  every LEGACY backend endpoint — especially every mutation
  (POST/PUT/DELETE/PATCH: Add/Edit/Delete/Link/Export) — has a modern counterpart.
  Exit 2 = modern API dropped write endpoints; port them or record `acceptedDrops[]`
  (with reason) in `.modernization/ignition-artifacts/discovery/backend-parity-registry.json`.
  Rationale captured verbatim: "Catching a dropped mutation HERE (backend formation) is
  far cheaper than discovering at Step 12 that the UI has Add/Edit/Delete buttons with
  no endpoint behind them." New shared script dir: `.github/scripts/parity/`.
- **Fusion Console logging provider is the mandated logging path**: install
  `Fusion.Fx.Logging.Providers.Console` (latest Sonatype production version), add
  `"FusionConsole": {}` to the `appsettings.json` Logging section (presence triggers
  auto-registration via the Fusion app builder), consult
  `fusion-readme:///src/dotnet/Fusion.Fx.Logging.Providers.Console/README.md` via
  **Fusion MCP** (`fusion-readme://` is a real MCP resource URI scheme). Logs emit as
  JSON to stdout/stderr — no extra ILogger registration needed. Application Insights is
  explicitly a future lane, not required for Step 9.
- **Store-level logging + error-handling contract**: repositories inject `ILogger<T>`,
  log at every DB failure boundary; connection-open failures caught and logged with
  `SqlException.Number` + message + `Data Source` (never passwords) then rethrown → HTTP
  500; each mutation (`Insert`/`Update`/`Delete`/`Upsert`) catches `SqlException`
  separately and returns the legacy error-signaling value instead of throwing (preserves
  service contract); `LogDebug` before each stored-proc call. Same Dapper typed-mapping
  and constructor-parity rules as Step 8, now with the exact materialization exception
  string quoted as a hard-fail signature.
- **Connection-string startup proof**: validate `ConnectionStrings:<name>` resolves
  non-empty at construction time (log `LogError` at startup if empty — "a green
  `dotnet build` does NOT prove the connection string is populated"); DNS-lookup/ping
  the server name before committing; correct env-specific name comes from legacy
  `Configuration/<env>/` files, NOT commented-out `Repository.cs` shortcuts. Split
  env-var pattern reconfirmed:
  `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`;
  `startupProofStatus = Blocked` when a first-request 500 comes from a missing config key.
- **SqlClient TLS scar restated** (3rd appearance): `Microsoft.Data.SqlClient` on
  .NET 6+ enforces TLS validation → `Win32Exception 0x80090325 "certificate chain was
  issued by an authority that is not trusted"` even when PowerShell `SqlConnection`
  (older `System.Data.SqlClient`) works; fix `TrustServerCertificate=True` in
  `appsettings.Development.json` only, never prod/staging.
- **Authorization policy registration verification**: grep `[Authorize(Policy =` and
  cross-check every named policy against `AddAuthorization(...AddPolicy(...))` — a missing
  policy throws `InvalidOperationException` at first request (generic 500), invisible at
  build time. Verify during startup proof, not by reading code.
- **Three-axis Step 9 status**: `controlPointAlignmentStatus`
  (Aligned|DriftDetected|Blocked), `integrationProtectionStatus` (Current|Partial|Blocked),
  `startupProofStatus` (CurrentBuildBacked|SkippedBuildCoverageExplicit|Blocked). The
  "SkippedBuildCoverageExplicit" value + the `test-workspace-gates.json`
  `refreshSafePreflight`/`skipFlags.skipApiBuild` check = the kit refuses to let a skipped
  API build masquerade as real hardening proof (false-green guard).
- **DEV/QA lane separation restated**: Step 9 DEV *creates* the IntegrationBackend,
  ContractApi, and Db test projects + initial tests but does NOT execute them —
  execution proofs owned by `09-QA-backend-dotnet-integration-hardening`. DEV proof is
  `dotnet build` against `src/<AppName>.Web.Api` (build-backed startup proof) plus ≥1
  real runtime request per newly hardened DB-backed endpoint.
- **Backend Load Smoke Gate (MANDATORY)** — new perf gate: 60s load smoke (configurable
  from Step 7 `performanceBudgetPlan`) against top-N `apiEndpointCatalog` endpoints
  (default N=5) using Bombardier/k6/NBomber/hey, data-driven from `load-smoke.config.json`
  (default Bombardier on Windows, k6 on Linux/macOS). Captures rps/p50/p95/p99/errorRate
  to `backend-load-smoke.json`; fails when below `requestsPerSecondFloor` or above
  `p95LatencyCeiling`; when Step 7 declared no budget, this run *becomes* the baseline
  floor/ceiling for Step 17. Auth scheme from `authIntegrationCatalog` — "never invent a
  token shape."
- **Comment/annotation cleanup**: strip stale future-step wording ("another step *will*
  harden this"), remove unused `using` directives, declare `ProducesResponseType` with
  concrete CLR types, no anonymous-object success payloads for documented API surfaces.
- **Closing menu**: QA twin `09-QA-backend-dotnet-integration-hardening` (Lanes:
  Integration, Contract, Db; ETA 5-10 min) / `next` → Step 10 DEV (Frontend Foundation &
  Scaffold) / `stop`. No fixed "Ready for Step 10..." closing line in this prompt (unlike
  07/08) — closeout is the three status fields + the menu.

## Transcription uncertainties (prompt 09)

- The `About To Do` header is rendered as a bullet (`- About To Do`) in the photo,
  unlike prompts 07/08 where it's a plain heading; preserved as photographed.
- Several long connection-string / SqlClient / policy-verification paragraphs wrap
  heavily and were reconstructed from wrap positions; wording verified across photo
  overlaps at lines 38-51, 106-134.
- Double-backtick identifier styling appears in the DEV/QA-separation and Load-Smoke
  sections (as in prompts 04-08); preserved as shown.
- `Win32Exception 0x80090325` and `TrustServerCertificate=True` transcribed exactly as
  shown.
- File ends ~line 172 in the editor (trailing blanks after line 167 of content).

## Structural facts added by prompt 08

- **Cross-vendor per-step model pin**: `Model requirement: Step 8 execution must run on
  GPT-5.3-Codex` (in prose, not frontmatter). With prompt 03's `model: Claude Opus 4.6
  (copilot)` frontmatter pin, the kit picks specific models per step across vendors —
  Opus for heavy analysis, Codex for heavy code movement. New agent:
  `OpX-AppMod-P2-Modernize` (Premium tier, 20-40 min).
- **Two new self-check gates**: restore-point precheck
  (`.github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 8 -Mode Verify|Ensure` —
  no `src/` or `LegacyCode/` mutations until a restore point exists) and a **Fusion MCP
  preflight** (must successfully call `mcp_fusion_fusion_api_docs_entrypoints` or the
  step is `Blocked` with "Fusion MCP unavailable" — never make unverified
  Fusion-structure decisions).
- **Two new skills**: `/.github/skills/architecture-structure/Architecture-Structure.md`
  (applied "literally": entities under `Library/Models/Entities/`, API transport DTOs
  stay in Web.Api, ambiguity resolved explicitly as `Entity` | `API transport model` |
  `Temporary bridge`) and `/.github/skills/fusion-feature-standards/SKILL.md`. Per-app
  addendum: `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`
  (additive clarification only — never rewrite authored guidance).
- **Formation ordering law**: `Library` formed and validated FIRST, then `Web.Api`;
  client scaffold explicitly belongs to Steps 10-11. Statuses:
  `libraryFormationStatus`/`apiFormationStatus` (Validated|Incomplete|Blocked),
  `step9HandoffStatus` (ReadyForHardening|NotReadyForHardening|Blocked).
- **Move-not-copy doctrine**: form destination slice → validate there → remove prior
  source; fallback only create-validate-delete with leftovers reported as "visible
  drift"; closeout gate blocks if movement accounting is `none` when blockers are
  absent; Step 7 clone workspace deleted after consumption (disposition recorded as
  `Deleted`|`Retained by user request`|`Blocked`).
- **Anti-fake-data guardrail**: production seams must not replace DB-backed behavior
  with hardcoded in-memory stores (in-memory only under `tests/**`); unavoidable
  bridges classified `Temporary bridge`, thin, replacement routed to Step 9.
- **Battle scars**: Authorization Policy DI checklist (unported named policies throw
  `InvalidOperationException` → generic 500 before controller body, invisible at build;
  grep legacy Startup for AddPolicy/AddAuthorization/IAuthorizationHandler); Dapper
  typed-mapping parity rule (constructor CLR types must match SQL column CLR types;
  two-step mapping when contracts differ; ≥1 real runtime call per DB-backed endpoint
  before closeout); domain-capability naming (no `Home*`/`Pj*` service names);
  starter placeholder cleanup (MyEntitiesController/PublicTextController).
- **Step 8 = heaviest unit-test growth step**: full scaffolding specified inline
  (csproj net10.0 + xunit/Moq/FluentAssertions/coverlet, GlobalUsings, 4-line file
  purpose block, CaseId/Scenario/Description/Input/Expected comments per catalog);
  exit criteria "EXECUTION ONLY — DO NOT DERIVE"; tracker update shows
  `step8Target: 60`, `step9Target: 80` (confirming prompt 06's tracker keys were
  step-numbered oddly there; flagged in prompt 06 uncertainties).
- **Layering Enforcement Gate**: NetArchTest-style rules in
  `tests/backend/<App>.Architecture.Tests` run via `dotnet test` in CI — Library must
  not reference Web.Api/hosting types; Web.Api must not reference legacy assemblies
  after a slice closes (closed-slice list from `slice-status.json`); no
  System.Web/System.Web.Mvc/System.Web.Http/WebActivatorEx per
  `forbidden-references.json` — forbidden-namespace list is **data-driven from JSON,
  not hard-coded in the test class**. Layering violations fail the build.
- **Protected starter shell**: `Program.cs`, DI composition seams, logging/bootstrap,
  auth wiring, OpenAPI/Scalar setup are never replaced/regenerated unless Step 5
  decisions explicitly allow a narrow rebind; platform concerns re-home into
  starter/Fusion-native sections or `ConnectionStrings` (one centralized startup-bound
  composition seam for split DB env vars — no raw env reads in feature code);
  policy-based authorization only (no Windows auth/Negotiate/direct role checks as
  target state).
- **Code comment quality contract**: file-header comments (what/why/fit), `<summary>`
  on every public type/method, inline comments wherever non-obvious legacy behavior is
  preserved, "explain *why*, not just *what*", no TODO-without-owner, no
  `// generated` markers.
- **Closing menu**: QA twin `08-QA-backend-modernization-formation` (Lanes: Unit,
  ETA 3-5 min) / `next` → Step 9 DEV / `stop`. Step 9's name confirmed: "Backend
  .NET Integration Hardening". Step 10's name confirmed: "Frontend Foundation &
  Scaffold". Fixed closing line: `Ready for Step 9 BackEnd - .NET Integration
  Hardening: Yes or No`.

## Transcription uncertainties (prompt 08)

- The unit-test directory tree (lines ~124-134) renders its box-drawing characters as
  garbled glyphs in the photo; transcribed with ASCII `+--`/`|` tree characters.
- Double-backtick identifier styling appears in the Layering Enforcement Gate and a few
  earlier sections (as in prompts 04-06); preserved as shown.
- Two adjacent near-duplicate bullets under Required work ("Move or prepare only the
  backend shell..." with and without the trailing clause) preserved as photographed —
  apparent source duplication.
- Duplicate Quality-bar bullets ("stable enough for Step 10...") with and without the
  trailing clause likewise preserved as photographed.
- Long wrapped lines reconstructed; overlaps verified at 57-61, 97-113, 135-158,
  193-200, 248-256, 301-306, 355-360, 395-400, 437-444, and 475-498.
- File ends at line 523.

## Structural facts added by prompt 07

- **First Phase 2 prompt; new per-lane agent**: `agent: OpX-dotnet-upgrade` (not the
  Discovery agent) — confirming agents are per-workstream. Frontmatter uses a third
  style: inline `tools: [...]` array. Balanced tier, 15-30 min; no model pin.
- **DEV/QA prompt pairing**: every Phase 2 step has a QA twin (`07-QA-backend-upgrade-dotnet`,
  invocable as `/07-QA-backend-upgrade-dotnet`). DEV ends with a numbered-choice menu
  (`QA` recommended / `next` / `stop`) plus per-lane QA preview (HTTP verify, Screenshot,
  Legacy characterization, Modern characterization, Coverage gap assessment, Legacy
  frontend compatibility, Evidence refresh) and an ETA. Closeout must list every
  created/modified file as workspace-relative markdown links.
- **Dual execution modes** declared from host topology: `RunnableRuntime` (full runtime
  proof required) vs `ConstrainedLegacyHost` (classic System.Web/MVC/WebForms that cannot
  truthfully run as net10 in-place → build + invariant + handoff evidence instead, with
  runtime marked `N/A`, not `Blocked`) — a "truthful constraint" pattern that avoids
  false-red gates without softening them.
- **"Build-green is NOT done" doctrine** with layered runtime proof: infrastructure probe
  (OpenAPI → Swagger JSON → Swagger UI → root, with curl retry flags) → **deep API probe**
  (authenticated real controller route; anonymous 401/403 is explicitly *inconclusive*;
  capture the body, never `-o NUL`; a 500's `InnerMessage` naming DB/TLS/login is a REAL
  upgrade regression, not environmental) → **loaded-vs-compiled invariant re-check** on
  the run/publish folder → **loader-exception log scan** (MissingMethodException etc. is
  a hard failure even with healthy HTTP status — "the app's own error handling can remap
  a fatal loader fault to an ordinary status") → **readiness gate 8a** (cross-origin CORS
  test from the planned Angular port, middleware source-reading, fix/rebuild/retest loop,
  `readinessVerification` block recorded in the step ledger).
- **`verify-upgrade-invariants.ps1`** — new shared gate: single-version package invariant
  across the whole closure (catches split-version/diamond breaks a green build hides),
  with `-PublishDir` mode for shipped-vs-compiled cross-check; test projects classified
  separately (report, don't block).
- **Mutable workspace discipline**: work ONLY in `step7UpgradeWorkspaceRoot`
  (`.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`), never repo `src/`
  (gate-only input, reminder-only baseline check) and never `LegacyCode/`; workspace
  self-heals by copying the whole legacy solution from `authoritativeLegacyRoot`;
  contract values are advisory and path-verified ("never treat a value read from the
  contract as ground truth"). Port defaults 5100/5200; 4200/5001 reserved for the
  modernized src app. Port clearing requires PID ownership validation before
  force-stopping.
- **Project taxonomy**: `Direct` (can move fully to target runtime now) vs `BlockedHost`
  (legacy ASP.NET host started via IIS Express `/clr:v4.0` instead); copied test
  projects are carry-forward context only (Step 8 owns test upgrades).
- **Battle-scar package rules** (mirrors our rehearsal findings): SqlClient 4.0+
  `Encrypt` default flip → `TrustServerCertificate=True` (full failure narrative,
  "a build never reveals this"); EF Core version-matching (3.x on .NET 10 "will compile
  but crash at runtime"); `SqlFunctionExpression.Create` removal →
  `HasDbFunction().HasTranslation()`; EF internals reflection → `ToQueryString()`;
  SPA middleware removal (SpaServices deprecated .NET 7/removed 8+); NETSDK1152
  duplicate-appsettings publish break; NU1102/NU1107/NU1202 zero-tolerance after
  package moves; "move package majors atomically across the entire closure".
- **State save/readback contract**: `step-workflow-state.json` requires populated
  TOP-LEVEL `status`/`updatedAt`/`latestFullResponse` plus `lastExecutedStep`,
  `recommendedNextStep`, and a `stepResponses.steps[]` entry ("a nested step status
  alone is NOT enough"); `step-response-ledger.json` mirrors it; closeout blocked until
  `verify-step-artifacts.ps1 -Step 7 -Mode Output` returns OK.
- **Completion bar** lists explicit truths incl. "`LegacyCode/` was not modified" and a
  scripted blocked-message ("The Step 7 mutable workspace was created but the .NET
  upgrade did not complete successfully. Re-run Step 7 before Step 8.").

## Transcription uncertainties (prompt 07)

- The Required final report list shows a duplicated ordinal in the photo (test
  carry-forward note and build result both read as item "4."), consistent with markdown
  auto-numbering hiding a source-side duplication; preserved as photographed.
- Two references to the single-version invariant say "Execution order step 6" while the
  invariant actually lives under Execution order item 7 (clean build); preserved as-is —
  likely stale numbering after the step-0 reminder was inserted.
- Self-Check block wording reconstructed to the standard two-bullet form seen in prompts
  01-06 (photo wraps obscure some mid-line text).
- Long wrapped lines reconstructed; overlaps verified at 47-54, 100-107, 134-147,
  192-199, 241-249, and 267-299.
- File ends at line 305.

## Structural facts added by prompt 06

- **Step 6 = QA planning pack owner** (extracted from a previously overloaded Step 5):
  owns requirements doc, test plan, testing ownership matrix, characterization ladder,
  testcase catalog direction, testing strategy, regression plan, risk matrix, tool
  rationale, ADO CI/CD planning. Preceded by a **Legacy Unit Test Baseline pre-gate**
  (`legacy-unit-test-baseline.prompt.md`, a sub-prompt invoked from inside Step 6) that
  must report `step7ReadinessStatus: Ready` before quality design runs.
- **A QA prompt stack exists** under `.github/prompts/qaTestPrompts/` read in exact order:
  qa-core-master, qa-core-contract, qa-core-workflows, qa-plan-strategy,
  qa-legacy-characterization. Named reusable workflows: `[WORKFLOW] Modernization
  Solution Design`, `[WORKFLOW] Modern Build Planned QA Tests`.
- **owningStep routing table**: characterization → Step 7 (tests live in
  `LegacyCode/Characterization/Baseline/` — "the frozen baseline ships with the code it
  protects"); unit → Step 8 (`tests/backend/unit/`); integration/contract → Step 9
  (`tests/backend/contractApi|integrationBackend/`); browser-contract/e2e → Steps 10-16
  (`tests/frontend/`).
- **"Phase 2 has no derivation authority"**: the testcase catalog is the work order;
  Steps 7-17 implement entries verbatim, never analyze legacy code or add unplanned
  tests. Gap discovered mid-phase → stop → route back to Step 3/6 → refresh catalog →
  resume. Same drift-control philosophy as Squad-ik gates, applied to test planning.
- **Characterization = behavioral parity, not source-shape lock**: 7 backend behavior
  families (business rules, calculations, validation, API responses incl. every
  documented error path, DB side effects, legacy quirks "weird but load-bearing",
  permission behavior), each needing **three coordinated catalog entries**
  (characterization/unit/integration) unless a thin seam collapses to
  `coverageLevel: "single-layer"`. Frontend behavior is delegated to the UI Screenshot
  Parity lane (visual gates at Steps 11/12/15/18) — legacy screenshots are the contract.
- **C1-C9 source-shape lock rules** (structural floor): controller class presence, API
  action+verb, mutating-endpoint contract shape, EF entity shape, config seams,
  bootstrap/startup sequence, view/template markers (ng-* directives, @Scripts.Render),
  calculation-helper contracts, JS controller file presence (owningStep 10+, browser
  lane). Thin coverage marked `coverageLevel: "class-presence-only"` for QA Lane 5 audit.
- **8-rule per-service scenario derivation** reading Step 3 service-behavior-inventory
  fields (branchingParameters, throwGuards, nullCoalescingDefaults, ...): every public
  method ≥1 scenario; nullable returns get found+not-found; every throwing guard its own
  scenario; mode/flag branches one per mode; `??=` defaults two scenarios; collection
  methods empty-case; display decorators idempotency; delegation orchestrators one per
  path. Deterministic inventory→catalog mapping with rule-number traceability.
- **Five-tier API smoke safety model** (T1 unauthenticated reachability expecting
  401/403 → T2 CORS preflight → T3 authenticated invalid-body rejection with
  validation-gate file+line evidence that must precede the first mutation call → T4
  dry-run/pure-compute POST with grep-evidenced `mutatesState: false` → T5 ephemeral
  round-trip, **default OFF**, requires `dataSafety: ephemeral` in kit-params + explicit
  named user opt-in, forbidden against any data source whose loss would be noticed).
  T1 floor for every endpoint; real mutations belong to Step 12 integration with
  `page.route(...)` interception. 100% `apiSmokeCoverage` before Step 12.
- **Progress denominators contract**: qa-test-plan.json publishes `progressDenominators`
  (totalBackendFilesPlanned, totalApiEndpoints, totalRoutes, ..., plus extensions:
  totalErrorStates, totalExportSurfaces, totalRealtimeSurfaces, performanceBudgetRoutes,
  flakeBudgetPercent, dataFixtureCoverage, localesPlanned, routeStateParityFloor 90%);
  every Phase 2 percentage must be `done / total` citing real artifacts — "estimated
  percentages are forbidden" (appmod-phase-agent-contract rule 20).
- **Per-route behavior plan** (`per-route-behavior-plan.json`): per route
  `primaryDataCalls`, `interactiveElements` (with ownerStep 11/12/15+),
  `modalsAndBanners`, `placeholderDataPolicy: forbidden|allowedUntilStep<N>` — exists
  because "Steps 11 and 12 ship dead routes when they only have to prove 'the page
  renders' and not 'the page works'."
- **Testing accumulation plan Steps 7-17** with per-step targets (Step 8 >60% Library
  coverage growing to 80% by Step 9; Step 10 creates Playwright+Cucumber foundation;
  Step 17 = "S-TIER VERIFICATION GATE" 100% POM/Gherkin/aria/testid + >80% backend →
  Quality Score 95+ ready for Step 22), tracked in `test-accumulation-tracker.json`
  (updated by Steps 9-20, verified by Step 17; fields step17ReadinessScore,
  step22ProjectedScore).
- **Canonical planning script**: `qa-refresh-test-plan.ps1` is the authoritative
  generator for qa-test-plan/ownership-matrix/testcase-catalog + Step 8 layering-gate
  baselines (forbidden-references.json, slice-status.json) — "do not hand-author".
- **Frontend smoke lane doctrine**: one `ui-navigation-smoke.spec.ts` (~30-45s, read-only,
  no business transactions), shared helper `playwright-navigation-smoke-helper.js` under
  `.github/scripts/QA/`, exactly **one deterministic self-heal attempt** before reporting
  `Blocked`; smoke-evidence publisher is tracked infrastructure, not generated content.
- **Data-safety patterns**: Pattern A (live round-trip) for read-only GET/HEAD, Pattern B
  (interception) for mutating verbs; `ui-api-wiring-map.json` + spec template
  `_template/ui-api-wiring.spec.template.ts` drive mechanical derivation (Rule-Route-1).
- **Test root layout**: `tests/backend/{unit,contractApi,integrationBackend,smoke}`,
  `tests/frontend/{smoke,integrationFrontend,visualParity,e2e/{pages,journeys,
  accessibility,support}}`, `tests/modernization/characterization/{testcase,testResult}`;
  no step-named subfolders; one Markdown execution report per modernization step.
  Anti-Pact/perf-suite default: add only when compliance explicitly requires.
- Fixed closing line: `Ready for Step 7 Backend - Upgrade .NET: Yes or No` — and step
  names now confirmed: Step 7 "Backend - Upgrade .NET", Step 22 quality-score gate,
  Steps 9-20 update the tracker.

## Transcription uncertainties (prompt 06)

- Several headings/dashes render as garbled glyphs in the photos (e.g. "MANDATORY <?>
  Step 6 MUST assign a tier per endpoint"); transcribed as em dashes (`—`) — almost
  certainly UTF-8 em dashes displaying oddly at an angle.
- The owningStep routing table says characterization "Step 7 DEV authors and runs
  these", while the planning rule below it says "Step 7 QA uses these rows ... Step 7
  DEV does not run characterization tests" — tension preserved exactly as photographed.
- `test-accumulation-tracker.json` backendCoverage keys read `step6Target: 60`,
  `step7Target: 80`, `step15Target: 80` in the photo; the accumulation plan says Step 8
  >60% and Step 9 >80%, so these could plausibly be `step8Target`/`step9Target`/
  `step17Target` — transcribed as photographed and flagged.
- Line 525 says "Each step from 9-20 must UPDATE this tracker" while the exit criteria
  say scenarios are assigned to steps 7-17; preserved as-is.
- Execution order item 3 renders as "- 3." (stray list dash) in the photo; preserved.
- The "NO raw CSS or XPath selectors" bullet and Gherkin/data-testid/aria conventions
  appear detached after the bold Steps-7-17 paragraph (lines 378-391), likely displaced
  from the Playwright architecture section; transcribed in photographed order.
- Double-backtick identifier styling in the denominator sections preserved as shown.
- Long wrapped lines reconstructed; overlaps verified at 54-62, 92-114, 139-151,
  181-189, 222-245, 276-279, 315-321, 359-371, 411-422, 461-472, 516-522, 538-544.
- File ends at line 576.

## Structural facts added by prompt 05

- **Step 5 is the plan-closure gate** ("last major planning gate before implementation"):
  thirteen mandatory plan families — API Integration, Auth Integration, Test-Hook/Playwright,
  Data Fixture & Seeding, Performance Budget, Accessibility Audit, State Management,
  Realtime & Push, Logging & Telemetry, Environment Config, Cutover & Rollback,
  Test Isolation & Flake Budget, Localization — each recorded as a named plan array in
  `fusion-restructure/decisions.json`, each with the same drift-control rule: *"a Phase 2
  step that discovers a gap is a Step 5 planning gap and must route back here."*
- **Dominion confirmed as the acceptance-standard**: authoritative file is
  `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` (fail-fast if
  missing). Fusion is the default target outcome; MVC/Razor/AngularJS/Angular are "source
  patterns or temporary bridges, not the target-state goal by default."
- **Three-axis Step 5 readiness**: `ownershipDecisionStatus`
  (DecisionGrade|NeedsFollowUp|Blocked), `userInputGateStatus`
  (Cleared|Outstanding|Blocked), `executionReadinessStatus`
  (ReadyForQualityDesign|NotReadyForQualityDesign|UserInputRequired|BlockedMissingArtifact) —
  with `UserInputRequired` (artifacts fine, human gates open) explicitly distinguished from
  `BlockedMissingArtifact` (upstream artifacts missing/stale).
- **Named markdown reports are canonical, JSON is companion**: Step 5 must produce
  `Modernization-Solution-Design.md`, `Modernization-Execution-Contract.md`, and
  `Modernization-Phase-Assessment.md` (read downstream by exact path; the Phase-Assessment
  must state a Step 8 disposition of `Skip`|`ValidateOnly`|`Execute`) plus three DEV-owned
  control-plane JSONs under portal data. Anti-hallucination contract: every control-plane
  JSON needs non-empty `reportId` + `title` so the shared verifier can reject "a truncated
  or hallucinated fragment"; field contracts live under **`.github/contracts/schemas/`**
  (new kit directory).
- **Immutable-baseline contract**: after Step 3, AI may write under `LegacyCode/` ONLY in
  `LegacyCode/<LegacyTestProject>/Characterization/Baseline`; all other legacy-tree writes
  (and any generated JSON/reports/portal pages) are forbidden — same principle as
  Squad-ik's read-only LegacyApplication/ rule. Step 7 upgrade workspace root:
  `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`.
- **Code Quality Standards section** Steps 7-18 enforce (and Step 24 Technical Review
  verifies — confirming the 24-step count): .NET (nullable everywhere, no
  .Result/.Wait/GetAwaiter, ctor DI, methods <50 lines / classes <500,
  IFusionLogger/IFusionHttpClientFactory/IFusionCache, [Authorize] on all controllers),
  Angular (standalone components only, signals, @if/@for/@switch, inject()), a11y
  (aria-label, data-testid on all testables, landmarks, full keyboard), tests (backend
  >80% on Library, POM class per route + Gherkin per journey,
  MethodName_Scenario_ExpectedResult).
- **Wrapper capability vocabulary**: each `requiresWrapperCapability` gets
  `ShipFromDayOne`|`ExtendAtStep15`|`ExtendAtStep17Preflight`|`IntentionallyDeferred`;
  wrappers fronting generic Fusion primitives need permissive `options:
  Record<string, unknown>`; form-field wrappers need `readOnly`+`disabled` with derived
  `controlDisabled`; every wrapper passes through `elementId`+`testId` so `<label for>`
  and Playwright selectors survive the swap.
- **Carry-forward disposition vocabulary**: every material Step 3/4 item must end as
  `ResolvedByPlanningDecision`|`UserInputGate`|`OwnedByModernizationQualityDesign`|
  `OwnedByLaterStep`|`Blocked` — "do not report ready by feel."
- **Auth plan machinery**: legacy `Web.config` is authoritative for auth detection
  (`authentication mode="Windows"`, `AppletSecurity.SarRoleMapping` auto-populate
  kit-params); Okta issuer + default client id are pinned kit-wide (values redacted here);
  connection-string runtime intake uses shorthand `OCPEnv` (default OpenShift/K8s split
  env vars) | `LocalIntegrated`/`OpEx` (local Windows integrated) | `OpX` (operator
  deferral, tracked-not-blocking) | concrete config-file ref/connection string.
- **`No QA` run mode**: the exact phrase `No QA` in a request skips the mapped QA workflow
  for the run (noted as operator-requested) — the control-plane JSONs exist specifically
  so `No QA` runs still work.
- **Fixed response spine**: 12 ordered sections, a closing `User Input Required` block
  (`Required now` / `Optional` / `Auto-detected from legacy config` / `Operator
  deferrals`), and one explicit final line `Ready for Modernization Quality Design: Yes
  or No`.
- Frontmatter gains an `edit` tool entry (first Discovery prompt that writes artifacts);
  **no `model:` pin despite Premium reasoning tier** — so pins are not simply
  tier-correlated.

## Redactions (prompt 05 — deliberate, not uncertainties)

- Line ~138: the real Okta tenant URL pinned as `oktaIssuerOverride` is replaced with
  `https://<company-tenant>.okta.com` and an inline `REDACTED` comment.
- Line ~139: the concrete default Okta client ID (`0oa1…`) is replaced with
  `<default-okta-client-id>` and an inline `REDACTED` comment.
- Rationale: standing repo policy — no real Okta tenant hostnames or IDs in this repo.
  The work-side original pins the real values; restore them there, never here.

## Transcription uncertainties (prompt 05)

- Frontmatter tools list ends with a bare `- edit` (prompt 02 used `edit/editFiles`);
  transcribed as photographed.
- Double-backtick identifier styling appears from the Data Fixture section onward (mixed
  with single backticks earlier); preserved as shown.
- The `wrapperCapabilityPlan[]` bullet shows the decisions.json path without backticks,
  unlike sibling bullets; preserved as shown.
- "Step 5 closes from its own planning artifacts…" joined to the Dev-work bullet based on
  indentation in the photo.
- Long wrapped lines reconstructed from wrap positions; wording verified across photo
  overlaps at lines 14-59, 57-62, 98-108, 143-150, 189-199, and 236-246.
- File ends ~line 288 in the editor.

## Structural facts added by prompt 04

- **This is the Ignition scorecard step** (maps to Squad-ik's steps 03/19 scorecard
  machinery): a hybrid review with a deterministic layer and an AI-judgment layer, scored
  by closure formula `100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`.
- **"Dominion"** is the compliance/acceptance-criteria framework name ("Dominion
  compliance evidence", "Dominion criteria", "Dominion requirements").
- **Deterministic pattern catalog with stable IDs**: A1.x CRITICAL (-10 each, 5 patterns:
  hardcoded creds, SQL injection, tokens in localStorage, unsanitized innerHTML, sensitive
  data in logs), A2.x HIGH (-5 each, 18 patterns incl. FormsAuthentication, .Result/.Wait
  blocking, new HttpClient(), Session state, jQuery-in-Angular), A3.x MEDIUM (-2 each,
  13 patterns incl. missing OnPush, subscribe-without-unsubscribe, UseSwagger without dev
  check, verb-based URLs). Each row is Pattern + "What It Looks Like" example.
- **AI-judgment criteria with IDs**: B1 SOLID (5), B2 Security (4), B3 12-Factor (5),
  B4 API design (2, controllers only), B5 Angular (3, .ts/.html only) — plus file-level
  thresholds (class >500 lines HIGH, ctor >7 params HIGH, interface >15 methods HIGH)
  and an explicit "NOT violations" skip-list (DTO `new`, `static readonly`, IMemoryCache,
  `new` in tests).
- **Per-criterion scoring is data-driven**: criteria load from a versioned
  `acceptance-criteria-catalog.json`, each criterion gets `criterionId`/`baselineScore`
  (0..100)/`observedEvidencePaths[]`/`findingIdsContributing[]`/`confidence` in
  `baseline-review.json`; Step 5 plans remediation order from it and **Step 17 computes
  per-criterion `improvementDelta`** (baseline vs modern) — same before/after delta idea
  as Squad-ik's delta-report. Explicitly framework-generic (MVC, Razor Pages, Web Forms,
  Blazor, AngularJS, Angular, React, Vue, server-rendered HTML).
- **AI-judgment artifact with guardrails**: design-level criteria the scanner can't decide
  (SOLID SRP/OCP/LSP/ISP, stateless posture) surface as `UNKNOWN` unless an evidence-backed
  `judgments[]` artifact (`baseline-criterion-judgments.json`; Final phase uses
  `final-criterion-judgments.json`) resolves them. Guardrails: status must be
  PASS/FAIL/PARTIAL with >=1 cited `path:line - reason`; inferred-without-evidence is
  disallowed; deterministic rows are never overridden ("hard findings always outrank AI
  reasoning"); undecidable -> `PARTIAL` with reason, never a guessed clean result.
- **Step 4 three-axis status model**: `criterionCoverageStatus`
  (DecisionGrade|BroadButIncomplete|Blocked), `blockingGapStatus`
  (None|Present|BlockedByMissingEvidence), `planningInputStatus`
  (ReadyForStep5|NeedsFollowUp|Blocked). Step 4 is "incomplete" until findings are ranked
  into exact Step 5 planning inputs — evidence alone isn't done.
- **Cross-step courtesy rule**: `rename-verification.json` (Step 2-owned) unresolved items
  do NOT hard-block Step 4 when Step 2 is recorded complete in step-workflow-state.json —
  treated as informational. Steps don't re-litigate other steps' gates.
- **Model tier**: Balanced (medium thinking), 10-20 min; **no `model:` pin in this
  prompt's frontmatter** (unlike prompt 03's Opus pin) — pins appear only on the heavy
  reasoning steps.
- **Chunked review protocol**: process manifest files in chunks of 10-15, save progress
  after each chunk, require 100% file coverage verified by
  `P2-Modernize/verify-coverage.ps1` before `04-P1-generate-report.ps1 -Phase Baseline`
  refreshes `BASELINE-COMPLIANCE-REPORT.json` (portal). Fixed completion phrase:
  "BASELINE REVIEW COMPLETE".

## Transcription uncertainties (prompt 04)

- Two artifact roots appear for the same file: header block says **Output:**
  `.modernization/ignition-artifacts/discovery/baseline-review.json`, while the closure
  contract saves chunks to `.modernization/artifacts/reviews/baseline-review.json` (and
  the judgment artifact lives under `.modernization/artifacts/reviews/`). Transcribed
  exactly as photographed — possibly a source inconsistency or an intentional
  staging-vs-final split.
- The Per-Criterion Baseline Score section visibly uses **double backticks** around
  identifiers (e.g. ``criterionId``) unlike single backticks elsewhere; preserved as
  shown.
- `A2.6 async void` example shows a trailing space inside the backticks (`async void `);
  preserved.
- Long wrapped lines (status model, artifact contract, AI-judgment guardrails, closing
  bullet) reconstructed from wrap positions; wording verified across photo overlaps at
  lines 55-62, 112-118, and 157-175.
- File ends ~line 207 with trailing blank lines to 211 in the editor.

## Transcription uncertainties (prompt 03)

- Frontmatter shows only `description`, `agent`, `model`, `tools` — no `name:`/
  `argument-hint:` lines visible (unlike prompts 01-02). A "Configure Tools…" UI
  affordance appears between `model:` and `tools:`; transcribed as photographed.
- The Step Artifact Self-Check header may carry the "(QA-independent; works on `No QA`
  runs)" parenthetical seen in prompts 01-02; not legible in the photo, so omitted here.
- Source-internal inconsistency preserved as-is: the Required Artifacts table has **10**
  rows, but Required Response Sections / Output Normalization Rules say "each of the 7
  artifacts" / "list all 7 artifacts every run" (likely the A1-A7 schema artifacts).
- Line 88's `OPX_ENABLE_QA_PORTAL_REFRESH=1;` prefix transcribed exactly as shown
  (env-assignment + semicolon before a `powershell` invocation).
- Long wrapped lines (Hard Stops, capture requirements, enrichment rules, visual
  contract) reconstructed from wrap positions; wording verified across photo overlaps
  at lines 53-62, 101-109, 148-156, 203-208, and 251-260.
- File ends ~line 305 with trailing blank lines to 309 in the editor.

## Transcription uncertainties (prompt 02)

- Frontmatter `name:` line hidden behind the wrapped description in the photo;
  reconstructed from the visible filename.
- Line 6 in the tools list shows a "Configure Tools…" UI affordance, not file content.
- `npm run install` (Required Edits #6) transcribed as shown — possibly `npm install`
  in source; flagged rather than corrected.

## Transcription uncertainties (prompt 01)

- Frontmatter opening `---` not visible in photo (closing `---` at line 11 is); standard
  prompt-file frontmatter assumed.
- Lines 54-55 both appear in the source with near-duplicate wording (remove stale
  `.vs`/`obj` vs `.vs`/`bin`/`obj` "when the old build outputs are poisoning the legacy
  import graph") — transcribed as-is; possibly an intentional escalation, possibly a
  source duplication.
- Minor wrapped-line reconstruction in the Step Artifact Self-Check block (lines 22-24).
