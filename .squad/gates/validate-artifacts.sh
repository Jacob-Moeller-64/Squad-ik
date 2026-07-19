#!/usr/bin/env bash
# Gate launcher — logic in lib/validate_artifacts.py (see its header for usage).
set -euo pipefail
exec python3 "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/validate_artifacts.py" "$@"
