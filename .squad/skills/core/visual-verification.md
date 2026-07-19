# Core skill — Visual verification (steps 02, 15, 18)

The perceptual gate: build/tests can't see a broken layout.

## Baseline capture (step 02)
- One screenshot per route/state in `ui-inventory.json`, from the running legacy app.
- Normalize dynamic content: seeded data, fixed clock, animations disabled, fonts
  loaded. Unnormalized baselines produce noise that trains everyone to ignore the gate.

## Verification (step 15 — standard: fidelity to legacy baselines)
- `gates/visual-diff.sh` compares every route/state to the Phase-1 baselines.
- QA triage of each diff, exactly three outcomes:
  1. **Regression** → back to Frontend Dev with the diff image.
  2. **Legitimate rendering drift** (framework upgrade font/reset deltas) → propose
     re-baseline; requires a `decisions.md` entry; then the new image becomes baseline.
  3. **Borderline** → human review. QA never approves borderline diffs unilaterally.

## Re-baseline & verification (step 18 — standard changes by design)
- After fusionization the standard is **Fusion design system + behavior parity**, not
  legacy pixels (the swap deliberately changes the look). Capture a complete new
  baseline set; verify every route renders and behaves; goldens and suite still green.
- Do not compare post-fusion UI to legacy baselines — that gate would fight the
  fusionization on purpose lost.
