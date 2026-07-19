# Core skill — Characterization tests (step 03, enforced everywhere after)

Purpose: a behavior net around Library-layer business logic **before any transformation**.
These tests assert what the code *does* — bugs included, by design (D-001).

## Procedure
1. From the scorecard's complexity findings and the endpoint inventory, identify
   risk-flagged logic: branching business rules, calculations, state machines, anything
   cleanup (steps 07/13) is likely to touch.
2. Write tests that pin current observable behavior: given these inputs, the legacy code
   returns exactly this. Do not "fix" surprising outputs — pin them and note them.
3. Measure **branch coverage over the risk-flagged logic** (not blanket line coverage —
   AI-generated suites blanket the easy surface and miss the conditionals that matter).
   Gate: ≥ 70% (rubric threshold).
4. Suite must be green against the untouched legacy code before step 04 closes.

## Standing rules (all later steps)
- The suite runs inside every subsequent gate. Red suite = red gate, no exceptions.
- The restructure steps (06/11) move tests with the code; "suite green" is part of those
  gates specifically because moves are where suites silently break.
- A failing characterization test after a change is evidence. Only two exits: revert the
  behavior change, or the Lead logs an intentional-behavior-change entry in
  `decisions.md` naming the test and the justification — then the test may be updated.
- QA reports any test edit lacking a decision entry as evidence destruction.
