# OpX-Ignition-Kit — file tree (reference)

Transcribed from 5 photos of a generated tree view titled **"FILE TREE CREATION
FOR REPO"**. It is an AI-generated *summary* tree, not raw `tree` output: several
branches are collapsed into parenthesised counts (e.g. `QA/ (~40 scripts: ...)`).
Treat it as a high-quality inventory, not a byte-exact listing. See the
reconciliation notes at the end.

```
OpX-Ignition-Kit/
├── .dockerignore
├── .editorconfig
├── .filenesting.json
├── .gitattributes
├── .gitignore
├── .globalconfig
├── .mcp.json
├── .prettierignore
├── .prettierrc
├── AGENTS.md
├── cspell.json
├── Directory.Build.props
├── exclusion.dic
├── nuget.config
├── PSScriptAnalyzerSettings.psd1
├── README.md
│
├── .github/
│   ├── constitution.md
│   ├── Copilot-Customization-Cheat-Sheet.md
│   ├── copilot-instructions.md
│   ├── agents/
│   │   ├── OpX-AppMod-P1-Discovery.agent.md
│   │   ├── OpX-AppMod-P2-Modernize.agent.md
│   │   ├── OpX-AppMod-P3-Review.agent.md
│   │   ├── OpX-Code-Reviewer.agent.md
│   │   ├── OpX-csharp-expert.agent.md
│   │   ├── OpX-csharp-janitor.agent.md
│   │   ├── OpX-dotnet-upgrade.agent.md
│   │   ├── OpX-Frontend-Angular-Transform.agent.md
│   │   ├── OpX-Fusion-Reviewer.agent.md
│   │   ├── OpX-Fusion-Transform.agent.md
│   │   ├── OpX-fusion-ui-component-upgrade.agent.md
│   │   ├── OpX-Pre-Modernization-Test-Generator.agent.md
│   │   ├── OpX-QA-Create.agent.md
│   │   ├── OpX-QA-Hub.agent.md
│   │   ├── OpX-QA-Run.agent.md
│   │   ├── squad.agent.md
│   │   ├── Ultimate-AppMod-Ignition.agent.md
│   │   └── Ultimate-Ignition-edit.agent.md
│   ├── contracts/schemas/
│   │   ├── executable-testcase-catalog.schema.json
│   │   ├── fusion-control-point-inventory.schema.json
│   │   ├── fusion-decisions.schema.json
│   │   ├── fusion-migration-plan.schema.json
│   │   ├── modernization-execution-contract.schema.json
│   │   ├── modernization-phase-assessment.schema.json
│   │   ├── modernization-solution-design.schema.json
│   │   ├── per-route-behavior-plan.schema.json
│   │   ├── step-workflow-state.schema.json
│   │   └── README.md
│   ├── instructions/
│   │   ├── agent-integrity-checks.instructions.md
│   │   ├── agent-process-conformance.instructions.md
│   │   ├── agent-toolkit-protection.instructions.md
│   │   ├── angular.instructions.md
│   │   ├── appmod-agent-personality-baseline.instructions.md
│   │   ├── AppMod-Artifact-Contract.json
│   │   ├── appmod-phase-agent-contract.instructions.md
│   │   ├── AppMod-Process.instructions.md
│   │   ├── AppMod-Step-Contract.json
│   │   ├── copilot.instructions.md
│   │   ├── dotnet.instructions.md
│   │   ├── frontend-modernization-learning.instructions.md
│   │   ├── fusion-mcp-restructure.instructions.md
│   │   ├── fusion-restructure.instructions.md
│   │   ├── kit-update.instructions.md
│   │   ├── modernization-deep-scan-checklist.instructions.md
│   │   ├── modernization-starter-boundaries.instructions.md
│   │   ├── powershell-script-maintenance.instructions.md
│   │   ├── qa-portal-reporting.instructions.md
│   │   ├── step-confidence-contract.instructions.md
│   │   ├── testing-design-contract.instructions.md
│   │   ├── tests-commenting.instructions.md
│   │   └── ui-capture-reverse-engineering.instructions.md
│   ├── prompts/
│   │   ├── 01-P1-workstation-readiness.prompt.md
│   │   ├── 02-P1-rename-starter-to-appname.prompt.md
│   │   ├── 03-P1-legacy-system-analysis.prompt.md
│   │   ├── 04-P1-baseline-acceptance-criteria-review.prompt.md
│   │   ├── 05-P1-modernization-solution-design.prompt.md
│   │   ├── 06-P1-modernization-quality-design.prompt.md
│   │   ├── 07..18 (P2 + matching QA pairs)
│   │   │     backend-upgrade-dotnet, backend-modernization-formation,
│   │   │     backend-dotnet-integration-hardening, frontend-foundation-and-scaffold,
│   │   │     frontend-migration, frontend-platform-integration,
│   │   │     frontend-shell-stabilization, frontend-ui-inventory-and-fusion-map,
│   │   │     fusion-ui-integration, next-fusion-ui-upgrade-slice,
│   │   │     rewire-all-tests-and-verify, deployment-and-clean-up
│   │   ├── 19-P3-final-fusion-restructure-review.prompt.md
│   │   ├── 20-P3-final-verification.prompt.md
│   │   ├── 21-P3-figma-review.prompt.md
│   │   ├── 22-P3-final-acceptance-criteria-review.prompt.md
│   │   ├── 23-P3-final-readiness-review.prompt.md
│   │   ├── 24-P3-technical-review.prompt.md
│   │   ├── README.md
│   │   ├── OpXUtil/        (app-assessment, fresh-history-publish, scoped-branch-sync,
│   │   │                    sonatype-prod-standardize, AppAssessment CSV)
│   │   ├── P1-Discovery/   (generate-tests, legacy-unit-test-baseline, runtime-verifier-routes)
│   │   ├── P2-Modernize/   (10 prompts: angular-to-browser-client, cleanup, fix-violations,
│   │   │                    frontend-fusion-ui-*, frontend-shell-stabilization,
│   │   │                    frontend-ui-inventory-fusion-map, integration-hardening-routing,
│   │   │                    mvc-to-browser-client)
│   │   ├── P3-Review/      (compliance-report-routing)
│   │   └── qaTestPrompts/  (17 prompts: qa-confidence, qa-core-*, qa-create-actions,
│   │                        qa-hub-routing, qa-lane-*, qa-legacy-characterization,
│   │                        qa-plan-strategy, qa-report-portal, qa-reset-rollback,
│   │                        qa-run-actions)
│   ├── scripts/
│   │   ├── capture-modern-screenshots.ps1
│   │   ├── run-modern-api.ps1
│   │   ├── run-modern-client.ps1
│   │   ├── maintenance/    (audit-modernization-pollution, audit-step-number-drift)
│   │   ├── P1-Discovery/   (17 scripts: 02-P1-run-src, 03-P1-*, 04-P1-*, config,
│   │   │                    discover-legacy-routes, generate-design-system,
│   │   │                    publish-*, render-status-report, replace-deploy-values,
│   │   │                    run-dual-runtime, step6-refresh-qa)
│   │   ├── P2-Modernize/   (generate-angular, generate-restructure-inventory,
│   │   │                    legacy-screenshot.mjs, parity-score.mjs,
│   │   │                    scrape-legacy-fragments.cjs, verify-coverage,
│   │   │                    verify-modernization-patterns)
│   │   ├── parity/         (11 scan-*/selftest-*/verify-gate-integrity scripts)
│   │   ├── QA/             (~40 scripts: qa-refresh-portal, qa-run-*, probe-*,
│   │   │   └── portal/      generate-*, publish-frontend-evidence.js, qa-common, ...)
│   │   ├── shared/         (field-contract, Invoke-StepReconciliation,
│   │   │                    verify-step-artifacts, verify-upgrade-invariants)
│   │   ├── step0/          (reset-step-zero-state, update-*-extension,
│   │   │                    update-start-here-status)
│   │   └── Workspace/      (backup/restore-src-and-legacy-baseline,
│   │                        Invoke-ScopedBranchSync, Invoke-StepRestorePoint,
│   │                        reset-src-and-tests-to-starter-handoff)
│   ├── skills/
│   │   ├── appmod-backend-dotnet/SKILL.md
│   │   ├── appmod-frontend-angular/SKILL.md
│   │   ├── appmod-fusion-target/SKILL.md
│   │   ├── appmod-modernization-process/SKILL.md
│   │   ├── appmod-testing-and-gates/SKILL.md
│   │   ├── architecture-structure/          (SKILL + Architecture-Structure, REMAINING-POINTS)
│   │   ├── browser-source-decomposition/SKILL.md
│   │   ├── diagnose/SKILL.md
│   │   ├── dominion-requirements/           (SKILL + AppMod-Acceptance-Criteria)
│   │   ├── fusion-feature-standards/        (SKILL + fusion-auth-standards)
│   │   ├── fusion-g1-to-g2-modernization/   (SKILL + references/)
│   │   ├── fusion-restructure-review/SKILL.md
│   │   ├── fusion-ui-component-upgrade/SKILL.md
│   │   ├── ignition-kit-maintenance/        (SKILL + 9 references/)
│   │   ├── legacy-local-run/                (SKILL + references/ + scripts/)
│   │   ├── runtime-parity-checkpoint/SKILL.md
│   │   ├── screenshot-capture/              (SKILL + 3 capture scripts)
│   │   ├── step3-legacy-system-analysis/    (SKILL + references/)
│   │   ├── test-quality-standards/SKILL.md
│   │   ├── visual-parity-gate/              (SKILL + fusion-client-foundation-templates/*.scss)
│   │   └── workstation-playwright-setup/SKILL.md
│   └── templates/
│       ├── AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md
│       └── COMPLIANCE-ANALYSIS-REPORT.template.md
│
├── .modernization/
│   ├── .readme/
│   │   ├── .Ignition-Kit-Start-Here.md
│   │   ├── .StepSummary.md
│   │   ├── AboutTheKit.md
│   │   ├── App-Development-Requests.md
│   │   ├── HowToRun.md
│   │   ├── kit-params.md
│   │   ├── Prerequisites.md
│   │   ├── VibeCodingTips.md
│   │   └── user-provided-info/README.md
│   └── OpXUtil/
│       ├── .conversation/              (analysis notes + overview/ SVGs for phases 1-3)
│       ├── Additional-Files/Intake.xlsx
│       ├── archive/                    (collapsed: archived .github assets, retired prompts,
│       │                                copilot-extensions, journaling constitution)
│       ├── notes/                      (FutureToDo, sql-param-type-drift)
│       └── training/                   (6 training/demo/handout docs)
│
├── .squad/
│   ├── .first-run, ceremonies.md, config.json, decisions.md, routing.md, team.md
│   ├── agents/         (backend, docs, fact-checker, frontend, lead, Rai,
│   │                    ralph, reviewer, scribe, security, tester -> charter/history)
│   ├── casting/        (history.json, policy.json, registry.json)
│   ├── fact-checker/   (audit-trail.md, policy.md)
│   ├── identity/       (now.md, wisdom.md)
│   ├── memory/         (audit.jsonl, config.json, index.json)
│   ├── rai/            (audit-trail.md, policy.md)
│   ├── templates/
│   │   ├── (30+ reference/template md + json files)
│   │   ├── casting/Futurama.json
│   │   ├── identity/          (now.md, wisdom.md)
│   │   ├── scripts/notes/     (fetch.ps1, write-note.ps1)
│   │   └── skills/            (50+ SKILL.md: agent-conduct, git-workflow, humanizer,
│   │                           model-selection, ralph-*, reflect, secret-handling, ...)
│   └── workflows/      (11 squad-*.yml GitHub Actions)
│
├── .vscode/
│   ├── extensions.json
│   ├── settings.json
│   └── tasks.json
│
├── LegacyCode/
│   └── test.txt
│
└── src/
    ├── Starter.Library/
    │   ├── Starter.Library.csproj
    │   ├── Entities/MyEntity.cs
    │   ├── Extensions/FusionApplicationBuilderExtensions.cs
    │   ├── Options/MyOptions.cs
    │   └── Services/            (MyService.cs, PublicTextService.cs)
    ├── Starter.Web.Api/
    │   ├── Starter.Web.Api.csproj, Program.cs, AppInfo.xml, web.config, entrypoint.sh
    │   ├── appsettings.json, appsettings.Development.json
    │   ├── Controllers/         (MyEntitiesController.cs, PublicTextController.cs)
    │   ├── Extensions/FusionWebBuilderExtensions.cs
    │   ├── Models/              (MyModel.cs, MyModelSearch.cs, PublicTextResponse.cs)
    │   └── Properties/launchSettings.json
    └── Starter.Web.Client/
        ├── Starter.Web.Client.esproj, angular.json, package.json, package-lock.json
        ├── eslint.config.js, tsconfig*.json, nginx.conf, default.conf, AppInfo.xml
        ├── .npmrc, .dockerignore, .vscode/
        ├── scripts/             (build, clean, install, npm-clean, npm-safe-package-installs,
        │                         pre-build, pre-start, tools, update - .mjs)
        └── src/
            ├── index.html, main.ts, styles.scss, web.config, favicon.ico
            ├── app/
            │   ├── app.component.{ts,html,scss,spec.ts}, app.config.ts
            │   ├── fusion.config{,.base,.dv1,.qa,.uat,.prd}.ts
            │   ├── routes.config.ts, types.ts
            │   ├── components/.gitkeep
            │   ├── pages/       (common-components, home, my-entity, test-datastore)
            │   └── services/    (my-entities, public-text, test-datastore)
            └── assets/icons/    (8 PNG sizes)
```

