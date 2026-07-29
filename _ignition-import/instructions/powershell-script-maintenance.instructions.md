---
name: powershell-script-maintenance
description: Advisory maintenance rules for toolkit PowerShell scripts, including the analyzer settings file, safe warning cleanup priorities, and when to use scoped suppressions instead of risky rewrites.
applyTo: ".github/scripts/**/*.ps1"
---

# PowerShell Script Maintenance

This path-scoped instruction is part of the broader Ignition Kit maintenance bundle surfaced through `/.github/skills/ignition-kit-maintenance/SKILL.md`.

## Analyzer Stance

- `PSScriptAnalyzer` is advisory for this repo's operator-facing PowerShell scripts. It is not a hard gate.
- Use the repo-root `PSScriptAnalyzerSettings.psd1` file when running analyzer checks. It is not a hard gate.
- Prefer focused analyzer runs on the touched script or script family before and after edits.

## What To Fix First

- Fix low-risk warnings when behavior can stay unchanged, especially:
  - empty `catch` blocks that can become `Write-Verbose` best-effort handling
  - dead locals or obviously unused assignments
  - helper names that can be renamed safely inside a small file
  - accidental collisions with automatic variables such as `$Matches`
  - null-comparison bugs and similarly local correctness issues

## What To Suppress Instead Of Rewriting

- Prefer scoped suppressions when the warning is a side effect of the script's contract rather than a defect, for example:
  - stable operator-oriented helper names in large legacy scripts
  - compatibility parameters preserved for shared call signatures
  - builder functions that intentionally share a common parameter set even when one implementation does not use every parameter

## Script Style Notes

- Keep operator-facing output readable. `Write-Host` is allowed for interactive status output in these toolkit scripts.
- When failure is intentionally non-blocking, prefer `Write-Verbose` in `catch` blocks over silent suppression.
- Do not turn a safe maintenance pass into a large script redesign unless the active task explicitly requires it.
