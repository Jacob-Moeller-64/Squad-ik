---
description: Run the Step 4 baseline acceptance-criteria review before modernization using Dominion compliance evidence.
agent: OpX-AppMod-P1-Discovery
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# BASELINE ACCEPTANCE-CRITERIA REVIEW

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-20 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 4 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 4 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 4 is the baseline acceptance gate before planning. It must show not just what is wrong, but which gaps are material inputs to Step 5 and Modernization Quality Design.
- Dev work: Review the legacy baseline against Dominion criteria, preserve criterion-level findings, and classify which gaps are blockers versus planning inputs. Step 4 closes from the baseline evidence it refreshes and the saved step state.

**Review Type:** Baseline acceptance review (before modernization)
**Manifest:** .modernization/ignition-artifacts/discovery/review-manifest.json
**Output:** .modernization/ignition-artifacts/discovery/baseline-review.json
**Scope:** LegacyCode (legacy baseline source root before modernization, not repo root)

## Your Task

Review ALL files in the manifest against Dominion requirements. Process files in chunks of 10-15.

Primary execution command (recommended single-step runner):

```bash
./.github/scripts/P1-Discovery/04-P1-baseline-acceptance-gate.ps1 -RepoPath .
```

If the manifest should be rebuilt first in the same pass:

```bash
./.github/scripts/P1-Discovery/04-P1-baseline-acceptance-gate.ps1 -RepoPath . -RegenerateManifest
```

This review is the evidence engine for Step 4 `Baseline Acceptance-Criteria Review`. The final baseline artifact must preserve the review findings and refresh the decision-grade baseline compliance report used by QA, Step 5, and Modernization Quality Design.

Execution mode addendum
- No standalone QA prompt is associated with Step 4. Treat the refreshed baseline evidence as the step-owned completion gate.

Step 4 baseline-status model
- The final Step 4 result must distinguish these baseline outcomes explicitly:
  - `criterionCoverageStatus`: `DecisionGrade`, `BroadButIncomplete`, or `Blocked`
  - `blockingGapStatus`: `None`, `Present`, or `BlockedByMissingEvidence`
  - `planningInputStatus`: `ReadyForStep5`, `NeedsFollowUp`, or `Blocked`
- Rename-verification evidence is Step 2-owned context. Do not hard-block Step 4 solely because `rename-verification.json` reports unresolved items when Step 2 is already recorded as completed in `step-workflow-state.json`; treat that mismatch as informational and continue baseline review.
- Treat Step 4 as incomplete when findings exist but the artifact still cannot tell Step 5 which criteria are the most important modernization blockers and which are lower-priority planning deltas.
- Treat Step 4 as incomplete when criterion findings are preserved but not ranked into exact Step 5 planning inputs, user-input gates, or lower-priority modernization deltas.

Operator focus
- Keep exhaustive per-file findings in `baseline-review.json`.
- Keep the chat summary tight: top blockers, top planning deltas, exact ranked Step 5 planning inputs, refreshed artifact status, and the three Step 4 status fields.

Treat Step 4 as a baseline input gate. It does not own the requirements document, the executable test plan, or the phased characterization ladder.

If the manifest is missing or out of date, regenerate it from LegacyCode (read-only source evidence before any modernization copy is created):

```bash
./.github/scripts/P1-Discovery/03-P1-generate-manifest.ps1 -RepoPath ./LegacyCode
```

## For EACH file, check:

### DETERMINISTIC PATTERNS (just find and log):

**CRITICAL (-10 pts each):**
| ID | Pattern | What It Looks Like |
|----|---------|--------------------|
| A1.1 | Hardcoded credentials | `password = "..."`, `apiKey = "sk-..."` |
| A1.2 | SQL injection | `$"SELECT * WHERE id = {userInput}"` |
| A1.3 | Tokens in localStorage | `localStorage.setItem('token'` |
| A1.4 | innerHTML without sanitizer | `el.innerHTML = userInput` |
| A1.5 | Sensitive data in logs | `_logger.Log($"SSN: {ssn}")` |

