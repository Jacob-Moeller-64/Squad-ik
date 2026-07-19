#!/usr/bin/env python3
"""Squad-ik scorecard engine.

Frozen per kit release (D-008): the version that scores `before` scores `after`.
Deterministic by design — the single LLM-judged dimension (`qualitative`) is produced
OUTSIDE this engine and merged from artifacts/qualitative.json if present.

Usage: engine.py --phase before|after --root REPO [--artifacts DIR] [--out FILE] [--enforce]
Exit codes: 0 ok; 1 thresholds unmet (with --enforce); 2 usage error.
"""
import argparse
import datetime
import json
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

HERE = Path(__file__).resolve().parent
ENGINE_VERSION = (HERE.parent / "VERSION").read_text().strip()
RUBRIC_VERSION = "0.1.0"

SKIP_DIRS = {"bin", "obj", "packages", "node_modules", ".git", "vendor", "dist", "artifacts", "harness"}

DECISION_RE = re.compile(r"\b(if|for|foreach|while|case|catch)\b|&&|\|\|")
LOC_HOTSPOT = 300
DECISION_HOTSPOT = 50


def walk(root: Path, exts):
    for p in sorted(root.rglob("*")):
        if p.is_file() and p.suffix in exts and not (set(p.parts) & SKIP_DIRS):
            yield p


def read(p: Path) -> str:
    try:
        return p.read_text(errors="replace")
    except OSError:
        return ""


def finding(fid, summary, location=None, severity=None):
    f = {"id": fid, "summary": summary}
    if location:
        f["location"] = location
    if severity:
        f["severity"] = severity
    return f


# ---------- dependency manifest parsing ----------

def parse_manifests(root: Path):
    """Return list of (ecosystem, package, version, location)."""
    deps = []
    for pc in walk(root, {".config"}):
        if pc.name != "packages.config":
            continue
        try:
            for el in ET.parse(pc).getroot().iter("package"):
                deps.append(("nuget", el.get("id", ""), el.get("version", ""), str(pc.relative_to(root))))
        except ET.ParseError:
            pass
    for cs in walk(root, {".csproj"}):
        for m in re.finditer(r'PackageReference\s+Include="([^"]+)"\s+Version="([^"]+)"', read(cs)):
            deps.append(("nuget", m.group(1), m.group(2), str(cs.relative_to(root))))
    for pj in walk(root, {".json"}):
        if pj.name not in ("package.json", "bower.json"):
            continue
        try:
            doc = json.loads(read(pj))
        except json.JSONDecodeError:
            continue
        for section in ("dependencies", "devDependencies"):
            for name, ver in (doc.get(section) or {}).items():
                deps.append(("npm", name, str(ver).lstrip("^~>=< "), str(pj.relative_to(root))))
    return deps


def ver_tuple(v: str):
    nums = re.findall(r"\d+", v)
    return tuple(int(n) for n in nums[:4]) or (0,)


def ver_lt(a: str, b: str) -> bool:
    return ver_tuple(a) < ver_tuple(b)


# ---------- dimensions ----------

def dim_solid_and_complexity(root: Path):
    hotspots = []
    total = 0
    for f in walk(root, {".cs"}):
        total += 1
        text = read(f)
        loc = text.count("\n") + 1
        decisions = len(DECISION_RE.findall(text))
        if loc > LOC_HOTSPOT or decisions > DECISION_HOTSPOT:
            hotspots.append((str(f.relative_to(root)), loc, decisions))
    findings = [
        finding(f"solid-{i:03d}", f"Hotspot: {loc} LOC, {dec} decision points", path, "medium")
        for i, (path, loc, dec) in enumerate(hotspots)
    ]
    frac = (len(hotspots) / total) if total else 1.0
    solid = round(15 * max(0.0, 1 - 2 * frac))
    complexity = max(0, 5 - len(hotspots))
    if total == 0:
        findings.append(finding("solid-nocs", "No C# sources found — dimension scored 0", severity="info"))
        solid = 0
    return (solid, findings), (complexity, [])


