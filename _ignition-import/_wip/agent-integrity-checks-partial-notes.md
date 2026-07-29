# `agent-integrity-checks.instructions.md` — partial transcription notes

Photos read: **7 of 7 — file complete at source lines 1-383** (384 blank). Full verbatim
transcription not yet written — this file is ~90% PowerShell and very dense. These notes capture
the structure and every finding.

## Frontmatter (lines 1-5) — a new mechanism

```yaml
name: agent-integrity-checks
description: Documented integrity-check command sequence for modernization agents, prompts, skill references, and prompt-length drift.
applyTo: ".github/agents/*.agent.md,.github/prompts/**/*.prompt.md,.github/instructions/*.md"
```

**`applyTo:` is the VS Code Copilot instructions glob convention** — it makes an instruction file
auto-apply when the model touches matching paths. This is the first `applyTo:` seen in the kit and
it explains how instruction files attach without being explicitly referenced: **they do not need
to be named by a prompt or agent.** That resolves the "15 of 25 instruction files are referenced
by nothing" concern from the manifest — reference is not the loading mechanism for this layer.

## Structure

`## Purpose` lists 10 detections (lines 13-22). `## Recommended PowerShell Checks` then contains
numbered checks:

| # | Check | Notes |
|---|---|---|
| 0 | Gate Self-Test Integrity | runs `.github/scripts/parity/verify-gate-integrity.ps1`; auto-discovers every `selftest-*.ps1` beside a gate script, "no registration step" |
| 0b | Legacy Functionality-Parity Gate | runs `.github/scripts/parity/scan-backend-parity.ps1` |
| 1 | Missing Prompt Targets | scans `.github/agents/*.agent.md` for `prompt:` route targets that do not resolve |
| 2 | Overlong Prompt Strings | flags handoff `prompt:` strings `>= 130` chars |
| 3 | Retired Numbered-Flow State Tracker References | see the obfuscation note below |
| 4 | Stale Skill Paths And Maintainer Notes | greps `\.skill\.md`, `needs to be updated`, `TODO:` |
| 5 | Step And QA Coverage Drift | cross-checks `AppMod-Step-Contract.json` against each prompt's frontmatter `agent:` and against `OpX-QA-Hub.agent.md` |
| 6 | Modernize QA Timing Drift | see finding 2 |
| 7 | Discovery Handoff Drift | see finding 1 |
| 8 | Planning Prompt Load Drift | `$step6` → prompt 04, `$step7` → prompt 05 |
| 9 | Review Prompt Load Drift | `$step23` → prompt 21, `$step24` → prompt 22, `$step25` → prompt 23 |
| 10 | Step 7 Required Outputs Drift | `$step7` → prompt 05; asserts three named reports by explicit path |

Closes with `### Runtime verification (per-app)` (a disk check for the three reports) and
`## Review Rule`.

## ⚠ FINDING 1 — the definitive proof of the +2 drift, and it is operator-facing

Check 7 (Discovery Handoff Drift), lines 216-232:

```powershell
$step5 = Get-Content '.github/prompts/03-P1-legacy-system-analysis.prompt.md' -Raw
if ($step5 -notmatch 'Discovery carry-forward') {
  $issues += 'Step 5 missing Discovery carry-forward section.'
}

$step6 = Get-Content '.github/prompts/04-P1-baseline-acceptance-criteria-review.prompt.md' -Raw
  ... 'Step 6 missing ranked Step 7 planning inputs wording.'

$step7 = Get-Content '.github/prompts/05-P1-modernization-solution-design.prompt.md' -Raw
  ... 'Step 7 missing Discovery Carry-Forward Disposition section.'
```

Check 8 repeats it (`$step6` → `04-P1-…`, `$step7` → `05-P1-…`), and check 9 does it for review:
`$step23` → `21-P3-figma-review`, `$step24` → `22-P3-final-acceptance-criteria-review`.

**Every file path is correct. Every variable name and every operator-facing message is +2.**

| Variable / message | Actual file | Actual step |
|---|---|---|
| `$step5` / "Step 5 missing…" | `03-P1-legacy-system-analysis` | 3 |
| `$step6` / "Step 6 missing…" | `04-P1-baseline-acceptance-criteria-review` | 4 |
| `$step7` / "Step 7 missing…" | `05-P1-modernization-solution-design` | 5 |
| `$step23` / "Step 23 missing…" | `21-P3-figma-review` | 21 |
| `$step24` / "Step 24 missing…" | `22-P3-final-acceptance-criteria-review` | 22 |

This is the most operationally damaging drift instance found anywhere, because **it lives in a
diagnostic tool**. Every other stale reference misleads a model reading a document; this one prints
a wrong step number **to a human** who is trying to fix a real defect. A developer told "Step 5
missing Discovery carry-forward section" will open prompt 05 (Modernization Solution Design) and
find nothing wrong, while the actual gap is in prompt 03.

It is also the cleanest confirmation of the offset: same line, correct path and stale label, five
times, with no ambiguity.