**HIGH (-5 pts each):**
| ID | Pattern | What It Looks Like |
|----|---------|--------------------|
| A2.1 | FormsAuthentication | `FormsAuthentication.SetAuthCookie(` |
| A2.2 | Role-based auth | `User.IsInRole("`, `[Authorize(Roles =` |
| A2.3 | .Result blocking | `.Result;` on async methods |
| A2.4 | .Wait() blocking | `.Wait();` on tasks |
| A2.5 | .GetAwaiter().GetResult() | `.GetAwaiter().GetResult()` |
| A2.6 | async void | `async void ` (except event handlers) |
| A2.7 | new ServiceClass() | `new OrderService()`, `new PaymentService()` |
| A2.8 | new HttpClient() | `new HttpClient()` |
| A2.9 | Service locator | `ServiceLocator.Get<` |
| A2.10 | Hardcoded connection string | `"Server="`, `"Data Source="` |
| A2.11 | Hardcoded API URL | `"https://api.` in const/string |
| A2.12 | Static mutable state | `private static List<` |
| A2.13 | Session state | `Session["` |
| A2.14 | File-based logging | `File.AppendAllText(` for logs |
| A2.15 | Local file storage | `File.WriteAllText("C:\\` |
| A2.16 | NotImplementedException | `throw new NotImplementedException()` |
| A2.17 | document.* DOM access | `document.getElementById(` in Angular |
| A2.18 | jQuery usage | `$('.`, `jQuery(` in Angular |

**MEDIUM (-2 pts each):**
| ID | Pattern | What It Looks Like |
|----|---------|--------------------|
| A3.1 | Console.WriteLine | `Console.WriteLine(` |
| A3.2 | String concat in logs | `_logger.Log("Order " + id` |
| A3.3 | Magic numbers | `var timeout = 30;` |
| A3.4 | Environment check | `if (env == "Production")` |
| A3.5 | HttpClient in component | `private http: HttpClient` in Angular component |
| A3.6 | fetch() in Angular | `fetch('/api/` instead of HttpClient |
| A3.7 | Missing OnPush | No `ChangeDetectionStrategy.OnPush` |
| A3.8 | Subscribe without unsubscribe | `.subscribe(` without cleanup |
| A3.9 | XML formatters | `AddXmlSerializerFormatters()` |
| A3.10 | Swagger in production | `UseSwagger()` without dev check |
| A3.11 | Verb-based URLs | `[HttpGet("api/GetAllOrders")]` |
| A3.12 | Empty catch block | `catch { }` |
| A3.13 | Catching base Exception | `catch (Exception ex)` without rethrow |

### AI JUDGMENT (read context, provide reasoning):

**B1. SOLID Principles:**
- B1.1 Single Responsibility: Does this class do ONE thing? Count responsibilities.
- B1.2 Open/Closed: Would adding features require modifying this class?
- B1.3 Liskov Substitution: Do subclasses behave consistently?
- B1.4 Interface Segregation: Are interfaces cohesive? >15 methods = HIGH, 8-15 = MEDIUM
- B1.5 Dependency Inversion: Is business logic coupled to infrastructure?

**B2. Security:**
- B2.1 Authorization gaps: Are all sensitive endpoints protected?
- B2.2 Sensitive data handling: Is PII in logs/error messages?
- B2.3 SQL injection context: Is the concatenated string actually user input?
- B2.4 XSS risk: Is `[innerHTML]` or `bypassSecurityTrust*` used safely?

**B3. 12-Factor:**
- B3.1 Config externalization: Should values be in config?
- B3.2 Backing service abstraction: Can services be swapped via config?
- B3.3 Stateless design: Would multiple instances break anything?
- B3.4 Disposability: Are CancellationTokens respected? IDisposable implemented?
- B3.5 Logging quality: Are log levels appropriate? Structured logging used?

**B4. API Design (Controllers only):**
- B4.1 REST compliance: Resource-based URLs? Correct HTTP methods?
- B4.2 Error handling: Consistent error responses? Global exception handler?

**B5. Angular (.ts/.html files only):**
- B5.1 Component responsibility: Is component doing too much?
- B5.2 State management: Excessive prop drilling? Observables cleaned up?
- B5.3 Route protection: Admin routes have guards?

## File-Level Checks

| Check | Threshold |
|-------|-----------|
| Class line count | >500 = HIGH, 300-500 = MEDIUM |
| Constructor params | >7 = HIGH, 5-7 = MEDIUM |
| Interface methods | >15 = HIGH, 8-15 = MEDIUM |

## NOT Violations (Skip These)

