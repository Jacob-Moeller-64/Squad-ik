#!/usr/bin/env python3
"""Verify the kit's version pins are set and consistent (D-006, D-008).

Single source of gate logic — .sh/.ps1 launchers are thin shims.
Reads .squad/pins.json. Fails (exit 1) listing every unset/placeholder pin, so steps
whose authority is a pinned tool (06/11/12/16 -> Fusion MCP) halt until the pin is real
instead of improvising against an unspecified version.
Also cross-checks scorecardEngine against scorecard/VERSION.
"""
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SQUAD = HERE.parent.parent
PLACEHOLDER = re.compile(r"^\s*$|<.*>|TBD|TODO|null", re.IGNORECASE)

REQUIRED_PINS = [
    ("fusionMcpVersion", "Fusion MCP tool version (sole structure authority — D-006)"),
    ("fusionStarterKitVersion", "Fusion Starter Kit version"),
    ("scorecardEngine", "scorecard engine version (frozen per release — D-008)"),
]


def is_set(v):
    return isinstance(v, str) and v.strip() and not PLACEHOLDER.search(v)


def main():
    pins_path = SQUAD / "pins.json"
    if not pins_path.is_file():
        print(f"FAIL: {pins_path} missing")
        return 1
    pins = json.loads(pins_path.read_text())
    fail = False
    for key, why in REQUIRED_PINS:
        v = pins.get(key)
        if is_set(v):
            print(f"ok:   {key} = {v}")
        else:
            print(f"FAIL: {key} unset — {why}")
            fail = True

    engine_version = (SQUAD / "scorecard" / "VERSION").read_text().strip()
    if is_set(pins.get("scorecardEngine")) and pins["scorecardEngine"] != engine_version:
        print(f"FAIL: scorecardEngine pin {pins['scorecardEngine']} != scorecard/VERSION {engine_version}")
        fail = True
    return 1 if fail else 0


if __name__ == "__main__":
    sys.exit(main())
