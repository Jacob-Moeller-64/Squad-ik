---
description: Perform legacy system analysis for the current application from manifest-backed repo evidence and produce the current-state document pack.
agent: OpX-AppMod-P1-Discovery
model: Claude Opus 4.6 (copilot)
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# Step 3 — Legacy System Analysis

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-40 min (varies with app size and model).

> Step Artifact Self-Check
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 3 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 3 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

Schema Contract Version
- `step3ArtifactSchemaContractVersion`: `1.0.1`
- The version above must match `.github/skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`.

**Context:** Discovery pass that all later planning depends on. Produces decision-grade evidence about the legacy app's structure, behavior, and dependencies.
**Dev work:** Run the manifest refresh, inspect `LegacyCode/` directly, and generate the required structured artifacts.
**Step 3 closeout:** Step 3 closes from its own artifact pack, gate output, and saved step state.

---

## Hard Stops — Do Not Proceed Past These

**STOP 1 — Live QA endpoint.**
Before running any script, resolve the live QA URL using this exact priority order — stop at the first match:
1. `currentQaUrl` in `.modernization/.readme/kit-params.md` — read the file, extract the value after `currentQaUrl:`. If non-empty, use it. Set `qaUrlSource = currentQaUrl`.
2. `currentDevUrl` in `.modernization/.readme/kit-params.md` — same extraction. If non-empty, use it. Set `qaUrlSource = currentDevUrl`.
3. Ask in chat: **"What is the live URL for this application?"** — if the user replies with a URL, use it. Set `qaUrlSource = UserProvided`.
4. If no URL is resolved from any of the above, **STOP** and report: "Cannot proceed — no live URL found. Add `currentQaUrl` to `.modernization/.readme/kit-params.md` or provide the URL in chat."
Once resolved, pass the URL as `-LiveQaAppUrl '<url>'` to the script and persist it in `.modernization/portal/data/json/legacy-system-analysis-report.json` as `liveQaUrl`.
- Mandatory echo: always report both `qaUrlSource` (currentQaUrl | currentDevUrl | UserProvided) and the final URL value in the response.

**STOP 2 — Step 3 preflight prerequisites.**
Before generating any artifact, verify only Step-3-owned prerequisites:
- LegacyCode/ source accessible for direct inspection
- A resolvable live QA URL input for this pass (LiveQaAppUrl, locked runtime URL, currentQaUrl, or currentDevUrl)

Do not require Step 4+ artifacts (for example characterization planning or test-plan outputs) to start Step 3. If a non-Step-3 dependency is detected, STOP and report it explicitly as a contract drift blocker with exact file/surface.

**STOP 2.5 — App-shape branch (authoritative for this run).**
Classify source shape before artifact enforcement and carry that shape into artifact applicability and response sections:
- api-only -> prioritize backend inventories, mark browser-only surfaces as notApplicable with reasons.
- mvc -> treat as server-rendered browser-led evidence set.
- spa -> treat as browser-led SPA evidence set.
- hybrid -> enforce both browser and API families with conditional rows where evidence warrants.

**Modality enforcement gate (mandatory).** The classified `detectedModality` value MUST be one of `api-only`, `mvc`, `spa`, or `hybrid`. Record it explicitly in `Source Stack Fingerprint` (section 4) using the exact key `detectedModality`. Deterministic detection criteria:
- If `LegacyCode/` contains `.cshtml` views with `@model` directives or `RouteConfig.cs`/`Startup.cs` registering MVC routes, AND no standalone SPA entry (e.g., no `angular.json`, `package.json` with `@angular/core`, or `main.ts`/`index.html` bootstrapping a client framework), classify as `mvc`.
- If `LegacyCode/` contains `angular.json`, or `package.json` with `@angular/core`/`@angular/cli`, or a Knockout/Durandal `shell.js`/`main.js` with AMD/RequireJS, classify as `spa`.
- If `LegacyCode/` contains ONLY API controllers (inheriting `ApiController` or `ControllerBase`) with no views, no `wwwroot/index.html`, and no client framework references, classify as `api-only`.
- If detection is ambiguous, list the conflicting evidence and classify as `hybrid` with a reason. Do NOT proceed past STOP 2.5 without recording `detectedModality`.