def dim_twelve_factor(root: Path):
    pts, findings = 0, []
    code = {str(f.relative_to(root)): read(f) for f in walk(root, {".cs", ".config", ".json", ".js", ".ts"})}

    def anywhere(pattern):
        rx = re.compile(pattern)
        return next((loc for loc, t in code.items() if rx.search(t)), None)

    loc = anywhere(r"connectionString\s*=\s*\"[^\"]*(password|pwd)\s*=") or anywhere(r"(?i)(api[_-]?key|secret)\s*[:=]\s*[\"'][A-Za-z0-9+/]{12,}")
    if loc:
        findings.append(finding("12f-config", "Hardcoded credentials/secrets in config or code", loc, "high"))
    else:
        pts += 3
    loc = anywhere(r'(?i)initializeData\s*=\s*"[^"]*\.log"|WriteToFile|log4net.*RollingFile')
    if loc:
        findings.append(finding("12f-logs", "File-based logging configured; logs should go to stdout", loc, "medium"))
    else:
        pts += 3
    loc = anywhere(r"Session\[") or anywhere(r"HttpContext\.Current\.Session") or anywhere(r'sessionState[^>]*mode="InProc"')
    if loc:
        findings.append(finding("12f-state", "In-process session state — process is not stateless", loc, "high"))
    else:
        pts += 3
    if any(Path(l).name in ("packages.config", "package.json") or l.endswith(".csproj") for l in code):
        pts += 3
    else:
        findings.append(finding("12f-deps", "No declared dependency manifest found", severity="medium"))
    if anywhere(r"Environment\.GetEnvironmentVariable|builder\.Configuration|AddEnvironmentVariables"):
        pts += 3
    else:
        findings.append(finding("12f-env", "No environment-based configuration detected", severity="medium"))
    return pts, findings


def dim_security_cve(root: Path, deps):
    dataset = json.loads((HERE / "vuln-dataset.json").read_text())
    findings, worst = [], []
    for eco, name, ver, loc in deps:
        for v in dataset:
            if v["ecosystem"] == eco and v["package"].lower() == name.lower() and ver and ver_lt(ver, v["vulnerable_below"]):
                findings.append(finding(v["id"], f"{name} {ver} < {v['vulnerable_below']}: {v['summary']}", loc, v["severity"]))
                worst.append(v["severity"])
    if any(s == "critical" for s in worst):
        return 0, findings
    score = max(0, 20 - 5 * worst.count("high") - 2 * worst.count("medium") - 1 * worst.count("low"))
    if not deps:
        findings.append(finding("cve-nodeps", "No dependency manifests found to scan", severity="info"))
        score = 0
    return score, findings


def dim_dependency_eol(root: Path, deps):
    dataset = json.loads((HERE / "eol-dataset.json").read_text())
    findings = []
    texts = {str(f.relative_to(root)): read(f) for f in walk(root, {".csproj", ".config", ".json"})}
    for e in dataset:
        if e["kind"] == "pattern":
            rx = re.compile(e["pattern"])
            loc = next((l for l, t in texts.items() if rx.search(t)), None)
            if loc:
                findings.append(finding(e["id"], e["summary"], loc, "high"))
        elif e["kind"] == "package":
            for eco, name, ver, loc in deps:
                if eco == e["ecosystem"] and name.lower() == e["package"].lower() and (
                    "below" not in e or (ver and ver_lt(ver, e["below"]))
                ):
                    findings.append(finding(e["id"], f"{name} {ver}: {e['summary']}", loc, "high"))
                    break
    return max(0, 10 - 3 * len(findings)), findings


def dim_test_coverage(root: Path, artifacts: Path):
    reports = list(artifacts.glob("coverage/*.xml")) + list(artifacts.glob("coverage*.xml"))
    if not reports:
        return 0, [finding("cov-none", "No coverage report found (expected cobertura XML under artifacts/coverage/)", severity="medium")]
    try:
        rate = float(ET.parse(reports[0]).getroot().get("branch-rate", 0))
    except (ET.ParseError, TypeError, ValueError):
        return 0, [finding("cov-parse", f"Could not parse {reports[0].name}", severity="medium")]
    score = round(15 * min(1.0, rate / 0.70))
    fnd = [] if rate >= 0.70 else [finding("cov-low", f"Branch coverage {rate:.0%} below 70% threshold", severity="medium")]
    return score, fnd


def dim_ocp_readiness(root: Path, artifacts: Path):
    pts, findings = 0, []
    profile = {}
    pf = artifacts / "app-profile.json"
    if pf.exists():
        try:
            profile = json.loads(pf.read_text()).get("hazards", {})
        except json.JSONDecodeError:
            pass
    code = {str(f.relative_to(root)): read(f) for f in walk(root, {".cs", ".config"})}

    def anywhere(pattern):
        rx = re.compile(pattern)
        return next((loc for loc, t in code.items() if rx.search(t)), None)

    if profile.get("inProcSessionState") or anywhere(r"Session\[|InProc"):
        findings.append(finding("ocp-session", "In-process session state blocks multi-replica hosting", severity="high"))
    else:
        pts += 2
    loc = anywhere(r"Server\.MapPath|File\.(WriteAllText|AppendAllText|Create)\(")
    if loc or profile.get("localFileWrites"):
        findings.append(finding("ocp-files", "Local filesystem writes — pods are ephemeral", loc, "medium"))
    else:
        pts += 2
    loc = anywhere(r"Microsoft\.Win32\.Registry|System\.Drawing|System\.DirectoryServices|\bComImport\b")
    if loc or profile.get("windowsDependencies"):
        findings.append(finding("ocp-windows", "Windows-only dependencies present", loc, "high"))
    else:
        pts += 2
    if anywhere(r'ASPNETCORE_URLS|"urls"|UseUrls|:8080'):
        pts += 2
    else:
        findings.append(finding("ocp-port", "No configurable port detected (expect 8080 default via config)", severity="low"))
    if anywhere(r"MapHealthChecks|AddHealthChecks") and anywhere(r"UseForwardedHeaders"):
        pts += 2
    else:
        findings.append(finding("ocp-health", "Health endpoints and/or forwarded-headers middleware missing", severity="medium"))
    return pts, findings


