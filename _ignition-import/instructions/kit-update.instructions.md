---
name: kit-update-instructions
description: Kit-specific guardrails for editing reusable modernization toolkit files. For communication, execution, research, and obstacle-handling guidance, see appmod-agent-personality-baseline.instructions.md.
applyTo: ".github/**,.modernization/**,.vscode/**,.readme/**"
---

# Kit Update Context

> Purpose: Toolkit-specific guardrails before changing reusable modernization assets under `.github/`, `.modernization/`, and `.vscode/`.
>
> For execution behavior, communication patterns, web research strategy, and obstacle handling, refer to `.github/instructions/appmod-agent-personality-baseline.instructions.md`.

## Scope

- This file is for editing the Ignition Kit itself: reusable assets under `.github/`, `.modernization/`, and `.vscode/`.
- It is not the process guide for modernizing a random application. That process belongs in the shared modernization-process context used by developers and agents during modernization.
- When changing the Ignition Kit, keep the distinction clear between:
  - toolkit-maintenance guidance that belongs here, and
  - developer-facing modernization workflow guidance that belongs in the shared process-sequence file at `/.github/instructions/AppMod-Process.instructions.md`.

## File Organization Model

**Reusable toolkit assets** belong under:
- `/.github/` - prompts, agents, instructions, skills, scripts
- `/.modernization/.readme/` - developer-facing quick-start and local run guidance
- `/.modernization/OpXUtil/` - guidance, training, reference material
- `/.vscode/` - workspace configuration

**App-specific runtime outputs** belong under:
- `/.modernization/ignition-artifacts/` - generated evidence (local only, not shipped)
- `src/`, `LegacyCode/` - application code (may be shipped when app is published)

-## Canonical Context Paths

- Canonical shared toolkit and workflow instruction documents live under `/.github/instructions/`.
- Reusable operator utility prompts (assessment helpers, history-publish helpers, repo standardization helpers, etc.) that should not appear in the numbered modernization flow live under `/.github/prompts/OpXUtil/`. They are still toolkit-shipped and discoverable; the `OpXUtil/` subfolder simply signals "operator-only, not part of the 24-step sequence."
- Keep `/.github/instructions/` focused on concise guardrails. Place deep reusable guidance under the owning skill and its `references/` folder.
- `/.modernization/OpXUtil/` is reserved for per-clone working state that is NOT shipped to new kit users: `.conversation/` review notes, `.github-archive/` retired material inside `archive/`, and `CHANGELOG.md`. It MUST NOT hold reusable prompts, scripts, or instruction files; those belong under `/.github/`.
- `/.modernization/OpXUtil/archive/**` is archival-only. Do not read, search, or edit this tree during normal maintenance unless the user explicitly requests historical recovery or archive forensics.
## Editing Guardrails

### File Protection

- **Do not hard-code** the current app name into reusable toolkit files. Use `<AppName>` placeholders.
- **Store app identity only** in `/.modernization/.readme/kit-params.md`.
- **When scripts need the current app**, derive `appName` from `kit-params.md` at runtime.
- **`.modernization/.gitignore` is a committed toolkit file** - it defines exclusions for modernization outputs and must never be generated or created by scripts. It is maintained as a reusable toolkit asset only. Any script that accidentally creates an untracked copy will have it removed by defensive cleanup in `/.github/scripts/P1-Discovery/config.ps1`.

### Naming in Guidance

- Avoid app-shaped sample feature names, controller names, or entity names in reusable toolkit wording.

## Branch Integration

When bringing changes from a non-main validation branch back to `main` or `main-dev`:

- Default scope: toolkit-only integration (`/.github/**`, `/.modernization/OpXUtil/**`, `/.vscode/**`)
- Exclude by default: `LegacyCode/**`, `src/**`, local-only runtime folders under `/.modernization/` unless explicitly requested
- Require explicit user request if you want app-validation content (`src/`, `LegacyCode/`, local `.modernization/` artifacts) to flow upstream

For protected merge flows with detailed validation rules, see `/.github/skills/ignition-kit-maintenance/references/branch-integration-policy.md`.

## Process-Documentation Terminology

- In Ignition Kit workflow documentation, prefer `step` over `handoff` when describing the readable modernization process.
- Treat the modernization workflow as:
  - 3 phases,
  - each phase containing multiple steps,
  - with step numbers forming one global sequence across the entire process.
