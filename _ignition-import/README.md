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
