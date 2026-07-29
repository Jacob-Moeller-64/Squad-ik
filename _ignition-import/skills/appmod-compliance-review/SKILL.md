---
name: "appmod-compliance-review"
description: "AI-judgment whole-codebase compliance review that fills the compliance report template by reasoning over every file, then scores + compares before/after deterministically."
domain: "review"
confidence: "high"
source: "earned (Ignition Kit dominion-requirements compliance report, re-cast as AI judgment)"
tools:
  - name: "tools/appmod/gates/compliance-scan.(ps1|sh) manifest <before|after>"
    description: "Enumerates EVERY in-scope file (count + list) into BASELINE-/FINAL-REVIEW-MANIFEST.json, each row with reviewed=false. This is the worksheet that proves you looked at every file."
    when: "First. Generate it, then review every file it lists."
  - name: "tools/appmod/gates/compliance-scan.(ps1|sh) assemble <before|after> --manifest <path> [--enforce]"
    description: "Scores the AI-filled manifest deterministically (100 - CRIT*10 - HIGH*5 - MED*2), verifies 100% of files were reviewed, and writes BASELINE-/FINAL-COMPLIANCE-REPORT.json. With --enforce it FAILS if any file was left unreviewed."
    when: "After you have reviewed every file in the manifest. NEVER self-report the score."
  - name: "tools/appmod/gates/compliance-scan.(ps1|sh) render <before|after>"
    description: "Renders the scored report into the compliance-report template markdown (score, gate table, per-category checklist, findings, comparison)."
    when: "To produce the human-readable report after assemble."
  - name: "tools/appmod/gates/compliance-scan.(ps1|sh) compare"
    description: "Writes the baseline -> current comparison from the two reports."
    when: "After the after-report exists, to quantify how much the code improved."
---

## Context

Use this when the task is a **compliance review** of the app (not the frozen scorecard gate). It restores
the Ignition Kit's before/after compliance report, but the findings come from **AI judgment over the
entire codebase** instead of a regex scan. The reviewer owns the JUDGMENT; the tool owns the MATH.

- **before** reviews `LegacyCode/` — the honest pre-modernization list of code smells to fix.
- **after** reviews `src/` — proves how much the code improved after those smells were fixed.

The split that keeps the improvement number trustworthy: **you supply findings + per-category judgments;
`compliance-scan assemble` computes the score, the gate table, and the before->after comparison.** You do
not compute or self-report the score.

**Output location (Ignition-aligned):** all compliance artifacts — `BASELINE-/FINAL-COMPLIANCE-REPORT.json`,
the rendered `.md`, `BASELINE-/FINAL-REVIEW-MANIFEST.json`, and `COMPLIANCE-COMPARISON.json` — are written to
`.modernization/ignition-artifacts/compliance/`, alongside the other Discovery/planning evidence. The tool
still reads the coverage input from `tools/appmod/artifacts/`.

## Patterns

**1. Generate the file manifest first, then review EVERY file in it.** Run
`compliance-scan manifest before` (or `after`). It writes `BASELINE-REVIEW-MANIFEST.json` (or
`FINAL-REVIEW-MANIFEST.json`) listing every in-scope file
(`.cs/.ts/.js/.cshtml/.razor/.config/.csproj/.css/.html/.json/.xml/.md/...`), excluding build output, deps,
generated, lock/minified) each with `reviewed: false`. Walk that list and review each file — this is the
mechanical guarantee that you looked at every file, exactly like the Ignition Kit manifest.

**2. Fill the manifest as you review.** For each file, read it, set `"reviewed": true`, and append any
issues to that file's `"findings": []` as `{severity, category, rule, line, evidence, recommendation}`.
Do NOT skip files — assemble fails the review if any row is still `reviewed: false` under `--enforce`.

**3. The category checklist is PRE-SEEDED — fill it in, never invent it.** The manifest's top-level
`"requirements": []` already contains **every canonical category row, pre-named and pre-ordered**, each
starting at `"status": "UNKNOWN"`. That is the deterministic half of the report: the row set and the row
names are identical for every app that runs through the kit, and only the judgments change per codebase.

Those rows are parsed straight out of the report template,
`/.github/templates/COMPLIANCE-ANALYSIS-REPORT.template.md` — the single source of truth for report
structure AND category names. To add, remove, or re-word a category, edit that template; the manifest
seed, the rendered checklist, and the enforce gate all follow automatically. Nothing restates the
category list in code, so the two can never drift apart.

