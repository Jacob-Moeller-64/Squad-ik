#Requires -Version 7
# Gate launcher (Windows) — logic in ../tools/visual/visual.js; identical to visual-diff.sh.
# Usage: visual-diff.ps1 <base-url> [-Capture] [tool args...]
param(
  [Parameter(Mandatory)][string]$BaseUrl,
  [switch]$Capture,
  [Parameter(ValueFromRemainingArguments)]$Rest
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not (Test-Path (Join-Path $here '../tools/visual/node_modules'))) {
  Write-Output "FAIL: run 'npm ci' in .squad/tools/visual first"
  exit 1
}
$mode = if ($Capture) { 'capture' } else { 'diff' }
& node (Join-Path $here '../tools/visual/visual.js') $mode $BaseUrl @Rest
exit $LASTEXITCODE
