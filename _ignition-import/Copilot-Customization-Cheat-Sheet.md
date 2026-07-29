# Copilot Customization Cheat Sheet

<!-- Purpose: Canonical maintainer reference for how this repo uses Copilot customization primitives, governance sources, handoff features, and related workflow surfaces. -->

This is the single maintainer-facing cheat sheet for deciding how Copilot customization should be modeled in this repo.

Use this file when you need to answer questions like:

- where shared governance belongs
- how `/.github/copilot-instructions.md` differs from the Constitution
- when to use instructions vs prompts vs agents vs skills
- which Microsoft-supported handoff and routing features this kit should prefer
- where new Copilot documentation should be consolidated instead of scattered

## Canonical Primitive Matrix

Use the current VS Code and GitHub Copilot customization model this way in this repo:

| Primitive Or Surface | Where It Lives | Use It When | Avoid It When |
| --- | --- | --- | --- |
| Constitution | `/.github/constitution.md` | You need the durable shared governance source for cross-cutting rules, precedence, and boundaries between customization surfaces. In this repo, treat it as a governance primitive for documentation and maintenance decisions. | You need an auto-attached instruction surface, a path-specific rule, or runnable task behavior. The Constitution is not the attached repo-wide instruction primitive by itself. |
| Repository-wide instructions | `/.github/copilot-instructions.md` | A rule should apply almost everywhere in this repo and should stay concise, project-wide, and non-task-specific. | The rule is file-specific, workflow-specific, language-specific, or too detailed for always-on guidance. |
| File instructions | `/.github/instructions/*.instructions.md` | A rule should attach by path or be discovered by purpose, such as phase contracts, language standards, kit-maintenance rules, or shared personality baselines. | The content is really a runnable task, a persona, or a bundled workflow. |
| Prompts | `/.github/prompts/**/*.prompt.md` | You need a reusable task contract, a numbered step entry point, a helper route, or a repeatable operator-facing action. | You need an always-on rule set or a separate persona with tool boundaries. |
| Agents | `/.github/agents/*.agent.md` | You need a lane with its own persona, handoff surface, or tool boundary, such as orchestrators, routers, reviewers, or specialized execution agents. | A prompt or instruction would be enough and a separate persona adds no value. |
| Skills | `/.github/skills/<name>/SKILL.md` | The workflow depends on bundled references, templates, standards, or multi-step support material that should be loaded together. | The content is just one short rule file or one single runnable task. |
| Hooks | `/.github/hooks/*.json` | You need deterministic lifecycle behavior such as blocking a tool, auto-formatting, or injecting context before or after tool use. | A normal instruction is enough and you do not need shell-enforced behavior. |

## How Constitution And Copilot Instructions Differ

These two files are intentionally separate and should not be collapsed together:

| File | Role In This Repo | Key Constraint |
| --- | --- | --- |
| `/.github/constitution.md` | Durable governance source that defines shared principles, precedence, and boundaries between surfaces. | Not the repo's auto-attached Copilot instruction primitive by itself. |
| `/.github/copilot-instructions.md` | Main attached repo-wide instruction file and the primary always-on entrypoint Copilot should use in this workspace. | Must stay concise and should point to the Constitution instead of duplicating it broadly. |

Practical rule:

1. Put shared governance in the Constitution.
2. Put concise always-on repo defaults in `/.github/copilot-instructions.md`.
3. Put narrower rules in `/.github/instructions/*.instructions.md`.
4. Put runnable task logic in prompts.
5. Put persona or tool-boundary behavior in agents.
6. Put bundled support material in skills.

## Working Guidance By Surface

- `/.github/constitution.md`
  Use for shared governance and source-of-truth boundaries that many Copilot items should follow.
- `/.github/copilot-instructions.md`
  Use for repo-wide default posture, global workflow rules, and operating assumptions that matter on nearly every task.
- `/.github/instructions/*.instructions.md`
  Use for narrower path-scoped or purpose-scoped rules. This is the right home for things like phase contracts, shared coordinator personality baselines, language standards, and kit-maintenance rules.
- `/.github/prompts/**/*.prompt.md`
  Use for executable task contracts. Numbered prompts are the main readable step entrypoints. Helper prompts should stay thin and route into one clear task shape.
- `/.github/agents/*.agent.md`
  Use when a task needs a distinct role, tone, tool set, or handoff surface. Keep agents focused on scope, routing, and local deltas rather than copying shared rules into every file.
- `/.github/skills/<name>/SKILL.md`
  Use when the task needs bundled support material. Skills are the best fit for standards packs, reference-heavy workflows, or longer reusable capabilities that depend on companion docs.
- `/.github/hooks/*.json`
  Use only when behavior must be enforced deterministically by the environment. Hooks are stronger than instructions because they can run commands and block or modify workflow at lifecycle boundaries.

## Quick Selection Test

1. Use the Constitution when the rule is governance that many surfaces should share.
2. Use `/.github/copilot-instructions.md` when the rule should be attached across almost the whole repo.
3. Use `*.instructions.md` files for narrower path- or purpose-specific rules.
4. Use prompts for repeatable tasks or another agent intentionally runs.
5. Use agents only when a separate persona or tool boundary really helps.
6. Use skills when the workflow depends on bundled supporting assets.
7. Use hooks only when behavior must be enforced automatically at tool lifecycle time rather than requested or discovered through instructions.

