# Scorecard Rubric — v0.1.0

**Read-only to agents (D-008).** Scoring is executed by `gates/run-scorecard.sh`; the
engine version that scores `before` scores `after`. Changing this rubric is a kit
release, never a mid-run edit.

Total: 100 points. Mechanical dimensions are scripted; the single LLM-judged dimension
uses pinned anchors and a best-of-3 median.

| Key | Kind | Pts | What it measures |
|---|---|---|---|
| `solid` | mechanical (proxies) | 15 | Cyclomatic complexity, class coupling, dependency direction, method length — analyzer-derived SOLID proxies. |
| `twelve-factor` | mechanical | 15 | Config from env (no hardcoded config/conn strings), logs to stdout, stateless processes (no InProc session/static user state), declared dependencies. |
| `security-cve` | mechanical | 20 | Known CVEs in dependencies (`dotnet list package --vulnerable`, `npm audit`). Critical CVE present ⇒ dimension scores 0. |
| `dependency-eol` | mechanical | 10 | Frameworks/packages past end-of-support, against a dataset pinned per kit release. |
| `test-coverage` | mechanical | 15 | Branch coverage of Library-layer logic by the characterization suite (blanket coverage of trivial surface does not count). |
| `complexity` | mechanical | 5 | Hotspot count: files over complexity/size thresholds. |
| `ocp-readiness` | mechanical | 10 | Configurable port, health endpoints, forwarded-headers middleware, no hazards (in-proc session, local file writes, Windows deps) outstanding. Emitted as a checklist for the deployment team — this kit does not deploy (D-010). |
| `qualitative` | llm-judged | 10 | Naming quality, separation-of-concerns narrative. Pinned anchors below; best-of-3 median; strong-tier model. |

## Thresholds (step 19 gate)

- `security-cve`: no critical/high CVEs outstanding.
- `test-coverage`: ≥ 70% branch coverage of risk-flagged Library logic (also the step 03 gate).
- Total after ≥ 75, and every dimension after ≥ before. A dimension that regressed
  blocks close-out until explained by a `decisions.md` entry or fixed.

## Anchors for `qualitative` (calibration examples)

- **2/10** — God classes with mixed persistence/UI/business logic; names like `Manager2`,
  `Helper`, `DoWork`; no discernible layering.
- **5/10** — Layering exists but leaks (controllers reaching past services into data
  access); naming mostly descriptive; some dead abstractions.
- **8/10** — Clear Library/API/Client separation of concerns, intention-revealing names,
  small cohesive classes; remaining flaws are local, not structural.

Judges score against these anchors only. A judge may not consult the code's history or
the migration's effort — only the code as it stands.
