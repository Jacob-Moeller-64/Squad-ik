# Core skill — Scorecard-driven cleanup (steps 07, 13)

Cleanup is targeted repair of `scorecard-before.json` findings — not an open-ended
beautification pass.

## Rules
- Work the findings list: each cleanup commit references the finding ID(s) it addresses.
  No finding, no commit.
- **Survivors only (D-002).** Backend: code that survived the restructure. Frontend:
  only components classified `survive` in the component map — never polish what the
  swap loop will replace.
- Characterization suite green after every commit. A surprising-behavior "fix" is an
  intentional behavior change → Lead + `decisions.md` first (D-001).
- Formatters/analyzers run before hand-cleanup (`dotnet format`, lint) — never spend
  agent tokens on what a formatter does for free, and never argue with the formatter.
- Fan-out allowed per-file/module; each work item independent; converge to one
  checkpoint before the gate.
- Exit condition is mechanical: targeted scorecard dimensions improved vs. before, suite
  green, goldens pass. "It looks cleaner" is not an exit condition.