**STOP 3 — Artifact completeness gate.**
Before reporting Step 3 complete, every artifact in the Required Artifacts table below must be present, non-empty, and contain at least one `legacyEvidence`-backed entry (or an explicit `notApplicable` reason). Missing artifact = hard blocker; report it explicitly.

---

## Execution Sequence

Run in this order. Do not skip steps.

```
1. STOP 1 — Collect or auto-resolve live QA URL
2. STOP 2 — Verify prerequisites
3. Detect app modality from source evidence: api-only | mvc | spa | hybrid
4. Run: .github/scripts/P1-Discovery/03-P1-generate-manifest.ps1 -RepoPath ./LegacyCode -LegacySystemAnalysis -LiveQaAppUrl '<url>'
5. For mvc | spa | hybrid modalities, run the screenshot-capture skill runner against the live URL and persist image evidence under `.modernization/portal/data/images/legacy-system-analysis/`:
   `powershell -NoProfile -ExecutionPolicy Bypass -File ./.github/skills/screenshot-capture/scripts/capture-legacy-analysis-step3-evidence.ps1 -RepoRoot . -LegacyAppRoot ./LegacyCode/<app-root> -LiveQaAppUrl '<url>'`
   Capture requirements:
   - **SPA/hybrid preflight**: before running the capture command, verify (a) the legacy app is reachable at the resolved live QA URL, and (b) Playwright Chromium is installed in the modern client workspace (`src/<AppName>.Web.Client/node_modules/playwright`). Missing either will trigger Gate 2 or Gate 3 in the capture pipeline and produce zero images.
   - **SPA/hybrid route source**: for `spa` and `hybrid` modalities, screenshot targets are derived from the Angular client-side router (`app-routing.module.ts` in `LegacyCode/`), NOT from server-rendered view file paths. The `-AutoRefresh` flag on the command above activates the Angular route supplement. Do not interpret zero captures as a route-inventory problem if Gate 1 is clear but Gate 2 or Gate 3 blocked.
   - Capture full-size browser surfaces (desktop viewport) so route layouts and large table surfaces are fully visible.
   - Capture relevant dialog or modal states that open during workflow interactions (example: recurrence dialog on new rule workflow).
   - Deduplicate visually identical captures; keep one canonical file and avoid duplicate landing and route images when content is the same.
   Portal consumption note:
   - The portal refresh should consume the screenshot evidence and refresh display artifacts only. Use a narrow refresh command when needed:
     `OPX_ENABLE_QA_PORTAL_REFRESH=1; powershell -NoProfile -ExecutionPolicy Bypass -File ./.github/scripts/QA/qa-refresh-portal.ps1 -RefreshOnly -SelectedPages legacy-system-analysis -ProjectPath ./LegacyCode/<app-root>`
6. Inspect LegacyCode/ directly — read source files, do not rely on previously generated summaries
7. Generate artifacts using the modality applicability matrix below
8. Enrich portal report skeletons with analysis findings (see Portal Report Enrichment table)
9. Run: .github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1
10. STOP 3 — Verify all required artifacts for the detected modality pass the gate
11. Confirm gate-authoritative state sync landed in `.modernization/portal/data/json/step-workflow-state.json` and `.modernization/portal/data/json/step-response-ledger.json`.
12. Finish from the Step 3 artifact pack, gate output, and saved state without routing to a separate QA prompt.
```

---

Portal publication remains manual-only. Step 3 completion is decided from source artifacts and gate outputs, not portal republish state. The screenshot capture pass above is required evidence capture and does not require full portal republish.

## Portal Report Enrichment

After the script creates skeleton portal reports (execution step 4), enrich each report in `.modernization/portal/data/json/` with findings from the analysis pass. The script seeds `generatedAt`, `appShape`, `sourcePhase`, and `liveQaUrl`. The agent must merge in the substantive content below so downstream consumers and portal viewers see decision-grade evidence, not empty stubs.