- Each step represents a major, human-followable unit of discovery, modernization, review, or validation.
- A numbered step may contain internal checklist items, repeated page-by-page work, or substeps. Not every repeated action or verification activity needs its own numbered step.
- Each completed step should have an expected QA flow or QA checkpoint associated with it.
- QA may be the validation that follows a step rather than its own separately numbered step when the verification is part of proving the prior step succeeded.
- When a file is intended for developers and modernization agents to understand the workflow, optimize for readability and followability rather than compressed one-click automation language.
- The modernization workflow is intentionally meant to be learnable and traceable by developers watching Copilot make changes. Do not rewrite process documentation as if the goal were fully opaque or purely efficiency-driven automation.
- When documenting frontend modernization, prefer language that reflects a human modernization pattern:
  - inspect the legacy page,
  - identify its controls and behavior,
  - scaffold the destination page in the starter-derived target,
  - port controls and bindings incrementally,
  - then validate behavior and appearance.
- When the frontend migration is described as a larger step, it is acceptable for the document to explain that the actual execution happens through a per-page checklist loop, including page-specific dialogs, popups, or similar UI elements.
- Keep toolkit-maintenance instructions in this file. Keep the shared modernization-process overview in `/.github/instructions/AppMod-Process.instructions.md`.

## Wording For Blocked Steps

- When a step is blocked, say what is actually missing in plain language before using process jargon.
- Explain the impact in one sentence: what the missing evidence prevents the next step from doing.
- Prefer phrases like `the catalog does not yet name the backend unit tests Step 8 is supposed to create` over `semantic downstream readiness failure` in user-facing text.
- If a validation rule fails because files exist but the plan is hollow, say that the plan is hollow and why that matters.
- When a workflow-state object is inconsistent, say which fields disagree and which field is being treated as the source of truth.
- Keep the message short enough that a developer can act on it without reading the whole process file first.

## Terminology Notes

- `OpX` means `Operational Excellence`.
- Some steps in the modernization workflow may be performed by the OpX modernization partner assisting the application team rather than by the application developer directly. Toolkit documentation should make that ownership clear when it matters.

## Browser-First Debugging Guidance

- When toolkit docs describe local run or debugging verification, prefer the VS Code browser window as the primary inspection surface.
- Use Edge or Chrome as secondary browsers for manual confirmation, comparison, or browser-specific checks.
- Keep this guidance generic and reusable. Do not turn it into app-specific browser instructions inside toolkit guidance.

## Repository Structure Expectations

- `.github/`
  - reusable Copilot prompts, agents, scripts, instructions, tasks, and toolkit docs
- `.modernization/`
  - modernization-specific guidance, generated artifacts, operator notes, and additional context/reference material
- `.vscode/`
  - runtime editor configuration only, with additional files only where the editor has a hard location requirement

## Change Strategy

When changing generic modernization files:

1. Preserve the distinction between reusable toolkit assets and app-specific runtime/source assets.
2. Prefer the smallest set of edits that improve clarity and keep the toolkit generic.
3. Update references consistently across prompts, scripts, docs, and task catalogs.
4. After editing any script under `/.github/scripts/parity/` (parity scanner, scaffold-debt scanner, deferral gate, or their supporting scripts), run the gate-integrity runner to confirm the gate logic is still honest:
   `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/verify-gate-integrity.ps1`
   Require exit 0 before landing the change. See `.github/instructions/agent-integrity-checks.instructions.md` section 0 for details.
4. Verify that no new direct app-name references are introduced outside `kit-params.md` and intentionally untouched legacy areas.
5. Verify that any newly captured reverse-engineering lesson is expressed as a portable strategy, behavior family, artifact family, or derivation rule before you preserve it in reusable toolkit space.
6. Keep `LegacyCode/` untouched unless the user explicitly asks for legacy changes.
7. Keep local run outputs such as `/.modernization/ignition-artifacts/reviews/*.json` and `/.modernization/ignition-artifacts/qa/results/` out of the reusable kit contract and out of committed generic examples.
8. When syncing a validation branch back to `main` or `main-dev`, default to propagating reusable toolkit assets only and keep `LegacyCode/`, `src/`, and local-only `/.modernization/` outputs out of the merge unless the user explicitly includes them.

