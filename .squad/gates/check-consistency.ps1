#Requires -Version 7
# Gate launcher (Windows) — logic in lib/check_consistency.py; identical to check-consistency.sh.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source (Join-Path $here 'lib/check_consistency.py') @args
exit $LASTEXITCODE