## Reconciliation against this import

### Transcription coverage

| Area | On disk | Transcribed | Gap |
|---|---|---|---|
| `.github/instructions/` | 23 | 21 complete + 2 partial | `AppMod-Step-Contract.json` (untouched), `testing-design-contract` (pending), `ui-capture-reverse-engineering` (partial), `agent-integrity-checks` (notes only), `AppMod-Artifact-Contract.json` (horizontally truncated) |
| `.github/agents/` | 18 | 11 | `OpX-Code-Reviewer`, `OpX-Fusion-Transform`, `OpX-Pre-Modernization-Test-Generator`, `OpX-QA-Create`, `OpX-QA-Hub`, `OpX-QA-Run`, `squad.agent.md` |
| `.github/skills/` | 21 folders | 12 folders | `browser-source-decomposition` (done), `ignition-kit-maintenance`, `legacy-local-run`, `screenshot-capture`, `test-quality-standards` + the folder-level extras |
| `.github/prompts/` | 24 numbered + 4 subfolders | 24 numbered | `OpXUtil/`, `P1-Discovery/`, `P2-Modernize/` (10), `P3-Review/`, `qaTestPrompts/` (17) — **~32 prompts untouched** |
| `.github/contracts/schemas/` | 9 schemas + README | 0 | all |
| `.github/templates/` | 2 | 2 | none |
| `.github/scripts/` | ~100+ | 0 | all (referenced only) |
| `.squad/` | large | 0 | all — see below |