## Runtime Artifact Guardrail

- The kit may be tested against one or more real applications locally, but reusable toolkit space must not become branded around that test app.
- App-specific run outputs belong in disposable local artifacts, not in reusable prompts, agents, instructions, or committed generic examples.
- If a local validation run writes app-specific review or test-result payloads under `/.modernization/`, prefer ignoring or regenerating those outputs rather than preserving them as reusable repo content.
- When a generated portal HTML, JSON, or Markdown face under `/.modernization/portal/**` is stale after a source-of-truth change, prefer deleting or regenerating that generated face rather than hand-normalizing the rendered output.
- Retired toolkit files may preserve their historical wording when that wording is clearly part of the archived context and the file is no longer an active execution surface.
- Prefer new generated report families under `/.modernization/ignition-artifacts/**` unless a runtime tool has a hard location requirement elsewhere. If an existing generated family is moved from `/.modernization/ignition-artifacts/**` to `/.modernization/ignition-artifacts/**`, propagate every path reference in the same change.
- If a repo reorganization leaves an empty folder behind after files were intentionally moved or retired, remove the empty folder instead of preserving the old structure.

## Operational Knowledge Capture

- When a conversation produces reusable operational context that is not discoverable from the repo alone, promote that knowledge into the repo in a lightweight way.
- Prefer one of these destinations:
  - `/.github/instructions/` for stable source-of-truth guidance
  - `/.modernization/OpXUtil/.conversation/` for concise user-review notes that should be reviewed before being folded into source-of-truth files
  - `/.modernization/OpXUtil/CHANGELOG.md` for short dated provenance and historical notes when a changelog-style entry is the right fit
- Good examples of worth-capturing operational context include:
  - permission prerequisites discovered during execution, such as target branch force-push requirements
  - operator sequencing constraints, such as dry-run-then-write flows that should stay in one shell session
  - provenance of imported assets from other repos or external reference workspaces
  - confirmed target behaviors that future operators are likely to ask about again
  - process-model clarifications, such as step numbering, phase ownership, QA-after-step expectations, and which steps are intended to be visible and learnable to developers
- When a user instruction is ambiguous enough that a future repo-level clarification may be needed, agents may create a short review note in `/.modernization/OpXUtil/.conversation/` so the user can approve, reject, or refine it.
- Keep these notes concise, factual, and scoped to behavior that will help the next similar request.

## Practical Examples

- Good: `src/<AppName>.Web.Client`
- Good: derive `$appName` from `kit-params.md`
- Good: reference `/.vscode/tasks.json` or the VS Code task view when describing task execution
- Good: place instruction-clarification questions in `/.modernization/OpXUtil/.conversation/` for user review
- Good: record a newly discovered publish permission prerequisite in `/.modernization/OpXUtil/CHANGELOG.md`
- Avoid: a concrete current-app path such as `src/<CurrentApp>.Web.Client` inside reusable toolkit docs or prompts
- Avoid: storing reusable prompts inside `src/`
- Avoid: making `/.vscode/tasks.json` the documented canonical source of task definitions
- Avoid: leaving important operator behavior only in a long chat thread when it should be reusable workflow knowledge

## Notes For Future Agents

- If you need app identity, read `kit-params.md`.
- If you need task definitions, read `/.vscode/tasks.json` first.
- If you are unsure whether a file is generic toolkit content or app-specific content, treat `/.github/`, `/.modernization/`, and `/.vscode/` as toolkit space and keep it generic.
- If a useful rule seems to depend on the current app, first ask whether the real portable lesson is a behavior family, artifact family, evidence-priority rule, or derivation rule that can be reused across other apps.
- Do not assume `rg` is installed on the current Windows shell. Check `Get-Command rg` first; otherwise use VS Code search tools, `grep_search`, or PowerShell `Select-String`.
- If a future request uncovers reusable operator knowledge, update the canonical context or create a concise `.conversation` review note instead of relying on chat history.
- If you are editing the shared modernization-process file at `/.github/instructions/AppMod-Process.instructions.md`, keep it developer-readable and agent-readable. Do not overload it with toolkit-maintenance rules that belong here.
- Batch clarification questions into one concise review note whenever practical.
- Batch clarification questions into one concise review note whenever practical.
