#!/usr/bin/env bash
# Gate: replay golden request/response pairs from endpoint-inventory.json against the
# app under test; every response must match its normalized golden.
# Usage: verify-goldens.sh <base-url>
# Exit 0 = all goldens match. Any mismatch or missing endpoint = exit 1.
set -euo pipefail

BASE_URL="${1:?usage: verify-goldens.sh <base-url>}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"
INV="$ARTIFACTS_DIR/endpoint-inventory.json"
[[ -f "$INV" ]] || { echo "FAIL: $INV missing — run step 01 first"; exit 1; }

# TODO(kit): implement replay —
#  for each endpoints[].goldens[]:
#    1. send requestFile against $BASE_URL (auth per endpoint.auth; test user from env)
#    2. normalize response per goldens[].normalizedFields
#    3. diff against responseFile; record pass/fail per golden
#  Print a summary table; exit non-zero on any failure.
# Keep this deterministic: no LLM involvement, no retries that mask flakiness.

echo "FAIL: verify-goldens.sh not yet implemented (safe default: red until wired)"
exit 1