### Things this tree resolves

1. **The 18-agent question.** `.github/agents/` holds exactly 18 files. Compared
   to the Definitive Agent List in `agent-toolkit-protection.instructions.md`:
   - **On disk but not on the list:** `OpX-Frontend-Angular-Transform` (already
     flagged as archived-but-installed) and `squad.agent.md`.
   - **On the list but not on disk:** `modernize-dotnet` and `Microsoft-Researcher`.
   Both directions now confirmed. The list needs two removals and two additions.
2. **`screenshot-capture` and `test-quality-standards` exist** — both were flagged
   as "named but never photographed". They are real:
   `screenshot-capture/` (SKILL + 3 capture scripts) and
   `test-quality-standards/SKILL.md`.
3. **Two skills never mentioned anywhere in the transcribed files:**
   `ignition-kit-maintenance/` (SKILL + **9** references) and `legacy-local-run/`
   (SKILL + references + scripts). `ignition-kit-maintenance` is referenced by
   `powershell-script-maintenance.instructions.md` and `kit-update`, so it is
   load-bearing for kit maintenance.
4. **`LegacyCode/` ships containing only `test.txt`** — the kit is distributed
   with an empty legacy slot, confirming Step 1's "copy legacy code in" instruction.
5. **`src/` ships as `Starter.*`** — `Starter.Library`, `Starter.Web.Api`,
   `Starter.Web.Client` — which is exactly what Step 2 renames to `<AppName>.*`.
   `Starter.Web.Client.esproj` confirms the `.esproj` extension read.
