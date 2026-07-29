---
name: qa-portal-reporting
description: Canonical rule that the Quality Portal is manual-only. No numbered modernization step depends on portal pages or auto-runs portal refresh.
applyTo: ".github/prompts/**/*.prompt.md,.github/agents/*.agent.md,.github/instructions/*.instructions.md,.github/scripts/QA/qa-refresh-portal.ps1"
---

# Quality Portal Rules

Purpose
- The Quality Portal under `.modernization/portal/` is a developer reference surface only. It is a nice-to-have, not a gate.
- No numbered step (1 through 24), agent, prompt, skill, or QA workflow may depend on portal HTML, portal page-model JSON, or any portal-derived summary to prove its completion.
- Source truth is always the underlying source artifacts (for example `.modernization/portal/data/json/step-workflow-state.json`, `.modernization/portal/data/json/step-response-ledger.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/*.json`, `.modernization/portal/data/json/frontend-runtime-comparison.generated.json`, the live code under `src/`, and the live test results). Portal rendered surfaces are downstream views of that source truth and may lag.

Hard rules for agents and prompts
- Never auto-run `.github/scripts/QA/qa-refresh-portal.ps1`, `qa-report-portal.prompt.md`, or any other portal republish flow from inside a numbered step, helper lane, agent handoff, or QA workflow.
- This is true regardless of the `OPX_ENABLE_QA_PORTAL_REFRESH` shell flag. The flag only grants permission to run portal refresh when the user explicitly asks for it. It is not a trigger.
- Numbered steps must reach a Completion or Blocked decision using source artifacts alone. They must not block on, wait for, or require a portal page refresh to close.
- Do not silently run portal refresh as part of any other shell pipeline (no chained `; & qa-refresh-portal.ps1`, no implicit invocation from helper scripts the prompt routes to).
- The portal handoff button on a coordinator agent (for example `QA Portal Full Refresh`) is an explicit manual user action surface only. Do not invoke that handoff yourself.

Staleness reporting rule
- When source artifacts are newer than the corresponding portal page or page-model JSON, agents must:
  1. Continue and complete the numbered step from source truth.
  2. Tell the user in chat that the portal page is stale, name the stale portal surface, and name the newer source artifact.
  3. Tell the user that portal refresh is a manual action and suggest running `& .\.github\scripts\QA\qa-refresh-portal.ps1` (with `$env:OPX_ENABLE_QA_PORTAL_REFRESH = '1'` set in their own shell) only if they want the portal updated.
- Do not refresh the portal yourself to "fix" the staleness. Reporting it is the fix from the numbered-step side.

Reporting and evidence rule
- Do not describe portal publication as part of completion criteria for any numbered step.
- When reporting status, cite source artifacts directly. Do not cite portal HTML pages as the evidence link.
- Do not use internal portal-refresh scripts such as `qa-refresh-portal.ps1` as end-user evidence links unless the user is specifically working on that script.

Manual portal refresh, when the user asks
- If, and only if, the user explicitly asks for a portal refresh, route to `qa-report-portal.prompt.md` or run `.github/scripts/QA/qa-refresh-portal.ps1` with `OPX_ENABLE_QA_PORTAL_REFRESH=1` set in their shell.
- A portal refresh requested by the user is its own pass. It does not count toward, replace, or unblock any numbered step.

