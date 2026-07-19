#!/usr/bin/env bash
# Step-04 reference runner: characterization suite + branch-coverage report for the
# scorecard engine (artifacts/coverage/coverage.xml, cobertura). Linux eval stand-in;
# on Windows run the equivalent MSTest/xUnit suite with
#   dotnet test --collect:"XPlat Code Coverage"  and copy the cobertura file to the same path.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p artifacts/coverage
python3 -m coverage run --branch --include="harness/pricing.py" -m unittest discover -s characterization -v 2>&1 | tail -4
python3 -m coverage xml -o artifacts/coverage/coverage.xml --include="harness/pricing.py"
python3 -m coverage report --include="harness/pricing.py"
