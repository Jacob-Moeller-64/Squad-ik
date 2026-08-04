# Ignition Kit — Pre-Hackathon Patch List

Ordered, copy-paste-able fixes for the **live kit at the work machine**. Each entry:
file, location, exact before/after, and why. Line numbers reference the golden
transcription in `_ignition-import/` (verified against photos); confirm against the
live file before editing — the live repo may have drifted.

Context: the org is on Copilot's **June 2026 usage-based billing** (AI Credits,
token-metered at per-model API rates, cached input ~10× cheaper, output ~5× input on
Sonnet-class models). Every standing-context token is now billed on every turn, so
Part A below is directly a cost fix as well as a correctness fix.

Scope discipline: these are **patches, not restructures**. No step merges, no
prompt→skill conversion, no roster changes — that is v2 work behind fixtures
(see `KIT-RESTRUCTURE-BLUEPRINT.md`). Apply on a branch; run one full step
end-to-end before merging; keep move commits separate from behavior commits.

---

## Part A — Standing-context cuts (do first; billed every turn of every step)

### A1. `.github/instructions/dotnet.instructions.md` — re-anchor glob

Line 3:

```yaml
# before
applyTo: "**/*.cs"
# after
applyTo: "src/**/*.cs"
```

Why: as written it also fires on every `LegacyCode/**` file an agent opens —
instructing the model to apply modernization standards to code the kit forbids
touching (correctness bug), and paying its tokens in every such context (cost bug).

### A2. `.github/instructions/angular.instructions.md` — re-anchor glob

Line 3:

```yaml
# before
applyTo: "**/*.ts,**/*.html,**/*.scss,**/*.css"
# after
applyTo: "src/**/*.ts,src/**/*.html,src/**/*.scss,src/**/*.css"
```

Same reasoning as A1. If toolkit `.mjs`/`.ts` maintenance files under `.github/`
should keep coverage, add explicit `.github/**` entries deliberately rather than
inheriting them from `**/*`.

### A3. `.github/instructions/frontend-modernization-learning.instructions.md` — narrow the prompts glob

Line 3, second entry in the list:

```yaml
# before
applyTo: '.github/scripts/QA/qa-refresh-portal.ps1,.github/prompts/*.md,.github/prompts/P2-Modernize/*.md,.github/agents/OpX-AppMod-P2-Modernize.agent.md'
# after
applyTo: '.github/scripts/QA/qa-refresh-portal.ps1,.github/prompts/1[0-8]-P2-*.prompt.md,.github/prompts/P2-Modernize/*.md,.github/agents/OpX-AppMod-P2-Modernize.agent.md'
```

Why: `.github/prompts/*.md` matches **all 24 numbered prompts**, so this ~10.4k-token
frontend post-mortem file loads into discovery, backend, and review steps that cannot
use it. The narrowed form keeps it on the frontend lane (Steps 10–18) where its rules
apply. This is the single largest per-step context cut available without restructuring.
(If glob-class syntax `[0-8]` is unsupported by the instructions loader, enumerate:
`10-*,11-*,…,18-*` — verify against a Step 7 chat that it no longer loads.)

### A4. Governance dedupe — the ~1.1k core card (the careful one)

Collapse `copilot-instructions.md` + `copilot.instructions.md` + `AGENTS.md` +
`constitution.md` into one always-on card (~1.1k tokens; nine-section outline in
`KIT-RESTRUCTURE-BLUEPRINT.md` §3.1: workspace map & boundaries; ONE precedence
ladder; gates & evidence; anti-hallucination evidence contract; artifact I/O
discipline; toolkit write-protection; behavior-preservation hygiene; security/feed
policy; remediation & escalation). `AGENTS.md` Non-negotiables is the base text;
`copilot.instructions.md` (~26k, the largest single always-on cost) retires — its
standards go into the card, its how-tos become task-discoverable content.
Resolves the 12 documented contradictions by declaring one owner each.
**Do this last in Part A, on a branch, and run one full step before trusting it.**

---

## Part B — Anti-rerun fixes (each prevents a stall→re-prompt→credits loop)

### B1. `.github/instructions/AppMod-Artifact-Contract.json` — 4 broken selfHeal paths

Lines 61, 67, 82, 316: the self-heal commands invoke
`.github/scripts/P1-Discovery/generate-manifest.ps1`. The file on disk (per the tree
and five cross-references: OpX-Code-Reviewer L218, Step 3 prompt L76, Step 4 prompt
L69, scan-functional-parity-ledger L67, verify-step-artifacts L726) is
**`03-P1-generate-manifest.ps1`**. Every self-heal fails with file-not-found today.

```
# before (4 occurrences)
-File .github/scripts/P1-Discovery/generate-manifest.ps1
# after
-File .github/scripts/P1-Discovery/03-P1-generate-manifest.ps1
```

### B2. `.github/agents/OpX-Code-Reviewer.agent.md` — resume-path filename mismatch

