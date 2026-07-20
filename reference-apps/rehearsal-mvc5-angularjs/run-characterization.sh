#!/usr/bin/env bash
# Step-04 runner: characterization suite + branch coverage for the scorecard engine
# (artifacts/coverage/coverage.xml, cobertura). Windows: port assertions to xUnit
# against Services/*.cs and use dotnet test --collect:"XPlat Code Coverage".
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p artifacts/coverage
python3 -m coverage run --branch --include="harness/logic.py" -m unittest discover -s characterization -v 2>&1 | tail -3
python3 -m coverage xml -o artifacts/coverage/coverage.xml --include="harness/logic.py"
python3 -m coverage report --include="harness/logic.py"