| Report file | Enrich with |
|---|---|
| `legacy-system-analysis-report.json` | Route/screen inventory, workflow walkthroughs, auth evidence, page-to-backend traces, UI loss-risk register, high-risk control trace register, `screenshotCoverageMatrix` (also Required Artifact #6) |
| `manifest-coverage-report.json` | Manifest path, file-count summary by category, scan-scope accounting, exclusions, coverage gate result |
| `current-state-classification-report.json` | `detectedModality`, source stack fingerprint, architecture observations, modernization intensity signals, artifact-family status |
| `runtime-topology-report.json` | Entry points, hosts, background jobs, schedulers, queues, file-drop/export flows, runtime-to-config dependencies |
| `integration-contract-catalog.json` | External systems, protocols, auth models, payload shapes, retry behavior, ownership notes |
| `environment-and-secrets-map.json` | Config sources, secret/cert dependencies, environment-specific overrides, service identities, unverified gaps |
| `data-and-cutover-risk-report.json` | Persistence inventory, schema ownership, migration-sensitive data, coexistence risks, rollback-sensitive state |
| `gap-and-exception-register.json` | Cannot-locate backlog, evidence gaps, manual follow-up actions, deferred items with required evidence type |
| `leadership-summary.json` | App shape, major workflows, major risks, readiness score, recommended next step |

Rules:
- Merge into the existing skeleton — do not overwrite `generatedAt`, `appShape`, `sourcePhase`, or `liveQaUrl`.
- Each report must contain at least one substantive finding or an explicit `notApplicable` marker with reason.
- Do not invent data. If a report surface has no applicable findings for the detected modality, write `{ "notApplicable": true, "reason": "<modality> app — surface not present" }`.
- Portal report enrichment is NOT a hard-stop gate. If enrichment fails for a non-critical report, note the gap in response section 8 (Gaps & Blockers) and continue.
- When legacy config files expose a concrete connection string or a concrete config-file source for one, carry that evidence forward into `/.modernization/.readme/kit-params.md` under `connectionStringRuntimeInput` unless the user has already explicitly set a different value. Keep `OCPEnv` as the default final-state mode unless the user intentionally chooses `OpX`, `LocalIntegrated` (or `OpEx`), or a concrete legacy config-file reference.
- When deployment evidence exists for the final-state OpenShift/Kubernetes pattern, record the exact environment variable names the backend is expected to consume. The default pattern should be the split SQL variables `SqlServer__Server`, `SqlServer__Database`, `SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`, and `SqlServer__TrustServerCertificate` unless repo evidence proves a different naming scheme.
- Refresh `/.modernization/.readme/HowToRun.md` during Step 3 when connection runtime inputs are clarified so the API run section contains one copy/pasteable alternative command that sets the expected environment variables in the current shell before `dotnet run`. If legacy analysis finds config-file connection evidence, use those discovered values (for example server and database) in the generated command while keeping secrets as placeholders.
- For DB-backed repository/service methods, capture available SQL parameter and result-column type hints in `service-behavior-inventory.json` (using the optional Step 3 schema fields) so Step 8 and Step 9 can keep Dapper row-model constructor types aligned with SQL types.

## Required Artifacts

Every artifact must be generated by direct source inspection. Do not invent entries from summaries.
Each entry must include `legacyEvidence` with a real file path and line range.

| # | Artifact | Location | Hard-blocked if missing |
|---|---|---|---|
| 1 | Service & Behavior Inventory | `.modernization/ignition-artifacts/discovery/service-behavior-inventory.json` | Yes |
| 2 | Interaction Wiring Inventory | `.modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json` | Yes — and every entry must have `effectClass` resolved (not left as `ui-only` unless genuinely UI-only), `effectAssertion` populated, and `lifecycleState` starting at `Inventoried`. Entries the script cannot classify must be enriched by the agent during this step; unresolvable entries must use `wiringStatus: cannot-locate` not `ui-only`. See `ui-capture-reverse-engineering.instructions.md` (Functional Parity Ledger) for the effect taxonomy, lifecycle states, and classification priority rules. |
| 3 | Workflow Trace Inventory | `.modernization/ignition-artifacts/discovery/workflow-trace-inventory.json` | Yes |
| 4 | `apiEndpointCatalog` field | `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` | Yes |
| 5 | `uiControlClassification` field | `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` | Yes |
| 6 | `screenshotCoverageMatrix` field | `.modernization/portal/data/json/legacy-system-analysis-report.json` | Conditional (hard-block only when zero captures and no operator approval) |
| 7 | `fusionPrimitiveCoverageCensus` field | `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` | Yes |
| 8 | `errorStateCatalog` field | `.modernization/portal/data/json/legacy-system-analysis-report.json` | Yes |
| 9 | `exportSurfaceCatalog` field | `.modernization/portal/data/json/legacy-system-analysis-report.json` | Yes |
| 10 | `realtimeSurfaceCatalog` field | `.modernization/portal/data/json/legacy-system-analysis-report.json` | Yes |

### Modality Applicability Matrix

Use this matrix before enforcing STOP 3. Browser-only artifacts are not hard blockers for api-only apps.

| Artifact | api-only | mvc | spa | hybrid |
|---|---|---|---|---|
| 1 service-behavior-inventory | Required | Required | Required | Required |
| 2 interaction-wiring-inventory | notApplicable | Required | Required | Required |
| 3 workflow-trace-inventory | notApplicable | Required | Required | Conditional |
| 4 apiEndpointCatalog | Required | Required | Required | Required |
| 5 uiControlClassification | notApplicable | Required | Required | Conditional |
| 6 screenshotCoverageMatrix | notApplicable | Required | Required | Conditional |
| 7 fusionPrimitiveCoverageCensus | notApplicable | Required | Required | Conditional |
| 8 errorStateCatalog | Required | Required | Required | Required |
| 9 exportSurfaceCatalog | Conditional | Conditional | Conditional | Conditional |
| 10 realtimeSurfaceCatalog | Conditional | Conditional | Conditional | Conditional |

Applicability rules:
- `Required`: artifact must exist and pass schema checks.
- `Conditional`: required only when evidence proves the corresponding surface exists.
- `notApplicable`: artifact must still exist with an explicit marker and reason (for example `notApplicable: true` and `reason`). Do not leave missing.
- For `errorStateCatalog`, when no high-confidence error states are discoverable in this pass, record an explicit non-blocking object with `scanStatus: none-detected`, `entries: []`, and source evidence. This is valid Step 3 completion and can be enriched later.
- For `exportSurfaceCatalog` and `realtimeSurfaceCatalog`, if no matching surfaces are found, record `notApplicable: true` with source evidence and reason instead of blocking.
- Screenshot progression rule: screenshots are still required evidence and should be captured, but partial successful capture is allowed for progression when all three are true: (1) at least one screenshot exists, (2) the user is explicitly asked to review available screenshots, and (3) the user explicitly approves moving forward. If zero screenshots are captured and none are user-provided, Step 3 remains blocked.
- When screenshot gaps remain, explicitly encourage the user to add screenshots under `.modernization/.readme/user-provided-info/` and then reference those files in `screenshotCoverageMatrix` as user-provided evidence rows.
- STOP 3 must evaluate requiredness from this matrix using the detected modality.

### Optional User-Provided Screenshot And Error Evidence

- At Step 3 closeout, always ask the user to review available screenshot captures and confirm whether coverage is sufficient to proceed.
- If coverage is not sufficient, encourage the user to add missing screenshots and notes under `.modernization/.readme/user-provided-info/`.
- If user-provided screenshots are supplied, record them in `screenshotCoverageMatrix` as `captured-user-provided` rows with file-path evidence.
- At Step 3 closeout, ask the user this optional question:
  - "If you have screenshots or notes showing expected legacy error states (for example 401 or forbidden), share file paths under .modernization/.readme/user-provided-info/."
- This is optional and never blocks Step 3.
- If provided, add those file paths into `legacy-system-analysis-report.json` under `errorStateCatalog.userProvidedEvidencePaths[]`.
- If nothing is provided, continue with scanner-derived findings only.

### Artifact schema source of truth

Schema-heavy Step 3 artifact definitions are owned here:
- `.github/skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`
- Do not re-expand full schema definitions inline in this prompt; keep only the minimum field floor below.

Inline minimum field floor (do not treat this as the full schema):
- Artifact 1 must include: `className`, `methodName`, `legacyEvidence`.
- Artifact 1 optional typed-DB hints for DB-backed methods: `dbParameterTypeHints[]`, `dbResultColumnTypeHints[]`.
- Artifact 2 must include: `controlId`, `wiringKind`, `legacyEvidence`, `wiringStatus`.
- Artifact 3 must include: `workflowId`, `controlId`, `legacyEvidence`, `workflowStatus`.
- Artifact 4 must include: `controller`, `action`, `httpVerb`, `routeTemplate`.
- If no controller or service-behavior evidence is available for `apiEndpointCatalog`, emit an empty array. Do not fabricate placeholder rows such as `UnknownController` or `derived/unresolved`.
- Artifact 5 must include: `controlId`, `migrationEligible`, `requiresWrapperCapability`.
- Artifact 6 must include: `routeId`, `state`, `captureStatus`.
- Artifact 7 must include: `capabilityId`, `legacyControlFamily`, `gapState`.

---

## Legacy Visual Contract Capture (EXTRACT — browser surfaces)

Applies when `detectedModality` is `mvc`, `spa`, or `hybrid`. Skip with an explicit `notApplicable` reason for `api-only`.

This capture is the **answer key** for later visual parity. The legacy visual language is mechanically derivable from legacy source for any application, so capture it from the legacy evidence now instead of recreating it by feel later. Follow `/.github/instructions/ui-capture-reverse-engineering.instructions.md` (`Legacy Visual Contract Capture`) for the reusable capture policy. Keep all captured values app-specific evidence in the report; do not generalize any app's colors, fonts, route names, or brand strings into reusable guidance.

Capture two evidence layers:

- **Static (always, even when the legacy app cannot run):** read the legacy global stylesheets, theme/variable files, and shell markup and record:
  - the theme **palette** — brand, header, primary-action, neutral/border, and semantic colors, including any named token or SCSS variables that define them (with `legacyEvidence`).
  - **typography** — font families, weights, base/label sizes, and every `@font-face` family the legacy app ships, plus the font asset paths.
  - the **shell-chrome regions** — the header, navigation, and footer markup, including the brand element, the navigation link set, and the footer content, with the source file and selector for each region.
  - the **nav route model** — the ordered set of navigation links (label, route/target, order, and any auth gate) the legacy shell renders.
  - **control and label rules** — button variants, form-label styling (size, weight, color, required-field indicator), and input/control sizing that the legacy app depends on for usability.
  - the **per-route field set** — for every data grid/table/list, the displayed columns (`headerLabel` + `boundField`) in route order, plus each route's filter inputs and action controls with the legacy handler each invoked, following `Per-Route Field And Control Capture` in `/.github/instructions/ui-capture-reverse-engineering.instructions.md`. This field/column inventory is the answer key for the Step 13 field-parity reconciliation; a modern grid that later renders real data in fewer or more generic columns than legacy is a column-collapse parity defect.
- **Runtime (when the legacy app is reachable):** during the screenshot capture pass, also record Playwright **computed styles** for the shell-chrome regions and representative controls, and keep a **per-route reference screenshot** for every captured route so the Step 13 visual-parity gate has a route-by-route appearance baseline.

Persist the captured contract as a `legacyVisualContract` block in `.modernization/portal/data/json/legacy-system-analysis-report.json` (palette, typography, shellChromeRegions, navRouteModel, controlAndLabelRules, each with `legacyEvidence`), and keep the per-route reference screenshots under the legacy screenshot baseline. This block is the source Step 5 consolidates into `.modernization/fusion-restructure/styling-foundation.json` and `.modernization/fusion-restructure/ui-visual-contract.json`. When the legacy app could not run, record the static evidence with an explicit `runtimeMeasured: false` marker rather than leaving the contract empty.

---

## Gate Statuses

After running `03-P1-legacy-system-analysis-gate.ps1`, record these three statuses in `step-workflow-state.json` and mirror them in `step-response-ledger.json`:

- `scanCoverageStatus`: `Ready` | `Constrained` | `Blocked`
- `traceabilityStatus`: `Ready` | `Constrained` | `Blocked`
- `planningReadinessStatus`: `Ready` | `Constrained` | `Blocked`

A status of `Constrained` is acceptable for planning progression. `Blocked` means Step 4 cannot start.

---

## Required Response Sections

Return these sections in this order. Keep each one short and factual.

1. **Prerequisite Status** — pass or fail for each STOP 2 input.
2. **QA URL** — which URL was used and how it was resolved (provided / currentQaUrl / currentDevUrl).
3. **Scan Scope** — manifest path, file count by category, exclusions.
4. **Source Stack Fingerprint** — detected families, marker files, confidence, mixed-stack notes.
5. **Artifact Status** — table: each of the 7 artifacts marked `Produced` / `Refreshed` / `Blocked` with one-line reason if blocked.
6. **Screenshot State** — `Captured (N images)`, `CapturedPartial-OperatorReviewed`, or `PendingCapture` with exact blocker class.
7. **Gate Result** — `scanCoverageStatus`, `traceabilityStatus`, `planningReadinessStatus`.
8. **Gaps & Blockers** — unresolved unknowns, cannot-locate backlog count, required manual follow-up.
9. **Step Execution State** — write confirmation for both `.modernization/portal/data/json/step-workflow-state.json` and `.modernization/portal/data/json/step-response-ledger.json`, plus recommended next step.
10. **Readiness Decision** — `Ready for Step 4: Yes` or `Ready for Step 4: No — [reason]`.

### Output Normalization Rules (Deterministic Shape)

- Always return all 10 sections, in the exact order above, for every app modality.
- Never remove a section because a surface is missing. Use explicit placeholders instead.
- Use these exact placeholder values when a section has no applicable data:
  - `NotApplicable` for modality-inapplicable surfaces
  - `NoneDetected` for applicable surfaces with zero discovered items
  - `Blocked` only when a real blocker prevents completion
- In **Artifact Status**, list all 7 artifacts every run. Do not omit rows.
- In **Screenshot State**, always return one of:
  - `Captured (N images)`
  - `CapturedPartial-OperatorReviewed (N images, user approved progression)`
  - `PendingCapture — <blockerClass>`
  - `NotApplicable — <reason>`
- In **Gate Result**, always emit all three statuses even when constrained.
- In **Step Execution State**, always confirm both state artifacts were written for this pass.
- In **Step Execution State**, always include readback fields: `status`, `updatedAt`, `latestFullResponse`, `Updated At`, `Recorded Step`, and `Recommended Next Step`.
- In **Gaps & Blockers**, always include counts:
  - `cannotLocateCount`
  - `unknownBacklogCount`
  - `blockedArtifactCount`

### Deterministic Response Template (Use Exactly)

Use the following heading names exactly as written:

1. `Prerequisite Status`
2. `QA URL`
3. `Scan Scope`
4. `Source Stack Fingerprint`
5. `Artifact Status`
6. `Screenshot State`
7. `Gate Result`
8. `Gaps & Blockers`
9. `Step Execution State`
10. `Readiness Decision`

Inside each heading, keep output to flat bullets or a compact table. Do not add or remove top-level sections.
- `Readiness Decision` must always end with: `Ready for Step 4 Baseline Acceptance-Criteria Review: Yes or No.`

---

## Governing Sources

Policy details that used to live inline in this prompt now live in their canonical locations.
Read these when making evidence and coverage decisions — do not re-derive the rules here.

- Discovery scope and workstream definitions: `AppMod-Process.instructions.md` § Step 3
- Universal UI capture behavior: `.github/instructions/ui-capture-reverse-engineering.instructions.md`
- Reusable screenshot automation and fallback mechanics: `.github/skills/screenshot-capture/SKILL.md`
- Testing behavior families and artifact ownership: `.github/instructions/testing-design-contract.instructions.md`
- Fusion inventory restructure fields: `.github/instructions/fusion-restructure.instructions.md`
- Portal reporting rules (manual only): `.github/instructions/qa-portal-reporting.instructions.md`
- Phase ownership and upstream routing discipline: `.github/instructions/appmod-phase-agent-contract.instructions.md`
