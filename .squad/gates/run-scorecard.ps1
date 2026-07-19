#Requires -Version 7
# Gate launcher (Windows) — logic in ../scorecard/engine/engine.py; identical to run-scorecard.sh.
# Usage: run-scorecard.ps1 <before|after> [repo-root]
param(
  [Parameter(Mandatory)][ValidateSet('before', 'after')][string]$Phase,
  [string]$Root = '.'
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
$artifacts = if ($env:ARTIFACTS_DIR) { $env:ARTIFACTS_DIR } else { './artifacts' }
$extra = @(); if ($Phase -eq 'after') { $extra += '--enforce' }
& $py.Source (Join-Path $here '../scorecard/engine/engine.py') --phase $Phase --root $Root --artifacts $artifacts @extra
exit $LASTEXITCODE