## ⚠ FINDING 1b — check 9 is internally inconsistent, block by block

Within the single "Review Prompt Load Drift" check, three near-identical blocks disagree:

| Block | Variable | Path read | Message says | Verdict |
|---|---|---|---|---|
| a | `$step23` | `21-P3-figma-review` | "Step 23 missing…" | message **stale** |
| b | `$step24` | `22-P3-final-acceptance-criteria-review` | "Step 24 missing…" | message **stale** |
| c | `$step25` | `23-P3-final-readiness-review` | **"Step 23 missing…"** | message **correct**, variable stale |

Block c is the giveaway: the variable was renamed on the old scheme (`$step25`) while its messages
were updated to the new scheme ("Step 23"). Blocks a and b had neither updated. This is the
per-line update pattern seen in prompt 21 and `OpX-AppMod-P2-Modernize`, here reproduced *inside a
single check* — which is why a blanket find-and-replace on this file would be wrong.

## ⚠ FINDING 2 — check 6 can never fire

Line 174 (and repeated at 203):

```powershell
$_.Name -match '^(09|10|11|12|13|14|15|16|17|18|19|20)-DEV-P2-.*\.prompt\.md$'
```

The kit's actual prompt filenames are `NN-P2-name.prompt.md` — for example
`07-P2-backend-upgrade-dotnet.prompt.md`. **There is no `DEV-` segment in any filename.** The
pattern matches zero files, so "Modernize QA Timing Drift" silently reports `clean` on every run.

Two independent errors in one regex: the `-DEV-` segment does not exist, and the numeric range
`09-20` does not match P2's actual span (Steps 7-18).

## ⚠ FINDING 3 — the retired-tracker check obfuscates its own search term

Lines 95-104 build the search string from character codes:

```powershell
$retiredStateToken = -join @(112,114,111,103,114,101,115,115 | ForEach-Object { [char]$_ })
```

Those decode to **`progress`** — the check is hunting for lingering references to a retired
`progress.json` numbered-flow state tracker under
`.modernization/ignition-artifacts/modernize/fusion-restructure/`. The codes are used so the
integrity-check file does not match its own search pattern when scanned.

Clever, but undocumented: nothing in the file explains what the token is, so a maintainer editing
this check has to decode it by hand. A comment would cost one line.

## Three new top-level artifacts

Check 10 asserts prompt 05 names these by **explicit path**, and forbids reverting to glob naming
(`Refresh \`Modernization-Solution-Design\.\*\``):

- `.modernization/ignition-artifacts/Modernization-Solution-Design.md`
- `.modernization/ignition-artifacts/Modernization-Execution-Contract.md`
- `.modernization/ignition-artifacts/Modernization-Phase-Assessment.md`

Three markdown reports at the `ignition-artifacts/` **root** — not under `discovery/`,
`modernize/`, or `reviews/`. `Modernization-Execution-Contract.md` is notable: `OpX-dotnet-upgrade`
repeatedly cites `Modernization-Execution-Contract.*` as the definition of the Step 7 upgrade
workspace, so this is that file. The runtime check tests both existence **and zero-byte length**:

```powershell
Where-Object { -not (Test-Path $_) -or (Get-Item $_).Length -eq 0 }
```

with the failure message "Step 7 outputs MISSING or zero-byte (Step 9/10 will fail-fast)" — under
the +2 offset, Steps 5's outputs gate Steps 7/8.

## Closing Review Rule

> - Run these checks after route extraction, step-label renames, QA workflow renames, or QA
>   timing-contract edits.
> - **Treat failures as process-surface defects even when code generation is otherwise
>   unaffected.**

That second line is the clearest statement in the kit of why this whole drift class matters: the
generated code can be fine and the process surface still be broken.

## Other surfaces named

- `.github/scripts/parity/verify-gate-integrity.ps1` — expected output
  `GATE INTEGRITY: all N gate self-test(s) passed (M assertions).` (exit 0)
- `.github/scripts/parity/scan-backend-parity.ps1` — exit 2 means a legacy mutation endpoint
  (POST/PUT/DELETE/PATCH) has no modern counterpart
- `.modernization/ignition-artifacts/discovery/backend-parity-registry.json` with `acceptedDrops[]`
- `DeadControl` — the parity scanner's UI-side kind for "a legacy interactive control ported as a
  label-only stub with no behavior — a dead nav link or dead button"
- `.github/agents/OpX-QA-Hub.agent.md` — confirms the QA Hub agent file exists
- The gate self-test convention: `selftest-*.ps1` beside a gate script is auto-discovered

## Doctrine worth keeping

> A gate is only trustworthy if it fires on known-bad code **and stays silent on known-good code**
> — this runner proves both in one step.

> The backend functionality-parity scanner is the deterministic guard against silently dropping
> the write path (Add/Edit/Delete/Link/Export) while the UI still shows the buttons over
> placeholder modals.

## Remaining work

- Full verbatim transcription of lines 1-383 not yet written (structure and findings captured
  above). The file is dense PowerShell; transcribing it verbatim is worthwhile but large.
