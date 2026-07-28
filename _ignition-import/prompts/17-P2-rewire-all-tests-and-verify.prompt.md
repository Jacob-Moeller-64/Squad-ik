---
description: Step 17 comprehensive quality gate validates ALL test suites, documentation, and quality standards before review. ALL TESTING IS DONE HERE. Steps are NEVER validation-only. Dev work is ALWAYS done.
agent: OpX-AppMod-P2-Modernize
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - agent
  - browser
  - edit/editFiles
  - todo
  - vscode/vscodeAPI
  - fusion/copilot-docs/*
---

# Step 17 Comprehensive Quality Gate & Test Completion

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 17 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 17 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.
> - Content reconciliation at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -Step 17`. This proves every non-deferred testcase in `executable-testcase-catalog.json` points to a test file that actually exists (a shape check cannot catch a catalog entry that names a test file which was never created). Require `RESULT: OK` (exit 0) before declaring this step complete. On `RESULT: BLOCKED` (exit 2), follow the `Fix:` line printed for each entry - implement the missing test, or mark the case `Deferred` with a `deferralId` and re-run Step 6 - then re-run the reconciliation.

## <MOJIBAKE: emoji> CORE PRINCIPLE: STEPS ARE NEVER VALIDATION-ONLY. DEV WORK IS ALWAYS DONE.

**Step 17 makes testing PERFECT. This is where we put a bow on the testing. ALL TEST WORK WILL BE DONE HERE. WE WILL COMPLETE EVERYTHING.**

About To Do
- Context: Step 17 is the comprehensive quality gate that validates ALL accumulated test work from Steps 6-16, ensures every test has detailed documentation, verifies coverage gates, and makes testing PERFECT before review.
- Dev work: Complete any missing tests, add detailed documentation to all test files, fix failing tests, achieve all coverage gates, update POMs, validate documentation completeness.
- QA plan: Run ALL test suites with detailed validation, verify comment structure, check coverage, validate POMs, ensure all 12 quality gates pass.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

## <MOJIBAKE: emoji> THE 12 QUALITY GATES

Step 17 validates 12 comprehensive quality gates. Each gate has specific criteria and remediation steps.

### **GATE 1: Characterization Tests (100% Coverage)**

**Criteria:**
- [ ] Every legacy behavior from Step 3 has a characterization test
- [ ] All char tests have detailed 4-line file purpose block
- [ ] All char tests have CaseId/Scenario/Description/Input/Expected
- [ ] All char tests pass with 100% success rate
- [ ] test-accumulation-tracker.json shows complete char coverage

**Validation:**
```powershell
dotnet test --filter "Category=Characterization"
```

**Remediation (if gate fails):**
1. Review `.modernization/portal/data/json/executable-testcase-catalog.json`
2. Find all CaseIds with owningStep < 10
3. Create missing characterization tests with full documentation
4. Run tests until 100% pass
5. Update tracker

### **GATE 2: Unit Tests (>=95% Line Coverage)**

**Criteria:**
- [ ] Backend unit coverage >= 95% line coverage
- [ ] All unit test files have 4-line file purpose block
- [ ] All unit test methods have CaseId/Scenario/Description/Input/Expected
- [ ] All unit tests pass
- [ ] Coverage report saved to `.modernization/portal/data/json/coverage-reports/unit-coverage.json`

**Validation:**
```powershell
dotnet test tests/backend/unit --collect:"XPlat Code Coverage"
```

**Remediation (if gate fails):**
A coverage gap at Step 17 means the **Step 6 catalog is incomplete**, the **Step 8/9/12 implementation skipped a catalog entry**, or the **Step 3 Service & Behavior Inventory missed a method-level fact**. Step 17 does not derive new scenarios. The loop is:
1. Generate coverage report and identify uncovered methods, branches, and classes.
2. For each uncovered surface, check the catalog: is there a planned entry whose `testMethod` covers it?
   - If YES, the implementing Phase 2 step failed to deliver the planned test. Route back to that step (Step 8/9/12/etc.) to implement the missing entry.
   - If NO, the plan itself is incomplete. Route back to Step 3 to refresh the Service & Behavior Inventory (most likely a missed branching parameter, throw guard, null-coalescing default, list method, display decorator, or delegation path), then to Step 6 to extend the catalog, then to the owning Phase 2 step to implement.
3. Re-run coverage after the upstream refresh + Phase 2 re-implementation completes.
4. Do not author tests directly inside Step 17. Step 17 verifies; it does not plan and does not derive.

### **GATE 3: Contract Tests (100% API Coverage)**

**Criteria:**
- [ ] Every API endpoint has >=1 contract test
- [ ] All contract test files have 4-line file purpose block
- [ ] All contract test methods have CaseId/Scenario/Description/Input/Expected
- [ ] All contract tests pass
- [ ] API inventory matches test coverage

**Validation:**
```powershell
dotnet test tests/backend/contract --filter "Category=Contract"
```

**Remediation (if gate fails):**
1. Generate API endpoint inventory from Swagger/OpenAPI
2. Compare against existing contract tests
3. Create missing contract tests with full documentation
4. Run tests until 100% pass
5. Update tracker

### **GATE 4: Integration Tests (>=95% Critical Path Coverage)**

**Criteria:**
- [ ] All critical integration points have tests
- [ ] All integration test files have 4-line file purpose block
- [ ] All integration test methods have CaseId/Scenario/Description/Input/Expected
- [ ] All integration tests pass
- [ ] Integration coverage >= 95% of critical paths

**Validation:**
```powershell
dotnet test tests/backend/integration --filter "Category=Integration"
```

**Remediation (if gate fails):**
1. Identify all integration seams (DB, external services, etc.)
2. Create missing integration tests with full documentation
3. Run tests until coverage >= 95%
4. Update tracker

### **GATE 5: Database Tests (100% Table Coverage)**

**Criteria:**
- [ ] Every legacy table has existence test
- [ ] Every legacy table has data validation test
- [ ] All DB test files have 4-line file purpose block
- [ ] All DB test methods have CaseId/Scenario/Description/Input/Expected
- [ ] All DB tests pass

**Validation:**
```powershell
dotnet test tests/backend/db --filter "Category=Database"
```

**Remediation (if gate fails):**
1. Query INFORMATION_SCHEMA to get all tables
2. Create missing table existence tests
3. Create missing data validation tests
4. Update all tests with full documentation
5. Run tests until 100% pass

### **GATE 6: Angular Unit Tests (100% Component Coverage)**

**Criteria:**
- [ ] Every Angular component has unit test
- [ ] All Angular test files have 4-line file purpose block comments
- [ ] All test specs have CaseId/Scenario/Description/Input/Expected
- [ ] All Angular tests pass
- [ ] Karma/Jasmine coverage >= 90%

**Validation:**
```powershell
npm run test -- --no-watch --code-coverage
```

**Remediation (if gate fails):**
1. Generate component inventory
2. Create missing component tests with full JSDoc documentation
3. Add detailed inline comments matching backend style
4. Run tests until 100% pass
5. Update tracker

### **GATE 7: Visual Parity (>=85% Similarity, 90% Stretch Goal)**

**Criteria:**
- [ ] Every modernized route has baseline screenshot
- [ ] Every modernized route has modern screenshot
- [ ] Similarity score >= 85% (or 90% if achievable)
- [ ] All parity blockers documented in parity-exceptions.json
- [ ] Parity report saved to portal

**Validation:**
```powershell
npx playwright test --grep @parity
```

**Remediation (if gate fails - similarity < 85%):**
1. Generate pixel-diff reports
2. Categorize differences: intentional vs regression
3. Fix regression differences
4. Document intentional differences in parity-exceptions.json
5. Rerun until >= 85% (or 90% if possible)

**Stretch Goal Achievement (>= 90% similarity):**
- If all routes achieve >= 90%, document this achievement
- Include in final quality report as exceeding standards

### **GATE 8: Smoke Tests (100% Pass Rate)**

**Criteria:**
- [ ] All smoke tests pass
- [ ] Smoke tests cover: build, health, startup, critical paths
- [ ] Smoke test files have 4-line file purpose block
- [ ] Smoke test methods have CaseId/Scenario/Description/Input/Expected

**Validation:**
```powershell
dotnet test --filter "Category=Smoke"
npx playwright test --grep @smoke
```

**Remediation (if gate fails):**
1. Run all smoke tests
2. Fix failing tests
3. Add missing smoke coverage
4. Update documentation
5. Rerun until 100% pass

### **GATE 9: E2E Tests (100% Journey Coverage)**

**Criteria:**
- [ ] Every user journey has E2E test in auth.journey.spec.ts or similar
- [ ] All E2E test files have 4-line file purpose block comments
- [ ] All E2E tests have CaseId/Scenario/Description/Input/Expected inline comments
- [ ] All E2E tests pass
- [ ] NO .feature files (Gherkin lives in code comments only)

**Validation:**
```powershell
npx playwright test tests/frontend/e2e
```

**Remediation (if gate fails):**
1. Review journey inventory from Step 6 planning
2. Create missing E2E tests with full inline documentation
3. Update POMs as needed
4. Run tests until 100% pass
5. Verify NO .feature files exist

### **GATE 10: Test Quality Standards (100% Compliance)**

**Criteria:**
- [ ] ALL test files have 4-line file purpose block (This file protects/verifies/stays/makes...)
- [ ] ALL test methods have CaseId/Scenario/Description/Input/Expected comments
- [ ] All tests use Given/When/Then inline comments in body
- [ ] Comment style matches LegacyConnectionStringProviderTests.cs exactly
- [ ] No test files use Arrange/Act/Assert style (must use Given/When/Then)

**Validation:**
```powershell
# Manual review or automated script
Get-ChildItem -Path tests -Recurse -Include *.cs,*.ts | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -notmatch "This file protects") {
        Write-Host "MISSING FILE PURPOSE: $($_.FullName)"
    }
}
```

**Remediation (if gate fails):**
1. Scan ALL test files for missing documentation
2. Add 4-line file purpose block to files missing it
3. Add CaseId/Scenario/Description/Input/Expected to methods missing it
4. Replace Arrange/Act/Assert with Given/When/Then
5. Verify style matches LegacyConnectionStringProviderTests.cs
6. Rerun validation until 100% compliance

### **GATE 11: Page Object Models (100% Coverage)**

**Criteria:**
- [ ] Every route has a POM class
- [ ] All POMs use data-testid selectors
- [ ] All POMs have 4-line file purpose block comments
- [ ] POM inventory matches route inventory
- [ ] All POMs saved to `.modernization/portal/data/json/pom-inventory.json`

**Validation:**
```powershell
# Compare route count vs POM count
$routes = (Get-Content .modernization/portal/data/json/route-inventory.json | ConvertFrom-Json).routes.Count
$poms = (Get-ChildItem tests/frontend/e2e/pages -Filter "*.page.ts").Count
if ($poms -lt $routes) { Write-Host "MISSING POMs: $($routes - $poms)" }
```

**Remediation (if gate fails):**
1. Generate route inventory
2. Generate POM inventory
3. Create missing POM classes with full documentation
4. Ensure all selectors use data-testid
5. Update pom-inventory.json

### **GATE 12: Test Documentation (100% Complete)**

**Criteria:**
- [ ] executable-testcase-catalog.json is complete and current
- [ ] test-accumulation-tracker.json shows all gates passing
- [ ] coverage-reports/ contains all coverage reports
- [ ] parity-exceptions.json documents all visual differences
- [ ] pom-inventory.json lists all POMs
- [ ] All test README files are current

**Validation:**
```powershell
# Verify all required files exist and are current
Test-Path .modernization/portal/data/json/executable-testcase-catalog.json
Test-Path .modernization/portal/data/json/test-accumulation-tracker.json
Test-Path .modernization/portal/data/json/coverage-reports
```

**Remediation (if gate fails):**
1. Generate all missing documentation files
2. Update stale documentation
3. Ensure all JSON files are valid and complete
4. Create or update test README files
5. Verify all files are current

## Discovery-Backed Verification Gates (MANDATORY)

Step 17 cannot exit ``Ready`` unless every gate below passes against the denominators published by Step 6 ``progressDenominators`` and the plans recorded in Step 5 ``decisions.json``. Each gate failure either blocks exit or is converted into an explicit ``deferralId`` countersigned by the user.

- **Visual Parity Floor Gate.** ``frontend.routeStateParity >= 90`` across all ``screenshotCoverageMatrix`` rows that are not dispositioned. Rows below 90 require a ``parityDeferralId`` with reason and owner. Per-state diffs under ``.modernization/portal/data/images/parity-diffs/`` must show the final ``parityAfter`` for every closed slice.
- **Performance Baseline Gate.** Modern per-route ``firstContentfulPaintMs``, ``largestContentfulPaintMs``, ``timeToInteractiveMs``, ``apiCallCount``, ``totalPayloadBytes`` must be within the ``performanceBudgetPlan`` budgets (default within +10% of Step 5 ``performanceBaseline``). Regressions are gate failures unless an accepted deferral exists.
- **Bundle Size Gate.** Per-route ``initialBundleBytesMaxPerRoute`` and ``lazyChunkBytesMaxPerRoute`` from Step 5 are enforced against actual gzipped output. Regressions block exit.
- **Accessibility Audit Gate.** Lighthouse a11y score >= target (default 90) per route; zero critical or serious axe-core violations. Minor and moderate violations require recorded deferrals.
- **Error State Coverage Gate.** Every row in Step 3 ``errorStateCatalog`` has either a passing test or an explicit ``not-applicable`` reason. Coverage = ``coveredErrorStates / totalErrorStates`` and must reach 100 percent of non-deferred rows.
- **Export Surface Coverage Gate.** Every row in Step 3 ``exportSurfaceCatalog`` has a test that triggers the export and verifies the output artifact (or its content shape).
- **Realtime And Push Coverage Gate.** Every row in Step 3 ``realtimeSurfaceCatalog`` has a test that verifies push semantics are preserved (reconnection, payload shape, affected UI).
- **Localization Gate.** Every locale in Step 5 ``localizationPlan.supportedLocales`` renders the primary routes without missing keys.
- **Flake Budget Gate.** Test-suite flake rate <= ``flakeBudgetPercent`` from Step 5 (default 1 percent). No quarantined test older than ``quarantineLifetimeDays`` (default 14).
- **Progress Denominator Verification Gate.** Every percentage in the agent contract ``### Modernization Progress Metric`` is computed as ``done / total`` against the denominators in Step 6 ``progressDenominators``. Every metric reached its planned target or has an accepted ``deferralId``. Estimated percentages are forbidden.
- **Cutover Readiness Pre-Check.** Step 18 owns final cutover verification, but Step 17 must confirm that ``cutoverAndRollbackPlan`` exists, the feature flag is named, and the rollback procedure is documented. Missing values route back to Step 5.

Gate failures are recorded in ``.modernization/portal/data/json/step17-gate-results.json`` with ``{ gateId, status, evidencePath, deferralId? }``.

## Mutation Testing Gate (MANDATORY)

- After the discovery-backed verification gates pass, run mutation testing against the modern test suite to prove the tests actually catch behavior breaks instead of just executing covered lines:
  - Backend: ``Stryker.NET`` against the modern ``Library`` and ``Web.Api`` projects, scoped first to the Step 8 critical-path inventory and then expanded to the full modern surface.
  - Frontend: ``StrykerJS`` against the modern client, scoped first to the Step 8 critical-path inventory and then expanded.
- Emit ``/.modernization/fusion-restructure/mutation-score.json`` per run: ``runId``, ``runUtc``, ``targetScope`` (``critical-path`` or ``full``), ``mutationScorePercent``, ``mutantsKilled``, ``mutantsSurvived``, ``mutantsTimedOut``, ``survivedMutants[]`` (with ``location``, ``mutator``, ``snippet``).
- Gate thresholds: full-scope mutation score at or above 60 percent, critical-path mutation score at or above 80 percent. Surviving mutants on critical-path classes are blockers; either add the test that kills the mutant or amend Step 7's ``criticalPathInventory`` with reviewer-approved justification.
- Generic across MVC, Razor Pages, Web Forms, AngularJS, Angular, React, Vue, Blazor, and any other framework supported by Stryker.NET or StrykerJS. Scope discovery is data-driven from the Step 8 critical-path inventory, not hard-coded per app.

## <MOJIBAKE: emoji> STEP 17 EXECUTION FLOW

**Phase 1: Validation (Run All Gates)**
1. Run GATE 1 through GATE 12 in sequence
2. Record pass/fail status for each gate
3. Generate comprehensive quality report

**Phase 2: Remediation (Fix All Failures)**
For each failed gate:
1. Follow the specific remediation steps
2. Add missing tests with full documentation
3. Fix failing tests
4. Rerun gate validation
5. Repeat until gate passes

**Phase 3: Final Verification**
1. Rerun ALL gates from start
2. Verify 100% pass rate across all gates
3. Update test-accumulation-tracker.json with final status
4. Generate final quality report

**Phase 4: Documentation Sweep**
1. Verify ALL test files have detailed comments
2. Spot-check 5 random test files against LegacyConnectionStringProviderTests.cs
3. Fix any comment style deviations
4. Run final validation

## <MOJIBAKE: emoji> COMPLETION GATE

Step 17 is COMPLETE when ALL 12 gates show PASS status:

```json
{
  "step": 17,
  "status": "Complete",
  "completedAt": "2026-05-28T10:00:00Z",
  "qualityGates": {
    "gate1_characterizationTests": "PASS",
    "gate2_unitTests": "PASS",
    "gate3_contractTests": "PASS",
    "gate4_integrationTests": "PASS",
    "gate5_databaseTests": "PASS",
    "gate6_angularTests": "PASS",
    "gate7_visualParity": "PASS (85%+ achieved)",
    "gate8_smokeTests": "PASS",
    "gate9_e2eTests": "PASS",
    "gate10_testQualityStandards": "PASS",
    "gate11_pageObjectModels": "PASS",
    "gate12_testDocumentation": "PASS"
  },
  "totalTests": {
    "characterization": 45,
    "unit": 212,
    "contract": 28,
    "integration": 56,
    "database": 24,
    "angular": 87,
    "e2e": 32,
    "smoke": 12,
    "total": 496
  },
  "coverageMetrics": {
    "unitLinesCoverage": "96.3%",
    "unitBranchCoverage": "94.1%",
    "angularCoverage": "91.2%",
    "visualParitySimilarity": "87.5%"
  },
  "step18Handoff": "Ready for Step 18 Deployment & Clean Up: Yes"
}
```

**Do NOT close Step 17 until:**
- [x] ALL 12 quality gates show PASS
- [x] ALL tests have detailed 4-line file purpose + CaseId documentation
- [x] ALL test methods use Given/When/Then inline comments
- [x] Coverage metrics meet or exceed targets
- [x] Final quality report saved to portal
- [x] test-accumulation-tracker.json updated with final status

**Return explicit values:**
- `step17Status`: `Complete`, `InProgress`, or `Blocked`
- `qualityGateStatus`: Individual pass/fail for each gate
- `testDocumentationCompliance`: `100%`, `Partial`, or `Incomplete`
- `step18HandoffStatus`: `ReadyForCleanup`, `NotReadyForCleanup`, or `Blocked`

**Next Step:** Step 18 Deployment & Clean Up (only when all gates PASS)

## Step 17 DEV complete - next action

Step 17 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 17 QA will:** Run every test lane and produce coverage and confidence reports. This is the full Phase 2 quality gate before Phase 3 review.
**Lanes:** Unit, Integration, Contract, Browser-contract, E2E, Legacy characterization
**Expected ETA:** 15-30 min ET (cold cache may exceed)

Reply with the number of your choice:
1. `QA` - run `17-QA-rewire-all-tests-and-verify` now (recommended).
2. `next` - continue to Step 18 DEV (Deployment & Clean Up).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/17-QA-rewire-all-tests-and-verify`.
