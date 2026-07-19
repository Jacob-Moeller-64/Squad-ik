#Requires -Version 7
# Gate launcher (Windows) — logic in lib/verify_goldens.py; identical behavior to verify-goldens.sh.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source (Join-Path $here 'lib/verify_goldens.py') @args
exit $LASTEXITCODE