## Primitive Choice Pitfalls To Avoid

- Do not put a repo-wide policy into a prompt just because it was discovered during one task.
- Do not make an agent when a prompt plus existing instructions would be enough.
- Do not make a skill when there is no bundled reference material or reusable workflow depth behind it.
- Do not use hooks for guidance that should remain advisory rather than enforced.
- Do not duplicate the same contract across the Constitution, instructions, prompts, and agents when one shared source plus one attached surface can carry it.

## Supported Handoff And Routing Features

These are the Microsoft-aligned workflow features that matter most to this kit today:

| Capability | Official Status | Best Use | Current Kit Usage | Gap Or Opportunity |
| --- | --- | --- | --- | --- |
| Custom agent `handoffs` | Supported | Show the exact next-step buttons after an agent completes | Yes | Already used heavily in orchestrator and worker agents |
| `handoffs.send: true` | Supported | Auto-submit the next step after the user clicks the handoff button | Limited | Use selectively where the next step should execute immediately after the click |
| Prompt file `agent:` | Supported | Make a slash prompt always run with the intended agent | Yes | Already used in multiple P1, P2, and P3 prompts |
| Slash prompts | Supported | Reusable single-task workflows | Yes | Could be used more consistently where prompts still rely on long inline instructions |
| Skills | Supported | Reusable multi-file workflow capability with packaged context | Partial | Could package more repeatable ignition-kit workflows instead of embedding everything in agent prose |
| Subagents | Supported | Delegate research or isolated worker tasks and automatically return to the parent session | Limited | Useful when you want automatic return without user button clicks |
| Custom agents as subagents | Supported but experimental | Coordinator and worker pattern with custom workers | Limited | Worth evaluating for research, QA routing, or specialized worker steps |
| Hooks | Supported but preview | Deterministic lifecycle automation and guardrails | Not evident | Useful for pre-stop checks, mandatory validations, or tool restrictions |
| Agent-scoped hooks | Supported but preview | Hook behavior only for one custom agent | Not evident | Useful if orchestrator or QA agents need custom safety rails |
| Allowed-subagent list (`agents`) | Supported | Restrict which workers a coordinator may use | Weakly used | Current broad allow-lists could be tightened where appropriate |
| Hidden or worker-only agents | Supported | Keep helper agents from being directly user-invoked | Not evident | Useful for internal-only worker agents |
| Cloud handoff | Supported | Hand a local session to a cloud agent for longer work | Not evident | Useful for long-running research or larger delegated workflows |

## Important Handoff Clarification

There is no confirmed official Microsoft frontmatter field for an automatic `on completion` or `return to another agent when finished` route in the current VS Code custom-agent and prompt-file docs used for this repo.

The supported patterns that are closest are:

1. `handoffs` shown after an agent finishes.
2. `handoffs.send: true` so a clicked handoff submits immediately.
3. Subagents, which automatically return results to the parent agent.
4. Hooks, which can enforce behavior around stop or completion, but are not documented as agent-routing features.

## Local Extension Experiments

- The local Step 0 extension experiment is not part of the active workflow surface right now.
- Do not depend on extension-specific buttons or pause cards in active prompts.
- If that work needs to resume later, start from `/.modernization/OpXUtil/.conversation/Step-0-Extension-Paused-Status.md`.

## What The Kit Already Does Well

1. Uses custom-agent `handoffs` as the main visible workflow router.
2. Uses prompt-level `agent:` binding so prompts run in the intended agent context.
3. Uses a coordinator-style orchestrator with clearly labeled next-step buttons.

## Best Opportunities To Use More Deliberately

1. Tighten allowed worker agents instead of leaving broad agent access where not needed.
2. Use subagents for tasks where you want automatic return to the parent workflow without another visible user handoff.
3. Evaluate agent-scoped hooks for mandatory guardrails such as artifact freshness checks, required validation before stopping, or tool restrictions.
4. Package repeatable workflow logic as skills where the behavior is more reusable than a single prompt but does not need a full custom agent.
5. Consider hidden internal worker agents for purely mechanical or validation-specific steps that should not appear as user-facing choices.

## Process And Workflow Authority

Do not treat this cheat sheet as a second process specification.

Use these sources in order when working on the modernization workflow itself:

1. `/.github/instructions/AppMod-Process.instructions.md`
   Human-readable phase and step authority.
2. `/.github/instructions/AppMod-Step-Contract.json`
   Machine-readable step, owner, and QA routing authority.
3. `/.github/agents/OpX-AppMod-P1-Discovery.agent.md`, `/.github/agents/OpX-AppMod-P2-Modernize.agent.md`, and `/.github/agents/OpX-AppMod-P3-Review.agent.md`
   The active phase execution surfaces that should stay aligned to both authorities.

## Maintainer Notes

- Keep this file as the canonical consolidation point for Copilot primitive definitions, Constitution usage guidance, and handoff-feature notes.
- When a future discussion adds reusable Copilot operating knowledge, prefer updating this file instead of creating another overlapping cheat sheet.
- If a rule needs automatic attachment, move the rule into `/.github/copilot-instructions.md` or the correct `*.instructions.md` file rather than only documenting it here.
- Keep the Constitution and `copilot-instructions.md` distinct in wording and ownership even when both are mentioned together.