def dim_qualitative(artifacts: Path):
    qf = artifacts / "qualitative.json"
    if not qf.exists():
        return 0, [finding("qual-notrun", "LLM-judged qualitative pass not run (artifacts/qualitative.json missing)", severity="info")]
    try:
        doc = json.loads(qf.read_text())
        return min(10, max(0, int(doc.get("score", 0)))), [
            finding(f.get("id", f"qual-{i}"), f.get("summary", ""), f.get("location"), f.get("severity"))
            for i, f in enumerate(doc.get("findings", []))
        ]
    except (json.JSONDecodeError, ValueError):
        return 0, [finding("qual-parse", "qualitative.json unreadable", severity="medium")]


THRESHOLDS_NOTE = "After-phase gate: no critical/high CVEs; coverage>=70%; total>=75; no dimension below its before score."


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--phase", required=True, choices=["before", "after"])
    ap.add_argument("--root", required=True)
    ap.add_argument("--artifacts", default="./artifacts")
    ap.add_argument("--out", default=None)
    ap.add_argument("--enforce", action="store_true", help="apply step-19 thresholds (after phase)")
    args = ap.parse_args()

    root, artifacts = Path(args.root), Path(args.artifacts)
    if not root.is_dir():
        print(f"error: root {root} not a directory", file=sys.stderr)
        return 2

    deps = parse_manifests(root)
    (solid, solid_f), (cx, cx_f) = dim_solid_and_complexity(root)
    results = {
        "solid": (solid, solid_f, 15, "mechanical"),
        "twelve-factor": (*dim_twelve_factor(root), 15, "mechanical"),
        "security-cve": (*dim_security_cve(root, deps), 20, "mechanical"),
        "dependency-eol": (*dim_dependency_eol(root, deps), 10, "mechanical"),
        "test-coverage": (*dim_test_coverage(root, artifacts), 15, "mechanical"),
        "complexity": (cx, cx_f, 5, "mechanical"),
        "ocp-readiness": (*dim_ocp_readiness(root, artifacts), 10, "mechanical"),
        "qualitative": (*dim_qualitative(artifacts), 10, "llm-judged"),
    }
    dimensions = [
        {"key": key, "kind": kind, "score": score, "max": mx, "findings": fnds}
        for key, (score, fnds, mx, kind) in results.items()
    ]
    total = round(sum(d["score"] for d in dimensions))

    card = {
        "engineVersion": ENGINE_VERSION,
        "rubricVersion": RUBRIC_VERSION,
        "scoredAt": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds"),
        "phase": args.phase,
        "total": total,
        "dimensions": dimensions,
    }
    out = Path(args.out) if args.out else artifacts / f"scorecard-{args.phase}.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(card, indent=2) + "\n")
    print(f"scorecard: total {total}/100 -> {out}")
    for d in dimensions:
        print(f"  {d['key']:<16} {d['score']:>3}/{d['max']:<3} ({len(d['findings'])} findings)")

    if args.enforce and args.phase == "after":
        errors = []
        cve = next(d for d in dimensions if d["key"] == "security-cve")
        if any(f.get("severity") in ("critical", "high") for f in cve["findings"]):
            errors.append("critical/high CVEs outstanding")
        cov = next(d for d in dimensions if d["key"] == "test-coverage")
        if cov["score"] < 15:
            errors.append("branch coverage below 70% threshold")
        if total < 75:
            errors.append(f"total {total} < 75")
        before = artifacts / "scorecard-before.json"
        if before.exists():
            prev = {d["key"]: d["score"] for d in json.loads(before.read_text())["dimensions"]}
            for d in dimensions:
                if d["key"] in prev and d["score"] < prev[d["key"]]:
                    errors.append(f"dimension {d['key']} regressed ({prev[d['key']]} -> {d['score']})")
        if errors:
            print("GATE FAIL: " + "; ".join(errors), file=sys.stderr)
            print(THRESHOLDS_NOTE, file=sys.stderr)
            return 1
        print("gate: thresholds met")
    return 0


if __name__ == "__main__":
    sys.exit(main())
