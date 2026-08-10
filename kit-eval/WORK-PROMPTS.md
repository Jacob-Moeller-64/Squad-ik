# Work-Machine Prompts — kit optimization via the kit's own maintenance agent

Paste these into Copilot at the work machine, **one at a time, in order**, addressed
to the kit-maintenance agent (`Ultimate-Ignition-edit`), on a **mid-tier model**
(never the top tier — this is mechanical editing with verification).

Rules of engagement (why the prompts are written this way):
- Every prompt opens with the same guardrail preamble — scope lock, branch, no gate
  weakening. Copilot bills tokens now; the preamble is short on purpose.
- One prompt = one commit scope. Run them in order; stop if any verification fails.
- Two things are NOT prompts — do them by hand first:
  1. **Spending cap**: Settings → Billing → Copilot (no default limit exists).
  2. **Mojibake scan**: `Get-ChildItem -Recurse -File -Include *.md,*.json,*.ps1 | Select-String -Pattern 'Ã¢|ðŸ|â€' -List | Select-Object Path`
     — fix via the reversal script in PATCH-LIST.md §C2 (encoding repair by prompt
     risks the model "fixing" content, not just bytes).

---

## Prompt 0 — Reconnaissance (run FIRST, cheapest model, edits nothing)

The live kit has files the analysis never saw. This prompt verifies every
assumption the later prompts rely on, and its output is the drift report to
bring back for reconciliation. If any count below surprises you, stop and
compare before running Prompts 1-6.

```text
Reconnaissance only - make NO edits, create NO files.
1. Print a tree of .github/ (instructions, prompts incl. subfolders, agents,
   skills, scripts, contracts, templates) with per-file line counts.
2. List every file whose content matches the mojibake pattern 'Ã¢|ðŸ|â€'.
3. Report exact match counts and line numbers for:
   a. "generate-manifest.ps1" inside .github/instructions/AppMod-Artifact-Contract.json
   b. "review-results.json" inside .github/agents/
   c. bare "./verify-coverage.ps1" invocations anywhere
   d. the applyTo frontmatter lines of dotnet.instructions.md,
      angular.instructions.md, frontend-modernization-learning.instructions.md
   e. the literal regexes containing "[Http" in .github/scripts/parity/
   f. the final exit decision lines of scan-api-dto-coverage.ps1 and
      scan-backend-parity.ps1
4. Report every directory in the repo that looks like a completed modernization
   run or app (a src/ tree with a non-Starter app name, or a .modernization/
   folder with artifacts): its path, file count, and total size. State whether
   any .modernization/ folder sits at the REPO ROOT.
Output one compact report, grouped by the numbers above.
```

---

## Preamble (prepend to every prompt below)

```text
You are performing toolkit maintenance under kit-update.instructions.md. Work on
branch kit/token-opt. Make ONLY the changes listed in this prompt - no other
improvements, renames, or reformatting. Never weaken, soften, or bypass a gate;
guards may only be ADDED. Do not touch LegacyCode/, the scorecard, or any file
not named here. One commit per numbered item, message prefix "kit-opt:". After
each item, show me the diff summary. If any verification step fails, STOP and
report - do not work around it.
```

---

## Prompt 1 — Anti-rerun correctness patches

```text
1. In .github/instructions/AppMod-Artifact-Contract.json: find every occurrence of
   "P1-Discovery/generate-manifest.ps1" and change it to
   "P1-Discovery/03-P1-generate-manifest.ps1" (there should be ~4, in selfHeal
   commands). Change nothing else in the file; it must remain valid JSON.
2. In .github/agents/OpX-Code-Reviewer.agent.md: the agent saves progress to
   "review-results.json" (PART F and Step 5) but resumes from
   baseline-review.json / final-review.json (Step 1b). Fix by replacing every
   save-target reference to review-results.json with the per-mode contract path:
   .modernization/ignition-artifacts/discovery/baseline-review.json for Baseline,
   .modernization/ignition-artifacts/reviews/final-review.json for Final, and
   .modernization/ignition-artifacts/reviews/vendor-review.json for Vendor.
   Update the Step 5 heading/example accordingly.
3. Same file: replace the bare "./verify-coverage.ps1" invocation with
   "./.github/scripts/P2-Modernize/verify-coverage.ps1".
4. Same file: the "Generate Tests" handoff targets
   agent: Pre-Modernization-Test-Generator. Change it to the prefixed name
   OpX-Pre-Modernization-Test-Generator, matching the file on disk.
Verify: python or pwsh JSON-parse the contract file; grep the agent file to show
zero remaining "review-results.json" references.
```

## Prompt 2 — Vacuous-pass guards + verb regex (gates become strict, never looser)

