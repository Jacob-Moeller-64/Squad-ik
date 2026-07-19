#!/usr/bin/env bash
# Gate + artifact producer: run the FROZEN scorecard engine (D-008).
# Usage: run-scorecard.sh <before|after> [repo-root]
# Writes $ARTIFACTS_DIR/scorecard-<phase>.json conforming to schemas/scorecard.schema.json.
# The engine version scoring 'before' MUST be the version scoring 'after' — the pin
# lives in ../scorecard/VERSION and is read-only to agents.
set -euo pipefail

PHASE="${1:?usage: run-scorecard.sh <before|after> [repo-root]}"
ROOT="${2:-.}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENGINE_VERSION="$(cat "$SCRIPT_DIR/../scorecard/VERSION")"

[[ "$PHASE" == "before" || "$PHASE" == "after" ]] || { echo "phase must be before|after"; exit 2; }

# TODO(kit): implement the mechanical dimensions (see ../scorecard/rubric.md):
#   solid-proxies    : complexity/coupling via analyzers (e.g. dotnet roslyn analyzers, lizard)
#   twelve-factor    : config-in-env, logs-to-stdout, statelessness heuristics
#   security-cve     : dependency scan (e.g. dotnet list package --vulnerable, npm audit)
#   dependency-eol   : framework/package EOL lookup against pinned dataset
#   test-coverage    : branch coverage over Library layer (characterization suite)
#   ocp-readiness    : port config, health endpoints, forwarded-headers, hazards from app-profile
# LLM-judged 'qualitative' dimension runs OUTSIDE this script (pinned rubric + anchors,
# best-of-3 median) and its JSON is merged in; this script must stay deterministic.

echo "FAIL: run-scorecard.sh engine not yet implemented (pin: $ENGINE_VERSION)"
exit 1
