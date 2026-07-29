---
name: appmod-ignition-operations
description: Supplemental AppMod-Ignition operating rules for repo maintenance, status reporting, build/run behavior, naming, and modernization conventions.
---

# Copilot instructions for this repo
<!-- Use this throughout app mod process so copilot does not do stuff like create extra files we don't want.-->

## Purpose (keep this file operational)
This file is a task-discoverable supplement for AppMod-Ignition workspace operations. The concise always-on repository entrypoint is `.github/copilot-instructions.md`.

Do not duplicate program policy here.

Note: QA prompt sets in `.github/prompts/qaTestPrompts/` may use a local master prompt. Treat those references as valid within that prompt family.

## Precedence (avoid contradictions)
When guidance conflicts:
1) The current user request and active AppMod-Ignition guidance in the workspace.
2) `.github/copilot-instructions.md`: concise always-on repository guidance.
3) `.github/instructions/AppMod-Process.instructions.md` and `.github/instructions/AppMod-Step-Contract.json`: process sequence and route authority.
4) This file: detailed AppMod-Ignition operational guidance.
5) Targeted language, security, and path-scoped instruction files for the files they cover.

## Rerun behavior (required)
For ordinary non-step local reruns, when the user says "rerun" or asks to rerun after changes, do this without asking again:
1) Free the last-used dev port for the target app.
2) If the app has a frontend, rebuild the frontend bundles (use the app's real `package.json` scripts; do not guess commands).
3) Rebuild the backend.
4) Run the app on that same last-used port so bundles and runtime match.

Always confirm you performed these steps.

Before rerunning a completed numbered step or any step-owned refresh or workflow that can rewrite numbered-step state, make the rerun gate explicit unless the user already requested it. A direct numbered-step button click, slash command, or named-step request is that explicit approval for the exact step invoked, so do not ask twice. In all cases warn that the rerun can change recorded step status, portal summaries, or the recommended next step.

## Artifacts / generated files
- Avoid creating loose `.md`, `.txt`, and `.log` files.
- Status reports are the exception and must live here:
  - `.modernization/ignition-artifacts/status/<AppName>/STATUS_REPORT.md`
- If you must generate logs/diagnostics, place them under `.modernization/ignition-artifacts/status/<AppName>/_artifacts/` and keep them short-lived.
- Parity evidence JSON is allowed under testing artifacts:
  - `.modernization/portal/data/parity/parity.json`
- Documentation standard for modernized apps:
  - Only keep two primary docs for modernization tracking:
    - `STATUS_REPORT.md` (single source of truth for status + blockers + parity/acceptance notes)
    - `README.md` when the repo keeps one, otherwise `/.modernization/.readme/HowToRun.md` for exact local run steps and current DevOps or CI location
  - Do not create additional standalone modernization/parity/remaining-work/checklist markdown files. If that content is needed, merge it into `STATUS_REPORT.md`.
  - When a markdown file uses pipe tables, pad each column so headers, separator rows, and data cells align visually in raw source.
  - When any cell in a markdown table changes, realign the full table block before finishing the edit.

## How to maintain this file (rules)
- Treat user-provided notes as authoritative: incorporate them here so the user doesn't need to repeat them.
- Keep updates repo-specific and discoverable (tie guidance to files/paths or observed behavior; avoid aspirational rules).
- When new guidance conflicts with old guidance, update/replace the old guidance instead of appending duplicates.
- Prefer concise, actionable bullets; avoid generic advice.
- Do not assume `rg` or ripgrep is installed in the current shell. Check availability first; if it is missing, use workspace search tools or PowerShell `Select-String`.
- Ask at most 1-3 clarifying questions only when a note is ambiguous or could break compatibility.
- Continue updating this file as the user supplies new rules; stop only when the user explicitly says "I am done."

