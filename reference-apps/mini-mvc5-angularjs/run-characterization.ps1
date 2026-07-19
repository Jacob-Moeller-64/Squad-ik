#Requires -Version 7
# Windows twin of run-characterization.sh — same suite, same coverage artifact.
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)
New-Item -ItemType Directory -Force -Path artifacts/coverage | Out-Null
$py = (Get-Command python3 -ErrorAction SilentlyContinue) ?? (Get-Command python)
& $py.Source -m coverage run --branch --include="harness/pricing.py" -m unittest discover -s characterization -v
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
& $py.Source -m coverage xml -o artifacts/coverage/coverage.xml --include="harness/pricing.py"
& $py.Source -m coverage report --include="harness/pricing.py"
exit $LASTEXITCODE
