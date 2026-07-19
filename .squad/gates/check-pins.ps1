#Requires -Version 7
# Gate launcher (Windows) — logic in lib/check_pins.py; identical behavior to check-pins.sh.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source (Join-Path $here 'lib/check_pins.py') @args
exit $LASTEXITCODE
