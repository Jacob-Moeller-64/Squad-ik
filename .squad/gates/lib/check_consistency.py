#!/usr/bin/env python3
"""Fleet-consistency gate: verify two (or more) modernized apps converged to the same
target shape. Single source of gate logic — .sh/.ps1 launchers are thin shims.

Usage: check_consistency.py <app-root-1> <app-root-2> [more roots...]
Each root must contain the modernized src/{Library,API,Client} (and optionally
artifacts/). Checks are mechanical and structural — the point is that apps migrated
from DIFFERENT legacy stacks are indistinguishable in target conventions.

Exit 0 = consistent; 1 = divergence found (each divergence printed).
"""
import hashlib
import json
import re
import sys
from pathlib import Path

# Feature markers every modernized API entrypoint must (and must not) contain.
PROGRAM_REQUIRED = [
    (r"UseUrls\(", "configurable port binding (D-010)"),
    (r":8080", "8080 default port (D-010)"),
    (r"AddHealthChecks\(|MapHealthChecks\(", "health endpoints (D-010)"),
    (r"UseForwardedHeaders", "forwarded-headers middleware (D-010 / okta skill)"),
    (r"AddJwtBearer", "OIDC bearer auth (D-004 end-state)"),
    (r"AddOpenApi\(", "OpenAPI generation"),
    (r"MapScalarApiReference", "Scalar API docs"),
]
PROGRAM_FORBIDDEN = [
    (r"AddSession\(|UseSession\(", "session state (must be stateless)"),
    (r"AddCookie\(", "legacy cookie auth (strangler step 17 removes it)"),
    (r'password\s*=', "hardcoded credentials"),
]


def fail(msgs, text):
    msgs.append(text)


def check_app(root: Path, msgs):
    """Per-app shape checks; returns fingerprint dict for cross-app comparison."""
    fp = {"root": str(root)}
    for rel in ("src/Library", "src/API", "src/Client"):
        if not (root / rel).is_dir():
            fail(msgs, f"{root.name}: missing {rel}/")
    lib_proj = list((root / "src/Library").glob("*.csproj"))
    api_proj = list((root / "src/API").glob("*.csproj"))
    if lib_proj:
        text = lib_proj[0].read_text()
        m = re.search(r"<TargetFramework>([^<]+)</TargetFramework>", text)
        fp["library_tfm"] = m.group(1) if m else "?"
    if api_proj:
        text = api_proj[0].read_text()
        m = re.search(r"<TargetFramework>([^<]+)</TargetFramework>", text)
        fp["api_tfm"] = m.group(1) if m else "?"
        if "Scalar.AspNetCore" not in text:
            fail(msgs, f"{root.name}: API csproj missing Scalar.AspNetCore reference")
        if not re.search(r'ProjectReference[^>]*Library', text):
            fail(msgs, f"{root.name}: API does not reference Library (dependency direction)")

    program = root / "src/API/Program.cs"
    if program.is_file():
        text = program.read_text()
        for pattern, why in PROGRAM_REQUIRED:
            if not re.search(pattern, text):
                fail(msgs, f"{root.name}: Program.cs missing {why} [{pattern}]")
        for pattern, why in PROGRAM_FORBIDDEN:
            if re.search(pattern, text):
                fail(msgs, f"{root.name}: Program.cs contains forbidden {why} [{pattern}]")
    else:
        fail(msgs, f"{root.name}: src/API/Program.cs missing")

    ajson = root / "src/Client/angular.json"
    if ajson.is_file():
        doc = json.loads(ajson.read_text())
        projects = doc.get("projects", {})
        for name, proj in projects.items():
            build = proj.get("architect", {}).get("build", {}) or proj.get("targets", {}).get("build", {})
            fp["client_builder"] = build.get("builder", "?")
            prod = build.get("configurations", {}).get("production", {})
            fp["client_outputHashing"] = prod.get("outputHashing", build.get("options", {}).get("outputHashing", "?"))
    else:
        fail(msgs, f"{root.name}: src/Client/angular.json missing")

    pkg = root / "src/Client/package.json"
    if pkg.is_file():
        deps = json.loads(pkg.read_text()).get("dependencies", {})
        core = deps.get("@angular/core", "?")
        fp["angular_major"] = core.lstrip("^~").split(".")[0]

    styles = root / "src/Client/src/styles.css"
    if styles.is_file():
        text = styles.read_text()
        fp["styles_hash"] = hashlib.sha256(text.encode()).hexdigest()[:16]
        fp["has_fusion_tokens"] = "--fu-primary" in text
        if not fp["has_fusion_tokens"]:
            fail(msgs, f"{root.name}: styles.css lacks fusion-ui tokens")
    else:
        fail(msgs, f"{root.name}: src/Client/src/styles.css missing")

    art = root / "artifacts"
    if art.is_dir():
        after = art / "scorecard-after.json"
        if after.is_file():
            card = json.loads(after.read_text())
            fp["scorecard_after"] = card.get("total")
            fp["engine"] = card.get("engineVersion")
        cmap = art / "component-map.json"
        if cmap.is_file():
            rows = json.loads(cmap.read_text()).get("rows", [])
            not_done = [r["component"] for r in rows if r.get("status") not in ("done",) and r.get("classification") != "no-counterpart"]
            if not_done:
                fail(msgs, f"{root.name}: component-map rows not done: {not_done}")
    return fp


def main(argv):
    if len(argv) < 2:
        print("usage: check_consistency.py <app-root-1> <app-root-2> [...]", file=sys.stderr)
        return 2
    roots = [Path(a) for a in argv]
    msgs = []
    fps = [check_app(r, msgs) for r in roots]

    # Cross-app: these fingerprint keys must be IDENTICAL across the fleet.
    for key, why in [
        ("library_tfm", "Library target framework"),
        ("api_tfm", "API target framework"),
        ("client_builder", "Angular builder"),
        ("client_outputHashing", "outputHashing setting"),
        ("angular_major", "Angular major version"),
        ("styles_hash", "fusion design-system stylesheet (byte-identical)"),
        ("engine", "scorecard engine version"),
    ]:
        values = {fp.get(key) for fp in fps}
        if len(values) > 1:
            detail = ", ".join(f"{fp['root'].split('/')[-1]}={fp.get(key)}" for fp in fps)
            fail(msgs, f"cross-app divergence in {why}: {detail}")

    print(f"fleet-consistency: {len(roots)} apps compared")
    for fp in fps:
        print(f"  {fp['root'].split('/')[-1]}: tfm={fp.get('api_tfm')} angular={fp.get('angular_major')} "
              f"styles={fp.get('styles_hash')} after={fp.get('scorecard_after')}")
    if msgs:
        for m in msgs:
            print(f"FAIL: {m}")
        return 1
    print("ok: fleet is structurally consistent")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
