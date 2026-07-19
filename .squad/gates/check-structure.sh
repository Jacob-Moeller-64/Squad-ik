#!/usr/bin/env bash
# Gate launcher — logic in lib/check_structure.py (see its header for usage).
set -euo pipefail
exec python3 "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/check_structure.py" "$@"
