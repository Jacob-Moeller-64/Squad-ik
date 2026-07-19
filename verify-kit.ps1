#Requires -Version 7
# Kit self-test launcher (Windows) — logic in .squad/tools/verify_kit.py. Run after cloning.
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source (Join-Path $here '.squad/tools/verify_kit.py') @args
exit $LASTEXITCODE
