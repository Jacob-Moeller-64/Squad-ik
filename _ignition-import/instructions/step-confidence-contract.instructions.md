---
description: Confidence contract for numbered modernization prompts. Requires plain-language step framing, binary completion gates, runtime proof for src-changing steps, and blocker guidance that drives the user to complete the current step accurately instead of drifting forward.
applyTo: ".github/prompts/*.prompt.md"
---

# Step Confidence Contract

> Purpose: Make every numbered step trustworthy on its own. A step must explain itself in plain language, prove its result, and refuse to advance on a guess. The goal is consistent, confident results on any application and protection against drift poisoning later steps.

This contract is additive. It does not replace a prompt's existing objective, returned-data, or QA wording; it sets the minimum confidence shape every numbered prompt must honor.

## 1. Plain-Language Step Framing (required opening)

Every numbered prompt must open its body with a short, human-readable block that a developer watching Copilot can understand without reading the whole file:

- **What this step does** - one or two sentences in everyday language.
- **Why it matters** - what breaks downstream if this step is wrong or skipped.
- **What you will have when it is done** - name each artifact this step creates or refreshes and state, in one line each, what that artifact is for and who consumes it next.

Keep it concrete and app-agnostic. Derive specifics (routes, controls, app name) from evidence and `kit-params.md`, never hard-code the current app.

## 2. Artifact Honesty

- An artifact is only "done" when it reflects the real current state. Prefer a truthful `Partial` or `Blocked` with named gaps over a green status that hides missing work.
- A gate that can pass while the running application is missing most of its behavior is a defect in the gate. When a coverage measure (controls mapped, routes wired, screens compared) is far below the legacy baseline, the gate must fail loudly, not absorb the gap into an "ignored" bucket.
- Every "ignored" or "waived" item must be explicit: a list the user can read, each with a reason and an owning step. Silent drops are forbidden.

## 3. Binary Completion Gates (gate of record)

- Each numbered prompt must end with a small set (ideally 3 to 6) of **binary** completion checks phrased as pass/fail, not as self-reported percentages. Rich metrics may remain as informational context, but the binary checks are the gate of record.
- A step is complete only when every binary check is `pass` or its failure is recorded as an explicit, owned waiver.
- State the single exact next step. Do not offer "advance" as the default when a binary check is failing.

## 4. Runtime Proof For src-Changing Steps

- Any step that changes runnable application behavior under `src/` (shell, routes, controls, data wiring, auth, configuration) must prove the change against the **running** application before closeout, not only against a successful compile.
- Use the integrated browser as the primary inspection surface and the backend log stream as the secondary surface. The minimum runtime evidence is: the in-scope route renders, its inventoried controls and navigation are present **and visible** (not hidden behind an unwired flag or an empty container), primary data calls fire and return real data, and there are no unexplained browser-console or backend errors.
- Follow `/.github/skills/runtime-parity-checkpoint/SKILL.md` for the reusable boot-observe-assert procedure and the `runtime-parity-checkpoint.json` evidence shape. "Compiles" and "DOM element exists" are necessary but never sufficient.

## 5. Blocker Guidance Drives Step Completion (anti-drift)

- When a step hits a blocker, the prompt must guide the user toward **completing the current step accurately**, not toward skipping ahead. Advancing with a broken or partial artifact poisons every step that consumes it.
- Blocker output must name: the exact failing check, the most likely cause in plain language, the concrete next action to finish this step, and which upstream step to revisit if the real gap was planned-in earlier.
- Only recommend advancing when every binary completion gate passes or the user explicitly overrides a named, still-open risk.
- Apply a deterministic in-step remediation before reporting `Blocked`: when a single clear in-scope fix exists, apply it and re-run the affected proof first. Report `Blocked` only after that remediation is attempted or ruled out with evidence.

## 6. Model And Effort Guidance

Match the model to the step so correctness-critical work is reliable and routine work stays cheap. The deterministic scripts (artifact checks, parity scan, runtime checkpoint) do the heavy verification, so the model is not spending tokens deciding whether a gate passed - that protects both quality and budget.

- **Tiers** - pick whatever model in your plan matches the tier; do not hard-pin a specific model SKU in a reusable kit:
  - **Premium reasoning (high thinking):** decision- or correctness-critical work where a mistake poisons later steps - Discovery analysis and planning (Steps 3, 5, 6), backend formation/hardening (8, 9), frontend migration (11), Fusion UI swaps (15, 16), plus auth/HTTP wiring (12) and end-stage reviews (19, 24).
  - **Balanced (medium thinking):** structured execution bounded by artifacts - Steps 4, 7, 10, 13, 14, 17, 18, 20, 21, 22, 23.
  - **Light (low thinking):** mechanical, tool-driven setup - Steps 1, 2.
- **Each numbered prompt header carries a one-line recommended tier and a rough run-time range.** Treat the run time as an estimate that varies with app size, machine, and model; it is planning guidance, not a guarantee.
- **Budget protection:** binary gates stop endless polishing loops, one-slice-per-pass keeps per-turn spend predictable, and blocker-to-completion guidance turns a stuck step into one concrete action instead of token-burning retries. Do not run the correctness-critical steps on the cheapest model - a wrong move there costs more in rework than the upgrade saves.
- **Context discipline:** prefer the compact JSON evidence artifacts over re-ingesting whole source trees. Use a larger context window only where it pays off (Steps 3, 5, 11).
- **Single-org option:** if your org standardizes on one model, you may pin it in the frontmatter of the few highest-stakes steps (8, 9, 11, 15) with a documented fallback. Avoid pinning across all 24 - model availability, budgets, and version churn make that brittle.

## 7. Consistency

- These requirements apply to every numbered step the same way, so the experience is predictable across the whole 24-step sequence and across different applications.
- When a numbered prompt is edited, keep its plain-language framing, binary gates, runtime proof (when it changes `src/`), and blocker-to-completion guidance aligned with this contract.