- `new OrderDto()`, `new List<T>()` - Creating DTOs/collections is OK
- `static readonly`, `const` - Immutable static state is OK
- `IMemoryCache` - Performance caching is OK
- `new` in test files - Expected for test setup

Per-Criterion Baseline Score (MANDATORY)
- For every criterion declared in the active acceptance-criteria catalog (loaded from a versioned ``acceptance-criteria-catalog.json`` or the framework-agnostic checks above), emit a per-criterion entry into ``baseline-review.json`` with ``criterionId``, ``criterionLabel``, ``baselineScore`` (0..100), ``observedEvidencePaths[]``, ``findingIdsContributing[]``, and ``confidence`` (``high``, ``medium``, ``low``).
- ``baselineScore`` is derived from observed evidence using the closure formula above when findings exist, or from explicit evidence attestation when the criterion is met without findings. Inferred-without-evidence is not allowed.
- The overall score remains the composite computed by the closure contract. The per-criterion view is what Step 5 reads to plan remediation order and what Step 17 subtracts the modern result from to compute ``improvementDelta`` per criterion.
- Generic across MVC, Razor Pages, Web Forms, Blazor, AngularJS, Angular, React, Vue, and server-rendered HTML. The criterion list is data-driven from the catalog, not hard-coded into this prompt.

Artifact contract
- `baseline-review.json` remains the exhaustive proof artifact.
- For each reviewed file, preserve `path`, `reviewed`, `linesInFile`, and `findings[]` entries with `id`, `line`, `severity`, `category`, `reviewMethod`, `message`, and `recommendation`.
- The artifact must preserve criterion-level status strongly enough that Step 5 can tell which requirements are already close to acceptable, which findings are severity-ranked blockers, which findings are non-blocking but important planning deltas, and whether the baseline evidence is decision-grade enough for planning.
- The artifact must also preserve a compact Step 5 planning-input view that names the top blockers, the lower-priority planning deltas, and the exact criteria that caused each item to matter.

AI-judgment artifact (resolves design-level criteria)
- The deterministic scanner cannot positively decide criteria that require reading code for design intent: SOLID single-responsibility, open/closed, Liskov, and interface-segregation, plus true stateless-process posture. Left alone these surface as `UNKNOWN` in the compliance report.
- Emit an evidence-backed judgment artifact at `.modernization/artifacts/reviews/baseline-criterion-judgments.json` (Final phase uses `final-criterion-judgments.json`) so the report shows decision-grade verdicts instead of `UNKNOWN`.
- Shape: a top-level `judgments[]` array. Each entry has `name` (must match the compliance-report requirement row, for example `SOLID - single responsibility`), `status` (`PASS`, `FAIL`, or `PARTIAL`), `confidence` (`high`, `medium`, `low`), `rationale`, and `evidence[]` with at least one cited `path:line - reason`.
- Guardrails: a judgment is honored only when it carries one of those three statuses and at least one cited evidence entry. Inferred-without-evidence is not allowed. Deterministic `PASS`/`FAIL` rows are never overridden, so hard findings always outrank AI reasoning. When a criterion truly cannot be decided from observed code, use `PARTIAL` with the reason rather than guessing a clean result.
- `04-P1-generate-report.ps1` ingests this artifact automatically; no extra flag is required.

Closure contract
- Score with `100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`.
- Save progress after each chunk to `.modernization/artifacts/reviews/baseline-review.json`.
- Before generating the report, write the evidence-backed AI-judgment artifact described above so design-level criteria resolve to real verdicts instead of `UNKNOWN`.
- When 100% of files are reviewed, run:

```bash
./.github/scripts/P2-Modernize/verify-coverage.ps1
./.github/scripts/P1-Discovery/04-P1-generate-report.ps1 -Phase Baseline
```

- End with **"BASELINE REVIEW COMPLETE"**, state whether `.modernization/portal/data/json/BASELINE-COMPLIANCE-REPORT.json` was refreshed for the current pass, return the explicit `criterionCoverageStatus`, `blockingGapStatus`, and `planningInputStatus` values, and return the exact ranked Step 5 planning inputs so Step 5 does not have to infer them from a flat baseline findings list.

## Closeout Summary

- After the step response is saved, refresh `.modernization/.readme/.StepSummary.md` with a short human-readable entry for Step 4.
- Keep the summary skimmable: when the review ran, the main baseline takeaway, and the planning impact for Step 5 and Step 6.
