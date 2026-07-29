---
name: agent-process-conformance
description: Minimum conformance rules for modernization agents and router prompts, including required sections, route wording, QA expectations, and next-step contracts.
applyTo: ".github/agents/*.agent.md,.github/prompts/**/*.prompt.md"
---

# Agent Process Conformance

Use this file when creating, editing, or reviewing modernization agents and router prompts.

## Purpose

- Keep agent structure consistent across Discovery, Modernize, Review, QA, and optional lanes.
- Prevent drift in route wording, QA expectations, and next-step behavior.
- Make each agent readable as a thin router or clearly scoped executor instead of a mixed role.

## Minimum Required Shape For Agents

Every agent should include these minimum parts:

1. Frontmatter with `name`, `description`, and a tool list that uses the repo's current explicit style for that surface.
2. A short body heading naming the agent role.
3. A `Scope` section that says what the agent owns and what file holds the detailed route or workflow logic.
4. A `Core Rules` section that states the behavior boundaries for that agent.
5. A `Response Contract` or equivalent output section that says what the agent must return.
6. Handoffs that map to readable process steps or clearly named recovery actions.

## Route Style

- Prefer thin-router wording for prompt handoffs.
- Use one of these patterns:
  - `Route via .github/prompts/<path>.prompt.md :: <section>.`
  - `Use .github/prompts/<path>.prompt.md and execute it in full.`
- Prefer the `Route via ... :: <section>.` style when the prompt file contains multiple named sections.
- Prefer the `Use ... and execute it in full.` style when the prompt file is a single-purpose executable prompt.
- Do not embed long operational procedures directly into agent handoff prompts when that logic belongs in a prompt file.

## QA Expectation

- Numbered process steps with dedicated QA associations should map to one readable primary QA workflow.
- Discovery steps 1 through 6 are allowed to close from step-owned evidence and saved state without a separate QA prompt association.
- QA router agents should keep only route labels, route prompts, and high-level usage rules.
- Detailed run order, pass or fail logic, artifact expectations, and report-refresh behavior belong in prompt files.
- If a step requires chained QA, the handoff should still preserve the readable step name and route to the prompt file that explains the chain.

## Numbered Step Execution Contract

- Every numbered modernization step prompt must treat the step as incomplete until the mapped step work, any required mapped QA work or explicit QA blocker reporting, ledger save, and ledger readback verification are all done.
- Every numbered modernization step prompt must require saving the latest full response and current step-state record into `.modernization/portal/data/json/step-workflow-state.json`.
- Every numbered modernization step prompt must require a readback check that verifies the saved step entry contains `status`, `updatedAt`, and `latestFullResponse` with populated values before the handoff is closed.
- Every numbered modernization step prompt must require a readback check that verifies the saved unified state entry contains populated `updatedAt`, `lastExecutedStep.step`, `lastExecutedStep.status`, `recommendedNextStep.step`, and `recommendedNextStep.label` values before the handoff is closed.
- Every numbered modernization step prompt must require `/.github/scripts/shared/Invoke-StepReconciliation.ps1 -Step <N>` after the step-state save so `/.modernization/.readme/.StepSummary.md` is regenerated from saved state before the handoff is closed.
- Every numbered modernization step prompt must require a readback check that verifies the regenerated Step Summary reflects the current step and does not append a duplicate historical block.
- Every numbered modernization step prompt must require the compact numbered-step handoff response shape, not a script-only completion note.
- If a numbered step prompt omits these requirements, it is out of conformance even if the underlying script command is correct.
- Do not copy the same generic step-state boilerplate into every numbered prompt when the shared contract already covers it.
- Add prompt-local numbered-step execution text only when a specific prompt has unique delta behavior beyond the shared contract, such as a same-step loop rule or a step-specific completion exception.

## Targeted Runtime Checks And Plain-Language Step Intro

- For active numbered steps 7 through 24, do not make a live Angular runtime continuity check part of the default preflight.
- Only do a live runtime continuity check when the user explicitly asks for build or run proof, the mapped QA workflow requires a running app, or current evidence says the dependent runtime is down.
- If a required runtime is down and the current pass truly needs it, restart it with the supported repo run flow or report the exact blocker immediately.
- Every numbered step prompt and coordinating agent must make the pre-run update easy for a non-specialist to follow.
- The pre-run update must always include three short bullets in this order: `Context`, `Dev work`, and `QA after`.
- Each bullet should stay to one short sentence when practical.
- `Context` should say whether live runtime proof is being skipped for speed or briefly name the specific prerequisite check that is actually needed.
- `Dev work` should say the code or configuration work in one plain sentence with minimal jargon.
- `QA after` should say the exact QA workflow that will run after a successful dev pass and what that QA is meant to prove.
- `QA Summary` must also use simple wording: say what QA checked, whether it passed or blocked, and name the workflow or script.



## Next-Step Contract

- Every step-driving agent should tell the user the exact next step.
- Keep the recommended next step in the workflow-state snapshot instead of repeating the same label in multiple headings.
- When a numeric fallback is part of the lane contract, keep it explicit only when it meaningfully helps the user act from the current reply.
- Optional helper lanes must never appear to replace numbered steps.
- Recovery and ad hoc actions must state how to return to the numbered flow.

## Evidence Link Contract

- When a numbered-step reply includes evidence links, those links should point to durable proof artifacts or user-facing evidence first.
- Prefer runtime URLs, step-state JSON, generated proof JSON, HTML report pages, or other current evidence artifacts over internal toolkit script paths.
- Do not use internal scripts such as `qa-refresh-portal.ps1` as evidence links unless the user explicitly asked for portal-refresh work or that script is the actual blocker. The Quality Portal is manual-only; numbered steps never auto-run portal refresh and never depend on portal pages as proof. See `/.github/instructions/qa-portal-reporting.instructions.md`.

## Allowed Prompt Wording

- Good:
  - `Route via .github/prompts/P2-Modernize/integration-hardening-routing.prompt.md :: [Step 9] Backend - .NET Integration Hardening.`
  - `Use .github/prompts/22-P3-final-acceptance-criteria-review.prompt.md and execute it in full.`
- Avoid:
  - Long prose that repeats workflow logic already defined in a prompt file.
  - Ambiguous wording such as `continue the process` when the exact route or next step is known.
  - Hidden QA expectations that are not reflected in either the step contract or the routed prompt.

## Tool List Guidance

- Prefer explicit tool identifiers that match the stronger router agents in this repo.
- Keep tool lists narrow to the agent role.
- If two peer agents serve the same type of lane, keep their tool lists aligned unless there is a deliberate reason not to.

## Shared Personality Layering

- When multiple coordinator agents should share one execution personality, put that shared personality in a path-scoped `.instructions.md` file instead of copying it into each `.agent.md` file.
- Shared workflow contracts such as `/.github/instructions/appmod-phase-agent-contract.instructions.md` override the personality baseline when both apply to the same agent surface.
- When a local agent body, routed prompt, or narrower instruction file conflicts with the shared personality layer, the more specific local rule wins.

## Conformance Checks

When reviewing an agent or prompt, verify:

1. The step label matches `/.github/instructions/AppMod-Step-Contract.json` when the file participates in the numbered flow.
2. The route prompt target exists.
3. The route wording matches one of the approved patterns.
4. QA expectations are visible and not split across conflicting files.
5. Numbered-step prompts include the full execution contract for QA or explicit QA blocker reporting, ledger persistence, and ledger readback verification.
6. The next-step contract is explicit.
7. There are no stale maintainer notes, legacy skill-path shapes, or temporary review comments left in the file.
