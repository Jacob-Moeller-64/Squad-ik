#Requires -Version 7
# Gate launcher (Windows) — logic in lib/validate_artifacts.py; identical behavior to validate-artifacts.sh.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source (Join-Path $here 'lib/validate_artifacts.py') @args
exit $LASTEXITCODE