6. **`fusion.config` has five environment variants**: `.base`, `.dv1`, `.qa`,
   `.uat`, `.prd`. No transcribed file lists them.

### Things this tree raises

1. **★ `.github/scripts/maintenance/audit-step-number-drift` already exists.**
   The kit ships a step-number-drift auditor. Every numbering finding in this
   import may already be detectable by a script nobody has run. Its sibling is
   `audit-modernization-pollution`. **These two scripts are now the highest-value
   unread files in the kit** — they may make the linter recommendation moot.
2. **`discovery-runner.instructions.md` and `step-registry.json` are absent from
   this tree** — yet `AGENTS.md`, `.squad/`, and `squad.agent.md` are present, and
   `tools/appmod/` (referenced constantly by `copilot-instructions.md`) is absent
   too. The most likely explanation is that this tree is a **snapshot from a
   different point in the merge** than the files photographed later. Do not treat
   the absences as proof those files do not exist — they were photographed
   directly. Worth confirming which snapshot is current.
3. **`.squad/` here is far larger than the Squad in this repo.** It carries
   `casting/`, `fact-checker/`, `identity/`, `memory/`, `rai/`, 11 GitHub Actions
   workflows, 30+ templates, and **50+ template skills** (agent-conduct,
   git-workflow, humanizer, model-selection, ralph-*, reflect, secret-handling).
   Agents include `Rai`, `ralph`, `scribe`, `docs`, `fact-checker`, `security`.
   This is a different, much larger Squad distribution than the kit in this
   workspace.
4. **`OpXUtil/notes/sql-param-type-drift`** exists — the same defect class
   `dotnet.instructions.md` documents at length (`AddWithValue` inferring
   `SqlDbType.Int`). Provenance for that section.
5. **`.mcp.json` at the repo root** — the Fusion MCP server configuration that
   `fusion-mcp-restructure.instructions.md` depends on.
6. **`qaTestPrompts/` holds 17 prompts and `P2-Modernize/` holds 10** — roughly
   32 prompts outside the numbered 24, none transcribed. `qa-core-workflows` is
   named as an authority by `AppMod-Process.instructions.md`.