- **Never edit, rename, paraphrase, reorder, add, or remove a `name`.** Copy nothing — the row is already
  there. A name you invent will not match the rubric row and lands as a stray extra.
- For each row set `status` to `PASS` / `PARTIAL` / `FAIL` and fill `findings` (file:line evidence),
  `notes` (short rationale), and `confidence` (`high`/`medium`/`low`).
- **`UNKNOWN` is a worksheet placeholder, not a result.** Every canonical row must end judged;
  `assemble --enforce` BLOCKS on any row still `UNKNOWN` and prints exactly which ones.
- Two rows are tool-owned and computed deterministically — `Test coverage >= 80%` and
  `Packages approved`. Do not write them; your opinion on them is discarded.
- A genuinely app-specific category may be *appended* as an extra row; it is reported under
  `requirementsUnmapped` so it is visible rather than silently merged.

**4. Use the same rubric both runs.** Judge against the fixed categories and severities in
`/.github/skills/dominion-requirements/SKILL.md` (12-Factor, SOLID, OAuth/OIDC, policy authorization,
stateless, RESTful, JSON, API-docs gating, logging, async, coverage, packages). Apply the SAME rubric to
`before` and `after` so the comparison is fair — the AI analog of "the same judge scores both phases".

**5. Assemble, render, compare.**
```
compliance-scan manifest before                                      # BASELINE-REVIEW-MANIFEST.json (reviewed=false + seeded category rows)
# ... review every file; fill reviewed=true + per-file findings + judge every seeded category ...
compliance-scan assemble before --manifest <filled-manifest> --enforce   # proves 100% reviewed + 0 UNKNOWN -> BASELINE-COMPLIANCE-REPORT.json
compliance-scan render before                                        # BASELINE-COMPLIANCE-REPORT.md
# ... modernization fixes the findings ...
compliance-scan manifest after ; (review) ; assemble after --manifest <...> --enforce   # FINAL-COMPLIANCE-REPORT.json
compliance-scan compare                                              # COMPLIANCE-COMPARISON.json
```

**Severity + score (fixed, dominion):** CRITICAL -10, HIGH -5, MEDIUM -2, LOW 0; `score = max(0, 100 -
weighted)`. Deploy gates: score >= 80, zero CRITICAL, coverage >= 80%, and review complete (100% of files
reviewed + every category judged). The review gate exists because a report with no findings would
otherwise score 100/100 — an unreviewed manifest can never read READY.

## Examples

- **Judgment the regex cannot make:** `FileLogService.cs` mixes orchestration + validation + data access
  -> `SOLID - single responsibility: PARTIAL` with the specific methods as evidence, `confidence: medium`.
- **Pruning a false positive:** a `new XValidator()` inside a unit test's arrange step is a test fixture,
  not a production DI violation -> drop it or down-rank, and say why in `notes`.
- **After run improvement:** before `score 0` (2 CRITICAL, 142 HIGH) -> after `score 88` (0 CRITICAL, 4
  HIGH); `compare` reports `scoreChange +88`, `criticalChange -2`, resolved vs remaining.

## Anti-Patterns

- **Renaming or inventing a category row.** The seeded `requirements` rows ARE the rubric — paraphrasing
  `RESTful API endpoints` into `RESTful API design` used to leave the canonical row UNKNOWN and append a
  duplicate. Fill the row that is already there.
- **Leaving a category UNKNOWN.** `UNKNOWN` means "not yet judged", not "not applicable". If a category
  genuinely does not apply, still judge it (usually `PASS` with a one-line rationale in `notes`).
- **Self-reporting the score.** Never write your own `score`; `assemble` recomputes it from findings and
  ignores any score you supply. A reviewer-inflated score is the one thing this design forbids.
- **Sampling instead of reviewing every file in the manifest.** A partial review makes the before/after
  delta meaningless. Every manifest row must end `reviewed: true`; `assemble --enforce` fails otherwise.
- **Changing the rubric between before and after.** Judge both with the same dominion categories/severities
  or the improvement number is not comparable.
- **Confusing this with the frozen scorecard.** The scorecard (D-008) is the deterministic GO/NO-GO gate;
  this compliance review is the rich audit report. They are different artifacts and both are valuable.