## Operating principles (Copilot behavior)
- Prefer steps and short todo lists for multi-step work.
- Match existing project conventions (naming, structure, patterns) unless explicitly told to change them.
- When editing reusable toolkit assets under `.github/`, `.modernization/`, `.vscode/`, or `starter-deploy/`, do not encode the current validation app's routes, controller names, entities, labels, or workflow names as durable guidance. Capture the reusable strategy instead.
- If something is ambiguous and the ambiguity changes behavior, architecture, ownership, or risk in a meaningful way, ask 1-3 clarifying questions and propose a best default path.
- If the current active step fails for one clear, local, deterministic reason and the remediation is in scope, perform that remediation and rerun the step proof inside the same active pass without waiting for the user to say `yes`, `continue`, or `retry`.
- Do not reopen a completed numbered step, or run a step-owned refresh that can rewrite numbered-step status, as implicit remediation. Get explicit user approval first when it was not already requested. A direct numbered-step button click, slash command, or named-step request counts as that approval for the exact step invoked, and you should still warn that the rerun can change recorded step status, portal summaries, or the recommended next step.
- Do not return `Blocked` while a single obvious same-step remediation remains untried inside the current workspace.
- Never guess when multiple materially different paths exist: provide options with tradeoffs and ask for a decision when needed.
- Explain actions simply and clearly (what you did, what you'll do next, why).

## Autonomous remediation contract (required)
- Treat reruns, retries, artifact refreshes, test creation expected by the current active step, dependency restore, and evidence resync as normal execution inside that active step or QA workflow, not as optional follow-up work.
- Do not treat rerunning a completed numbered step, or a status-writing artifact refresh for another completed step, as implicit housekeeping. Require explicit user approval unless it was already requested, and warn that the rerun can change recorded step status, portal summaries, or the recommended next step.
- Keep `.modernization/portal/data/json/step-workflow-state.json`, `.modernization/portal/data/json/step-response-ledger.json`, and `/.modernization/.readme/.StepSummary.md` current after numbered-step execution so the next-step runner can explain and continue the workflow truthfully.
- After saving numbered-step state, run `/.github/scripts/shared/Invoke-StepReconciliation.ps1 -Step <N>` so the Step Summary is regenerated from the saved state instead of relying on manual edits.
- When a numbered step starts, immediately write `InProgress` to those JSON artifacts and keep `startedAt`, `heartbeatAt`, `percentComplete`, `estimatedMinutesRemaining`, `estimatedCompletionAt`, and `currentActivity` current at meaningful checkpoints.
- Treat `.modernization/portal/data/json/step-workflow-state.json` as the authoritative operator-facing step-state source. The portal is a derived view and must not override that saved state.
- Do not stop with the saved step status still `InProgress`. End the step as `Completed`, `Blocked`, or `Failed`.
- Use `Blocked` only when the remaining path depends on external input, an unavailable prerequisite, or a materially ambiguous decision after same-step remediation was attempted or ruled out.
- Use `Failed` when a required checkpoint reached a definite negative outcome and no truthful in-scope recovery path remains in the current pass.
- When a failure is caused by stale evidence, missing but creatable step-owned tests, a missed restore, a paused portal-publication path, a missing compatibility alias, or a similar deterministic gap, fix it and rerun before reporting status.
- Escalate instead of auto-remediating only when any of these are true:
  - the next move would be destructive or hard to reverse,
  - the next move needs user intent or product judgment,
  - the next move depends on credentials, permissions, or external systems you cannot access,
  - the next move would cross into a different numbered step with materially different work,
  - or the first remediation attempt disproved the original hypothesis.
- When a step remains blocked after self-healing attempts, report the blocker together with the exact remediation attempts already made so the user does not have to suggest the obvious next pass.

## Change communication for code edits (required)
- When making code changes, communicate four things in simple English:
  1. what will change,
  2. what behavior must remain the same,
  3. what tests must be added or updated,
  4. the main risks.
- Treat this as an AI safety communication rule for code changes.
- This does not require a rigid pre-edit ritual. The important rule is that the intended behavior, test impact, and risks are communicated clearly during the task.
- Default to behavior preservation first. Modernize structure, safety, readability, and maintainability without casually changing workflows, response shapes, routes, calculations, or visible UI behavior.

## Engineering standards (required)

### Behavior-preserving modernization
- Preserve existing behavior first unless the user explicitly asks for a behavior change.
- Prefer small, verifiable slices over broad rewrites.
- Keep the legacy user workflow, API contract, validation behavior, and visible UI behavior stable while modernizing code structure.

### Architecture and design
- Favor clean architecture or the documented simple architecture shape already chosen for the repo.
- Keep responsibilities separated and dependencies easy to trace.
- Apply SOLID principles in practical, readable ways.
- Avoid spaghetti code, hidden coupling, and clever cross-layer shortcuts.
- Prefer boring, obvious code over clever code unless the cleverness is clearly necessary and documented.

### Readability and maintainability
- Optimize every changed file for an entry-level developer to follow.
- Prefer tutorial-level clarity: obvious names, short methods, linear control flow, and explicit intermediate variables when they improve comprehension.
- Avoid dense one-liners, cryptic helper chains, and compressed abstractions that make debugging harder.
- Break up god classes, overgrown components, and mixed-responsibility files when the current task touches them enough to do so safely.

### Comments and file headers
- Be more aggressive with comments than a typical production repo.
- Every new or modified source, test, and important configuration file should contain enough comments for a junior developer and QA reviewer to understand the file quickly.
- Important files should start with a short header comment that explains:
  - the file purpose,
  - the main behavior or responsibility,
  - key dependencies or collaborators,
  - any notable safety or parity constraints.
- Inside the file, use very simple English comments to explain intent, sequence, and tricky decisions.
- Do not rely on comments to excuse bad structure. First make the code simpler, then comment the remaining important intent.

### Modern .NET standards
- Prefer current .NET hosting, DI, async/await, `IOptions<T>`, `ILogger<T>`, typed clients, health checks, and structured error handling.
- Prefer policy-based authorization, environment-aware configuration, and dependency-injected services.
- Keep APIs explicit, versionable, and easy to test.

### Modern Angular standards
- Prefer standalone components, signals, accessible markup, service-owned API calls, and Playwright-ready semantics.
- Keep templates simple, declarative, and easy to scan.
- Prefer semantic HTML, stable accessible names, and test-friendly structure from the start.

### API standards
- Keep controllers and endpoints thin, explicit, and predictable.
- Preserve contract shapes unless a change is intentional and documented.
- Validate inputs clearly, return meaningful HTTP responses, and keep business logic out of controllers.

### Testing standards
- Treat testability as part of implementation, not cleanup.
- Add or update tests whenever behavior-bearing code changes.
- Generated or updated tests must be Gherkin-style with explicit comments and metadata.
- Required test header comments:
  - `CaseId`
  - `Scenario`
  - `Description`
  - `Input`
  - `Expected`
- Required test body flow comments:
  - `Given`
  - `When`
  - `Then`
- Keep test wording extremely simple and concrete.

### QA and Playwright readiness
- Build UI and API surfaces so QA can exercise them easily.
- Prefer stable semantic selectors, accessible names, and deterministic setup.
- New UI work should be Playwright-friendly from the start.

### Security, logging, and error handling
- Secure by default: no hardcoded secrets, no unsafe auth shortcuts, no injection-prone query construction.
- Use structured logging and meaningful error handling.
- Catch exceptions only when doing something useful such as translation, cleanup, retry, or controlled fallback.
- Keep logs readable for operators and safe for compliance.

### Configuration standards
- Keep configuration externalized and environment-specific.
- Prefer strongly typed options and named sections over scattered ad hoc config lookups.
- Never hardcode environment-specific values when configuration is the correct home.

### Accessibility standards
- Treat accessibility as a default engineering requirement, not a polish pass.
- Prefer semantic markup, keyboard-friendly flows, labels, roles, and accessible names.
- Build UI so both users and Playwright can understand it through the same meaningful structure.

### Git and change hygiene
- Keep changes focused and easy to review.
- Do not mix unrelated refactors into behavior-preserving work unless they are required for safety or clarity.
- Prefer small diffs that clearly communicate intent and risk.

Change-capture rule (required):
- If the user says something that should be recorded into prompts/instructions/agents/constitution, call it out explicitly and ask: "Add it? (y/n)".

## Repo layout (what to edit)
- This workspace contains a legacy reference app under `LegacyCode/` and the active modernized code under `src/` and `tests/`.
- Do not modify the legacy reference app unless the task explicitly targets `LegacyCode/` for inventory or review work.
- Treat `src/` and `tests/` as the canonical modernized code locations for this workspace.
- When creating new tests inside `LegacyCode/`, create characterization tests only, and place them under the owning `Characterization/` folder for that legacy test project. Do not create new non-characterization tests outside that folder.
- Characterization folders may contain behavior-capture tests expressed as unit, integration, contract, frontend, backend, end-to-end, or Playwright-style proof. The goal is to preserve observed behavior, not to enforce an idealized notion of correctness.
- For any file under `tests/`, also follow `.github/instructions/tests-commenting.instructions.md` so test cases, helpers, scripts, configs, and project files all stay at tutorial-level comment density.

## Ownership boundaries (do not surprise teammates)
- Only edit canonical repo-owned modernization and toolkit outputs unless the user explicitly approves a wider scope:
  - `src/**`
  - `tests/**`
  - `.modernization/**`
- Treat external worktrees, team/member-named folders, and path roots outside this repo's canonical modernization workspace as read-only unless the user explicitly approves them.
- If a path includes a person's name or an external team/workspace marker, treat it as read-only and do not use it as an authoritative source without explicit approval.

## Security hygiene (behavior)
- Never add secrets (keys, passwords, connection strings with creds) to the repo or container images.
- Avoid logging secrets/PII; redact if needed.

## npm feed policy (required)
- Treat Sonatype as the required npm source for package install and restore workflows in this repository.
- Do not use external npm registries or one-off alternate feeds during troubleshooting unless the user explicitly approves that exception.

## Fusion package version policy (required)
- For Fusion package additions or upgrades, use the latest production version available in Sonatype feeds.
- Applies to both NuGet (`Fusion.*`) and npm (`@fusion/*`) package references.
- Do not pin new package guidance to stale example versions when a newer production Sonatype version exists.
- Use Fusion MCP package/docs discovery to identify package families and APIs, and use Sonatype feeds to resolve the production version to install.

## Modernization behavior (Copilot behavior)
- Preserve behavior unless explicitly approved to change it.
- Prefer an incremental migration path that can be merged safely first.
- Avoid introducing new dependencies unless explicitly requested or approved.
- Don't mix styles: keep changes consistent with the existing codebase.
- During reverse engineering and characterization planning, generalize findings into behavior families, artifact families, evidence rules, and derivation strategies that can be reused across many applications. Keep app-specific facts in generated app artifacts or addenda, not in reusable kit instructions.

## Naming law (required)
- Golden Rule: never mix naming styles inside the same layer.
- Backend and test projects that compile under .NET or C# must use PascalCase for solution names, project names, folders, namespaces, and `.csproj` file names.
- Angular frontend project roots must use the app-named `.Web.Client` form, for example `src/<AppName>.Web.Client` and `<AppName>.Web.Client.esproj`.
- Angular-owned selectors and ordinary Angular file or folder names inside that client root should continue to use Angular-appropriate kebab-case where applicable.
- Cross-layer references must preserve each layer's native naming style instead of forcing one shared casing scheme.
- If a modernization step materializes starter content with mixed casing, fix the names at the rename stage before continuing.

## Modernization patterns
- When modernizing covered .NET, TypeScript, project, or startup files, go directly to the intended Fusion-aligned pattern instead of making an intermediate generic-modern rewrite that will need to be replaced later.
- Use the starter projects in `src/` as the working reference for Fusion-aligned hosting, configuration, logging, and frontend structure.
- For backend database runtime configuration, default to this deployment assumption unless repo evidence says otherwise: OpenShift/Kubernetes split SQL environment variables (`SqlServer__Server`, `SqlServer__Database`, `SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`, `SqlServer__TrustServerCertificate`) composed once at startup into `ConnectionStrings`.
- Prioritize modernization work in this order:
  1. Security and authentication concerns
  2. Breaking or deprecated runtime patterns
  3. Fusion wiring and hosting/configuration structure
  4. Logging modernization
  5. Angular and frontend modernization patterns
  6. Style-only cleanup

### .NET hosting model
- Prefer minimal hosting in `Program.cs`.
- Move DI registration into the existing Fusion application builder extensions.
- Move middleware wiring into the existing Fusion web builder extensions.
- Remove legacy `Startup.cs` hosting patterns when the target has been migrated to the current Fusion style.

### Logging
- Replace legacy debug, console, log4net, and string-concatenated logging with injected `ILogger<T>` and structured message templates.
- Prefer built-in .NET logging infrastructure over third-party legacy logging frameworks unless explicitly required by the active target.

### Authentication and authorization
- Okta is the required final authentication model.
- Legacy auth may be retained temporarily only to preserve parity during modernization, but it must not be treated as the final target state.
- Keep auth configuration in settings, not hardcoded.

### Configuration
- Prefer the options pattern over `ConfigurationManager` or ad hoc config access.
- Bind settings from named configuration sections and inject them via `IOptions<T>`.

### Async and external calls
- Remove sync-over-async patterns like `.Result`, `.Wait()`, sync database calls, and blocking sleeps when the async equivalent is available.
- Prefer `IHttpClientFactory`-based typed clients over manually instantiating `HttpClient`.

### SPA and deployment model
- Treat the Angular frontend as a separate project and deployment unit from the .NET API.
- Remove legacy embedded SPA hosting patterns when the target uses separate API and client projects/containers.