PART F (L504) and Step 5 (L540, L575) save progress to `review-results.json`; the
resume path (Step 1b, L229–245; "Recovering from Confusion", L125–147) and the
artifact contract only know `baseline-review.json` / `final-review.json` /
(undeclared) `vendor-review.json`. The agent writes under one name and resumes from
another — its context-exhaustion recovery cannot find its own progress.

Fix: make PART F / Step 5 save to the **per-mode contract filename**
(`.modernization/ignition-artifacts/discovery/baseline-review.json` for Baseline,
`.modernization/ignition-artifacts/reviews/final-review.json` for Final, and the
vendor equivalent), and delete the `review-results.json` name entirely.

### B3. Same file — broken verification-script path

L585:

```bash
# before
./verify-coverage.ps1
# after
./.github/scripts/P2-Modernize/verify-coverage.ps1
```

(The Step 4 prompt already uses the full path — L196.)

### B4. Same file — handoff target name

Frontmatter handoff "Generate Tests" targets `agent: Pre-Modernization-Test-Generator`;
the file on disk is `OpX-Pre-Modernization-Test-Generator.agent.md`. Align the `agent:`
value with whatever identifier the other handoffs resolve by (every other handoff in
the kit uses the prefixed name).

### B5. Vacuous-pass guards — the hackathon-critical one

Every participant brings a differently-shaped legacy app; a gate that exits 0 because
it *scanned nothing* ships a broken modernization as green, and the resulting
debugging session is the most expensive credit burn there is.

**`.github/scripts/parity/scan-api-dto-coverage.ps1`** — before the exit decision
(L222: `if ($gaps.Count -gt 0) { exit 2 } else { exit 0 }`), insert:

```powershell
if ($legacyDtos.Count -eq 0) {
    Write-Host "BLOCKED: no legacy View classes found under $LegacyRoot (filter '*View.cs'). Gate cannot run - pass -LegacyDtoFilter for this app's naming convention." -ForegroundColor Red
    exit 2
}
```

**`.github/scripts/parity/scan-backend-parity.ps1`** — before its exit decision
(L241), insert:

```powershell
if ($legacy.Count -eq 0) {
    Write-Host "BLOCKED: no legacy endpoints found under $LegacyRoot - gate could not run." -ForegroundColor Red
    exit 2
}
```

**`.github/scripts/parity/scan-functional-parity-ledger.ps1`** — the census input
already blocks (L66), but the two *evidence* inputs degrade to "everything is fine"
values. Replace the silent fallbacks at L119 and L135 with the same BLOCKED pattern:

```powershell
if (-not (Test-Path -LiteralPath $backendScanPath)) {
    Write-Host "BLOCKED: backend-parity-scan.json not found. Run scan-backend-parity.ps1 first." -ForegroundColor Red
    exit 2
}
if (-not (Test-Path -LiteralPath $uiScanPath)) {
    Write-Host "BLOCKED: ui-parity-gap-scan.json not found. Run scan-ui-parity-gaps.ps1 first." -ForegroundColor Red
    exit 2
}
```

and give the three empty `catch { }` blocks (L94, L128, L145) at minimum a
`Write-Host "BLOCKED: <file> exists but failed to parse"` + `exit 2` for the two
evidence loads — a truncated artifact must not read as a clean one.

### B6. `.github/scripts/parity/scan-functional-parity-ledger.ps1` — verb-attribute regex

L176/L179 require `]` immediately after the verb, so `[HttpPost("Search")]` — the
kit's own starter idiom (`MyEntitiesController.cs`) — is invisible, and a correctly
modernized app gets BLOCKED (fails closed, but wrongly). Align with the sibling
gate's correct pattern (`scan-backend-parity.ps1` uses `\b`):

```powershell
# before
'(?i)\[Http(?:Post|Put|Delete|Patch)\]'
'(?i)\[HttpGet\]'
# after
'(?i)\[\s*Http(?:Post|Put|Delete|Patch)\b'
'(?i)\[\s*HttpGet\b'
```

---

## Part C — Behavior/safety fixes

### C1. `src/Starter.Web.Client/src/app/fusion.config.prd.ts` — prod inherits dev auth

The prd config spreads `...fusionConfigBase` and overrides only `api` and `isDebug`.
The entire `auth` block is inherited from base — including **`devMode: true`** and
`https://localhost:5001` login/logout redirect URIs — into production. Add an explicit
auth override:

```typescript
export const fusionConfig: FusionConfig = {
    ...fusionConfigBase,
    api: {
        baseUrl: '/api'
    },
    auth: {
        ...fusionConfigBase.auth,
        devMode: false,
        logoutUrl: '<PROD_LOGOUT_CALLBACK_URL>',
        redirectUri: '<PROD_LOGIN_CALLBACK_URL>'
    },
    isDebug: false
};
```

(Same check for `.qa`/`.uat` variants: any environment file that does not explicitly
set `devMode`/redirects is inheriting the dev values. Shallow spread means overriding
`auth` replaces the whole object — hence the inner `...fusionConfigBase.auth` spread.)

### C2. Repo-wide mojibake (confirmed in 2 unrelated files)

