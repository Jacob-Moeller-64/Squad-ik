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
