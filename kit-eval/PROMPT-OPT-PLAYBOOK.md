# Prompt Optimization Playbook — token cuts with functionality proof

Companion to `PATCH-LIST.md` (apply that first — globs/card/anti-rerun fixes move more
tokens than any single prompt edit). This playbook is the per-prompt loop, the tier
map, and the certification protocol. Billing context: June-2026 usage billing —
input tokens billed every turn, cached prefix ~10× cheaper, output ~5× input.

---

## 1. The loop (one prompt at a time, one commit each)

1. **Baseline.** Fresh session, unmodified prompt, run the step against a fixture
   (FileLog inputs once imported, else the mini-app). Save:
   - every `producedOutputs` artifact,
   - every gate `RESULT:` line,
   - the scorecard/parity numbers if the step touches app code.
2. **Trim** the prompt (categories in §2).
3. **Re-run** fresh, same inputs.
4. **Accept only if all four hold:**
   - `verify-step-artifacts -Step N -Mode Output` → `RESULT: OK`
   - artifact diff vs baseline clean (ignore `generatedUtc`/timestamps/durations)
   - `verify-step-artifacts -Step N+1 -Mode Input` → `RESULT: OK`
   - negative probe: delete one requiredInput, re-run → still BLOCKED
   (code-writing steps 7–18 additionally: build green, characterization tests
   green, parity score unchanged)
5. **Commit** (one prompt per commit — bisectable). Record before/after line and
   token counts in §5's table.

The kit's own gates are the functionality test. Do not invent a parallel checker.

## 2. What to cut / keep (the four categories)

Worked example: `08-P2-backend-modernization-formation.prompt.md`, 518 lines.

| Category | Step 8 example | Action | ~lines |
|---|---|---|---|
| Duplicate of auto-loaded standard | "Code Quality Standards (MANDATORY)" block restates `dotnet.instructions.md`, which auto-loads on the same `.cs` files (post glob fix, exactly when Step 8 works in `src/`) | **Delete** — the standard + downstream review gates preserve the rules | ~50 |
| Embedded file templates | unit-test `.csproj` XML, `GlobalUsings.cs`, directory skeletons | **Move** to real template files (`templates/…`) or a scaffold script; prompt references the path | ~100+ |
| Contracts | status classifications (`libraryFormationStatus: …`), artifact paths, gate invocations, MANDATORY guardrails, learned traps (auth-policy-DI checklist) | **Keep verbatim** | ~150 |
| Narrative | Objective prose saying things twice | **Compress** to artifact-naming bullets | ~100→40 |

Net for Step 8: 518 → ~250 lines, ~50% per-turn cost, zero functional change.

**Never cut:** artifact schemas, gate invocations, MUST/NEVER rules,
requiredInputs/producedOutputs declarations, failure handling, learned postmortem
traps. Those ARE the functionality.

**Order of attack** (by measured size; re-rank once FileLog artifact sizes arrive):
`24` (1247 lines), `06` (567), `08` (518), `17` (442), `12` (375). Stop when two
consecutive prompts yield small savings.

## 3. What "same functionality" means, per step type

- **Artifact-producing steps (1–6, 19–24):** functionality ≡ artifacts validate
  (schema + reconciliation), downstream Input gates accept them, refusals preserved.
- **Code-writing steps (7–18):** functionality ≡ the above PLUS build + characterization
  tests + parity gates + scorecard unchanged. The kit's app-facing verification stack
  is the regression suite for prompt edits, not just for app code.

## 4. Model tier map + certification

**Criterion: a step needs the top model only when nothing external validates its
output — when its output IS the validator for everything downstream.**

| Tier | Steps | Guarded by |
|---|---|---|
| Cheapest (Haiku/Flash-class) | 1, 2, 10-scaffold, 18-cleanup, DET review halves, QA script-running lanes | deterministic gates (exit 2 on garbage) |
| Mid (Sonnet / Codex) | 7–9, 11–17, 19–23, 6, QA authoring, judgment review halves | build + tests + parity + reconciliation |
| Top (Opus-class, minimal) | **3** (the census everything reconciles against), **5** (`decisions.json`, consumed by 14 steps), **24** (final verdict) | nothing external — hence the spend |

**Certification protocol:** re-run a step on the proposed cheaper tier against the
fixture; same four checks as §1 (plus build/tests/parity for 7–18). Passes twice →
certified; pin in `model:` frontmatter. In production, **two-strikes escalation**:
a step blocking twice on quality grounds (not missing inputs) escalates one tier
and retries — mis-certification costs two cheap failures, never a broken run.
FileLog hint: any step that passed its gates first-try in the real run is a
certification candidate.

## 5. Ledger (fill in as you go)

| Prompt | Lines before → after | Baseline run | Re-run verdict | Tier certified |
|---|---|---|---|---|
| 08 | 518 → | | | |
| 24 | 1247 → | | | |
| 06 | 567 → | | | |
| 17 | 442 → | | | |
| 12 | 375 → | | | |

## 6. FileLog evidence checklist (what to bring from the work machine)

Priority order — item 1 alone rebuilds the cost model on real data:

1. `dir /s .modernization` — **file sizes** = real per-step input costs.
2. `run-decisions.md`, waiver registries, cannot-locate register.
3. Gate results / portal summary / scorecard — **which gates blocked, how many times**
   (the retry map = where credits actually went).
4. Small meta-artifacts (step confidence, reconciliation outputs).
5. Huge JSONs: first/last ~20 lines + entry count only.

Scrub internal hostnames/IDs/business data; lands in `runs/filelog/`, never
`_ignition-import/` (golden = kit files only).
