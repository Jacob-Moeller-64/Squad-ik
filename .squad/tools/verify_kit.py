#!/usr/bin/env python3
"""Kit self-test: prove a fresh clone works on this machine.

Run from the repo root via verify-kit.sh / verify-kit.ps1. Exercises every engine and
gate against the bundled mini reference app and prints a PASS/FAIL summary.
Exit 0 = kit healthy on this machine.

Steps marked [info] don't fail the run:
- visual diff: stored baselines were captured on Linux; other OSes render fonts
  differently, so cross-OS diffs are expected until you re-capture locally.
- check-pins: red until your org sets real Fusion pins in .squad/pins.json — that
  red is the gate working as designed.
"""
import json
import os
import shutil
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SQUAD = ROOT / ".squad"
MINI = ROOT / "reference-apps" / "mini-mvc5-angularjs"
PORT = "8991"
results = []


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


def record(name, ok, detail="", info=False):
    tag = "info" if info else ("PASS" if ok else "FAIL")
    results.append((name, ok, info))
    print(f"[{tag}] {name}" + (f" — {detail}" if detail else ""))
    return ok


def main():
    py = sys.executable
    print(f"repo: {ROOT}")

    # 1. Prerequisites
    record("python >= 3.10", sys.version_info >= (3, 10), sys.version.split()[0])
    node = shutil.which("node")
    record("node available", bool(node), node or "install Node 22+")
    try:
        import jsonschema  # noqa: F401
        record("python jsonschema", True)
    except ImportError:
        record("python jsonschema", False, "pip install jsonschema")
    try:
        import coverage  # noqa: F401
        has_cov = True
    except ImportError:
        has_cov = False
    record("python coverage", has_cov, "" if has_cov else "pip install coverage (needed for characterization coverage)")

    # 2. Unit tests (engine + gate libs)
    for name, d in [("scorecard engine unit tests", SQUAD / "scorecard" / "engine"),
                    ("gate lib unit tests", SQUAD / "gates" / "lib")]:
        r = run([py, "-m", "unittest", "discover", "-s", str(d)])
        record(name, r.returncode == 0, (r.stderr.strip().splitlines() or [""])[-1])

    # 3. Characterization suite (mini app)
    r = run([py, "-m", "unittest", "discover", "-s", str(MINI / "characterization")], cwd=str(MINI))
    record("characterization suite (14 tests)", r.returncode == 0, (r.stderr.strip().splitlines() or [""])[-1])

    # 4. Artifact validation
    env = {**os.environ, "ARTIFACTS_DIR": str(MINI / "artifacts")}
    r = run([py, str(SQUAD / "gates" / "lib" / "validate_artifacts.py"), "all"], env=env)
    record("validate-artifacts all", r.returncode == 0, "" if r.returncode == 0 else r.stdout.strip())

    # 5. Scorecard engine against the legacy mini app
    r = run([py, str(SQUAD / "scorecard" / "engine" / "engine.py"), "--phase", "before",
             "--root", str(MINI / "LegacyApplication"),
             "--artifacts", str(MINI / "artifacts"),
             "--out", str(MINI / "artifacts" / "scorecard-selftest.json")])
    total = None
    if r.returncode == 0:
        total = json.loads((MINI / "artifacts" / "scorecard-selftest.json").read_text())["total"]
        (MINI / "artifacts" / "scorecard-selftest.json").unlink()
    # 42 = canonical pre-coverage baseline; 57 = with the characterization coverage
    # artifact present (see mini README). Both prove the engine works; anything else is drift.
    record("scorecard engine on mini app", r.returncode == 0 and total in (42, 57),
           f"total={total} (expected 42, or 57 with coverage artifact present)")

    # 6. Harness + goldens replay (type-strict, incl. auth + 302)
    proc = subprocess.Popen([py, str(MINI / "harness" / "serve.py"), "--port", PORT],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        up = False
        for _ in range(20):
            try:
                urllib.request.urlopen(f"http://localhost:{PORT}/Products/List", timeout=1)
                up = True
                break
            except OSError:
                time.sleep(0.25)
        record("harness starts", up)
        if up:
            r = run([py, str(SQUAD / "gates" / "lib" / "verify_goldens.py"),
                     f"http://localhost:{PORT}", str(MINI / "artifacts" / "endpoint-inventory.json")],
                    env={**env, "TEST_COOKIE": ".ASPXAUTH=demo-ticket"})
            last = (r.stdout.strip().splitlines() or [""])[-1]
            record("goldens replay (11 goldens)", r.returncode == 0, last)

            # 7. Visual diff [info]: cross-OS font rendering makes diffs expected off-Linux.
            if (SQUAD / "tools" / "visual" / "node_modules").is_dir() and node:
                r = run([node, str(SQUAD / "tools" / "visual" / "visual.js"), "diff", f"http://localhost:{PORT}"],
                        env=env, cwd=str(MINI))
                clean = r.returncode == 0
                record("visual diff vs stored baselines", True, info=True,
                       detail="clean" if clean else "diffs found — expected on non-Linux (font rendering); re-capture baselines locally with visual-diff --capture")
            else:
                record("visual diff", True, "skipped — run 'npm ci' in .squad/tools/visual (and ensure Chromium/CHROMIUM_PATH)", info=True)
    finally:
        proc.terminate()

    # 8. check-pins [info]: red-by-design until Fusion pins are set.
    r = run([py, str(SQUAD / "gates" / "lib" / "check_pins.py")])
    record("check-pins", True, info=True,
           detail="pins set" if r.returncode == 0 else "red until .squad/pins.json Fusion pins are set — working as designed")

    required = [(n, ok) for n, ok, info in results if not info]
    failed = [n for n, ok in required if not ok]
    print(f"\n{'=' * 60}\nverify-kit: {len(required) - len(failed)}/{len(required)} required checks passed"
          + (f"; FAILED: {', '.join(failed)}" if failed else " — kit is healthy on this machine"))
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
