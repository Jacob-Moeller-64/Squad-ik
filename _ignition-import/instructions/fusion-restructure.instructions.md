---
name: fusion-restructure
description: Use when planning or executing OpX-Fusion LegacyCode-to-src restructure handoffs, parity-first migration slices, temporary bridge decisions, and protected starter-shell preservation.
applyTo: '.github/agents/OpX-Fusion-Transform.agent.md,.github/agents/OpX-Fusion-Reviewer.agent.md,.github/skills/architecture-structure/SKILL.md,.github/skills/fusion-restructure-review/SKILL.md,.github/skills/fusion-ui-component-upgrade/SKILL.md,.github/prompts/P2-Modernize/**/*.prompt.md,.modernization/ignition-artifacts/modernize/fusion-restructure/**'
---

# OpX Fusion Restructure Guidance

Use this instruction when the active work is the OpX-Fusion restructure that moves app behavior from `LegacyCode/` into the starter-derived target under `src/`.

## Persisted state first

- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and `.modernization/portal/data/json/step-workflow-state.json` before planning or editing.
- When the active work is being driven from the numbered workflow, also read `.modernization/portal/data/json/step-response-ledger.json` so the current numbered-step response and recommendation stay authoritative.
- Treat `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` as the source-of-truth Step 6 decision artifact and the migration-plan plus control-point inventory as the current restructure execution pack.
- If the decision artifact already records the application identity, architecture style, and approved plan, do not re-ask for them.
- Do not create or rely on a retired Fusion-only state tracker as numbered-flow state. Numbered-step truth lives in `.modernization/portal/data/json/step-response-ledger.json` plus the refreshed step-owned restructure artifacts.
- If the numbered-step state or step-owned restructure artifacts already show the relevant lane complete, do not redo it unless the user explicitly approved that rerun after being told it can change recorded step status, portal summaries, or the recommended next step. A direct named handoff, numbered-step button click, slash command, or named-step request counts as that explicit approval for the exact lane invoked.
- Treat status-writing artifact refreshes that can rewrite numbered-step truth as reruns for this approval gate even when the code slice itself is unchanged.
- When numbered-step-driven restructure work starts, write `InProgress` to `.modernization/portal/data/json/step-workflow-state.json` and keep percentComplete, estimatedMinutesRemaining, estimatedCompletionAt, currentActivity, and heartbeatAt current until the step closes as `Completed`, `Blocked`, or `Failed`.
- Treat saved `InProgress` numbered-step state as an active continuation signal, not as an idle placeholder.
- When the operator says `continue`, `proceed`, `resume`, or similar, finish the current incomplete handoff and then advance through the next eligible incomplete handoffs in order until a real blocker, failed checkpoint, required user decision, or workflow completion is reached, using the numbered-step state and the step-owned restructure artifacts to decide what is still incomplete.

## Workflow and gate expectations

- Honor handoff order and checkpoint gates.
- Keep the migration parity-first: preserve workflows, APIs, UI behavior, and the legacy visual contract unless the active step explicitly approves a change.
- Verify backend before backend Fusion takeover.
- Verify backend Fusion takeover before frontend migration proceeds.
- Stabilize the moved frontend inside the Fusion shell before broad Fusion UI component replacement begins.
- Stop for real blockers, failed required checkpoints, required user decisions, or workflow completion. Do not stop merely because one micro-slice succeeded.

## Concern classification

Classify each significant concern before changing it:

- `App-owned`
- `Fusion-owned final state`
- `Temporary bridge`
- `Banned final state`

Keep temporary bridges explicit and only as long as parity still requires them.

## Protected starter-shell rules

- Preserve the protected starter shell by default.
- Do not broadly rewrite protected control points such as `Program.cs`, starter DI/composition seams, `main.ts`, `app.config.ts`, or `fusion.config*.ts` unless the current step explicitly allows a narrow rebind.
- Use policy-based authorization only. Do not introduce Windows authentication, Negotiate, or direct role checks as a final pattern.
- Use the repo's real build, test, and package scripts. Do not guess new commands.
- Treat the current starter shell under `src/` as the implementation source of truth for Fusion-owned platform behavior.
- Do not make restructure decisions depend on `SimpleArchitectureExample/` being present.

## Platform alignment rules

- Treat platform-owned configuration as Fusion-owned final state.
- Re-home auth, roles, policies, identity providers, logging, CORS, OpenAPI, and connection strings into approved Fusion-native sections or `ConnectionStrings`.
- When adding or upgrading Fusion packages during restructure, use the latest production version available in Sonatype feeds for NuGet (`Fusion.*`) and npm (`@fusion/*`) dependencies.
- If deployment provides split database environment variables instead of a ready-made connection string, materialize the `ConnectionStrings` value once in a centralized startup-bound seam rather than in feature code.
- Unless repo evidence proves a different deployment contract, assume the split database environment variables follow the OpenShift/Kubernetes pattern: `SqlServer__Server`, `SqlServer__Database`, `SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`, and `SqlServer__TrustServerCertificate`.
- For backend Fusion Okta auth, app-owned authorization surfaces must resolve memberships from the same Fusion-aligned source as the protected policies.
- For Angular Fusion Okta auth, protected API paths must use Fusion's auth-aware HTTP path or an explicitly approved app-owned bearer-token interceptor.

## Frontend migration rules

- During the initial move into `src/<AppName>.Web.Client`, preserve the legacy styling contract closely enough for the app to remain usable.
- Keep the stylesheet stack, route/component styles, assets, fonts/icons, host/body classes, shell/layout wrappers, and required DOM/class hooks before broad Fusion UI replacement.
- Do not combine the initial frontend move with broad Fusion UI component replacement.
- Treat high-risk widgets such as grids, charts, composite forms, and heavily customized tables as dedicated migration slices with explicit parity checks.

## Required companion guidance

- Read `.github/instructions/modernization-starter-boundaries.instructions.md` before planning or editing LegacyCode-to-`src/` restructure work.
- Read `.github/instructions/fusion-mcp-restructure.instructions.md` before inventing Fusion-aligned platform, package, startup, auth, HTTP, data, logging, caching, or UI solutions.
- Use `.github/skills/fusion-restructure-review/SKILL.md` for inline Fusion review before closing major handoffs that change Fusion-owned concerns or temporary bridges.
- When Step 16 or route-level Fusion primitive replacement is active, load `.github/skills/fusion-ui-component-upgrade/SKILL.md` and follow its slice-selection, validation, and artifact-update rubric.