`testing-design-contract.instructions.md` and `OpX-Code-Reviewer.agent.md` both
render em dashes / arrows / emoji / box-drawing as double-encoded UTF-8 (`Ã¢â‚¬â€¦`,
`ðŸ–¥ï¸`, `âœ…` …). This is a toolchain problem, not a typo. Find the blast radius:

```powershell
Get-ChildItem -Recurse -File -Include *.md,*.json,*.ts,*.ps1 |
  Select-String -Pattern 'Ã¢|ðŸ|â€|âœ|âš' -List | Select-Object Path
```

Fix (classic UTF-8-read-as-cp1252 double encoding — reverse it):

```python
# python3 fix-mojibake.py <file>...
import sys
for p in sys.argv[1:]:
    t = open(p, encoding='utf-8').read()
    try:
        fixed = t.encode('cp1252').decode('utf-8')
    except (UnicodeEncodeError, UnicodeDecodeError):
        print(f"SKIP (not cleanly reversible): {p}"); continue
    open(p, 'w', encoding='utf-8', newline='').write(fixed)
    print(f"fixed: {p}")
```

Run on a branch, eyeball the diff (should be *only* punctuation/emoji), and check
`git config core.autocrlf` / editor encoding settings to stop it recurring.

### C3. `OpX-Code-Reviewer.agent.md` — internal consistency

Cheap fixes that stop the template propagating bad output:

1. **Scoring examples disagree with the formula.** The formula (L531) gives **68**
   for the Step 7 example's 0 CRIT / 4 HIGH / 6 MED, but the report prints `72/100`
   (L614); Step 5's example JSON shows a *different* findings set (0/5/12/6) for the
   same 47-file review. Recompute one consistent worked example and use it in both.
2. **Two step-numbering schemes, both skipping 8.** Overview (L161–185) says Steps
   1–7, 9, 10, 11; body headings run 0, 1, 1b, 2–7, 9, 10 — and they don't map to
   each other. Renumber both to one contiguous scheme.
3. **Recommendations list numbering** (L929–942): 1, 2, 3, 4, 5, **7** → fix.
4. **Constructor-param threshold** stated as >5 (L95) and >7-HIGH/5–7-MEDIUM
   (PART C). Pick one (PART C's graded version is the better rule) and delete the other.

---

## Part D — Token-bill reducers inside the biggest agent

### D1. `OpX-Code-Reviewer.agent.md` — delete PART A's overlap with the script scan

L81–96 correctly says: scripts already detect these, don't duplicate. PART A then
re-specifies nine of those ten patterns as manual checks. Delete from PART A/C the
rows the deterministic scan owns — A2.10 (conn strings), A2.11 (URLs), A2.12 (static
mutable), A2.13 (session), A2.15 (file paths), A3.1 (Console.WriteLine), the
`new SqlConnection` overlap, and PART C's class-lines / ctor-params rows — and keep
PART B (judgment) untouched. The per-chunk prompt repeats **every chunk**, so a 47-file
review pays this trim back five times. Functionality is preserved because the
deterministic scan (the source of L81–96's claim) still runs.

### D2. Output-token discipline (Sonnet-class output ≈ 5× input)

- Keep the "do NOT wait for user input between chunks" pattern (it avoids whole
  re-prompt round-trips), but trim per-file narration: findings go to the artifact;
  chat shows the one-line progress block only.
- Prefer `-Quiet` on gate invocations whose full output would be echoed back into the
  model — after B5, `-Quiet` is safe because BLOCKED lines and exit codes survive it.

### D3. Cache-friendly context ordering

Cached input is ~10× cheaper. Keep each step's context prefix byte-stable across its
turns: card + scoped standards first (never edited mid-step), volatile artifacts and
transient state last. Iterate *within* one conversation per step (prefix caches after
turn 1), reset conversations at step boundaries per the artifact-handoff protocol.

### D4. Model routing + org guardrails

- Add `model:` pins per the tier map (`KIT-OPTIMIZATION-REVIEW.md` §tiering):
  mechanical/DET steps on the cheapest available model; judgment steps (3, 5, 6, 14,
  24, PART-B review) on the premium tier. Only 1/35 files pins today.
- **Set the org spending cap** (Settings → Billing → Copilot — no default limit
  exists) *before* the hackathon.
- Note: Sonnet promo token rates end **Aug 31, 2026** — budget the hackathon on
  post-promo rates if it lands later.

---

## Verification after applying

1. `verify-gate-integrity.ps1` + the four parity selftests still pass (B5/B6 touch
   scanned source — confirm the selftests' static assertions still find their
   patterns; update assertions only with a logged decision, per D-001 discipline).
2. One full Step 3 → Step 4 run on the mini-app: proves A1–A3 didn't starve a step
   of a standard it needed, B1's self-heal fires correctly, and the Code-Reviewer
   resume path round-trips (interrupt it once, resume in a fresh chat).
3. A deliberate vacuous-pass probe: point `scan-api-dto-coverage` at an empty
   directory — it must now exit 2, not green.
