---
name: "appmod-testing-and-gates"
description: "Characterization tests, the deterministic gate scripts in tools/appmod, and the frozen scorecard — the objective proof that modernization preserved behavior."
domain: "testing"
confidence: "high"
source: "earned (Ignition Kit QA + gates + scorecard)"
tools:
  - name: "tools/appmod/gates"
    description: "Deterministic gate scripts (stdlib Python) with .sh/.ps1 launchers over shared lib logic."
    when: "Run the matching gate to prove a step is done; a non-zero exit means NOT done."
---

## Context

The tester agent owns this. Gates are scripts, not opinions: a step is done only when its gate script
exits `0`. The scorecard is frozen per run (D-008) — the same engine + judge score before and after.

## Patterns

- **Characterization first:** pin the app's CURRENT behavior (bugs included) targeted at the riskiest logic, BEFORE modernization. Tests are evidence (D-001): change one only with a logged intentional-behavior-change entry.
- **The gates** (in `tools/appmod/gates/`, exit `0` pass / `1` usage / `2` fail):
  - `validate-artifacts <name>|all` — artifacts conform to their JSON Schema (a missing schema FAILS, never degrades to a syntax check).
  - `verify-goldens <url>` — replay every golden; TYPE-STRICT compare (`true != 1`, `int != float`) with normalized fields masked; do NOT follow redirects.
  - `visual-diff <url> [--capture]` — screenshot every route/state and pixel-compare vs baselines; re-baseline only with `--capture` + a logged decision.
  - `check-structure [--phase backend|full]` — required `src/` roots exist; `full` also asserts the legacy app is gone.
  - `check-pins` — fail while any pin is a placeholder.
  - `check-auth-removed` — fail on any surviving legacy auth path (owned by security).
  - `run-scorecard <before|after>` — after-mode enforces: no critical/high CVEs, coverage threshold, total >= target, NO dimension below its before score.
- **Test readability:** Gherkin-style with `CaseId`/`Scenario`/`Description`/`Input`/`Expected` headers and `Given`/`When`/`Then` bodies. Smallest meaningful suite first.

## Examples

- `pwsh -File tools/appmod/gates/check-structure.ps1 --phase backend`
- `python tools/appmod/scorecard/engine/engine.py before`
- `pwsh -File tools/appmod/verify-kit.ps1` — self-test: prereqs + example artifacts + all gate/engine tests.

## Anti-Patterns

- Reporting "done" or "tests pass" without a `0` exit from the matching gate.
- Column collapse / inert stubbed handler / dead filter counted as field parity.
- A pending scorecard dimension (no evidence) treated as a pass — the engine scores it `0`, not a false pass.
- Editing the rubric mid-run (requires a `tools/appmod/scorecard/VERSION` bump, D-008).