```text
1. .github/scripts/parity/scan-api-dto-coverage.ps1: immediately BEFORE the final
   exit decision (if ($gaps.Count -gt 0) { exit 2 } else { exit 0 }), insert:
     if ($legacyDtos.Count -eq 0) {
         Write-Host "BLOCKED: no legacy View classes found under $LegacyRoot (filter '*View.cs'). Gate cannot run - pass -LegacyDtoFilter for this app's naming convention." -ForegroundColor Red
         exit 2
     }
2. .github/scripts/parity/scan-backend-parity.ps1: immediately BEFORE its final
   exit decision, insert:
     if ($legacy.Count -eq 0) {
         Write-Host "BLOCKED: no legacy endpoints found under $LegacyRoot - gate could not run." -ForegroundColor Red
         exit 2
     }
3. .github/scripts/parity/scan-functional-parity-ledger.ps1: the backend-scan and
   ui-scan evidence inputs currently default to zero counts when missing. Replace
   those silent fallbacks with BLOCKED + exit 2 blocks naming the producing script
   (scan-backend-parity.ps1 / scan-ui-parity-gaps.ps1). Also: the two empty
   catch { } blocks on those evidence loads must emit
   "BLOCKED: <file> exists but failed to parse" and exit 2.
4. Same file: change the endpoint regexes
   '(?i)\[Http(?:Post|Put|Delete|Patch)\]'  ->  '(?i)\[\s*Http(?:Post|Put|Delete|Patch)\b'
   '(?i)\[HttpGet\]'                        ->  '(?i)\[\s*HttpGet\b'
Verify: run the parity selftests (.github/scripts/parity/selftest-*.ps1) and
verify-gate-integrity.ps1 - all must pass. Then run scan-api-dto-coverage.ps1
against an EMPTY temp directory as LegacyRoot: it must exit 2, not 0. Report the
exit codes.
```

## Prompt 3 — Context-scoping glob edits (the big per-turn token cut)

```text
1. .github/instructions/dotnet.instructions.md frontmatter:
   applyTo: "**/*.cs"  ->  applyTo: "src/**/*.cs"
2. .github/instructions/angular.instructions.md frontmatter:
   applyTo: "**/*.ts,**/*.html,**/*.scss,**/*.css"
   ->  applyTo: "src/**/*.ts,src/**/*.html,src/**/*.scss,src/**/*.css"
3. .github/instructions/frontend-modernization-learning.instructions.md
   frontmatter: in the applyTo list, replace the entry ".github/prompts/*.md"
   with ".github/prompts/10-*.prompt.md,.github/prompts/11-*.prompt.md,.github/prompts/12-*.prompt.md,.github/prompts/13-*.prompt.md,.github/prompts/14-*.prompt.md,.github/prompts/15-*.prompt.md,.github/prompts/16-*.prompt.md,.github/prompts/17-*.prompt.md,.github/prompts/18-*.prompt.md"
   keeping the other entries unchanged.
Change nothing but the applyTo lines. Verify: print each file's frontmatter.
```

## Prompt 4 — Production config inheritance fix

```text
src/*/Starter.Web.Client/src/app/fusion.config.prd.ts (or the app's renamed
equivalent under src/<App>.Web.Client): the config spreads fusionConfigBase but
never overrides auth, so production inherits devMode: true and localhost:5001
redirect/logout URIs. Add an auth override:
    auth: {
        ...fusionConfigBase.auth,
        devMode: false,
        logoutUrl: '<PROD_LOGOUT_CALLBACK_URL>',
        redirectUri: '<PROD_LOGIN_CALLBACK_URL>'
    },
Leave the placeholder URLs as-is for the deploy-values substitution step. Apply
the same check to fusion.config.qa.ts and fusion.config.uat.ts: any variant not
explicitly setting devMode/redirects is inheriting dev values - report which ones
are affected before editing them.
```

## Prompt 5 — Step 8 prompt trim (the template for all prompt trims)

```text
Optimize .github/prompts/08-P2-backend-modernization-formation.prompt.md for
token cost with zero functional change, using exactly these three moves:
1. DELETE the "Code Quality Standards (MANDATORY)" block - it restates
   dotnet.instructions.md, which auto-loads on the same src/**/*.cs files the
   step edits. Do NOT delete the Authorization Policy DI checklist inside it -
   move that checklist into dotnet.instructions.md instead (it is a learned
   runtime-500 trap, not a duplicate).
2. MOVE the embedded unit-test scaffolding (the .csproj XML, GlobalUsings.cs,
   and directory-skeleton blocks) into real files under
   .github/templates/backend-unit-tests/, and replace them in the prompt with
   one line: "Copy the unit test scaffold from .github/templates/backend-unit-tests/
   substituting {AppName}."
3. COMPRESS the Objective prose to bullets that name artifacts and decisions.
   Preserve VERBATIM: all status classification values, artifact paths, gate
   invocations, MANDATORY guardrail sections, and failure handling.
Report before/after line counts. Do not touch any other prompt.
```

## Prompt 6 — Verification run (after 1–5, before merging)

```text
On branch kit/token-opt, run the Step 3 -> Step 4 sequence against the mini
calibration app in a fresh chat per step, using only each step's prompt file and
its declared requiredInputs. After each step run
.github/scripts/shared/verify-step-artifacts.ps1 -Step N -Mode Output and report
the RESULT lines. Then: interrupt the Step 4 review after chunk 1, start a fresh
chat, say "Continue the review", and confirm it resumes from the saved progress
file without re-reviewing files. Report: every gate result, the resume behavior,
and any step that needed more than one attempt. Do not fix anything in this run -
this is measurement only.
```

---

After all six: merge kit/token-opt, then proceed to the playbook loop
(PROMPT-OPT-PLAYBOOK.md) for prompts 24, 06, 17, 12, and tier certification.
