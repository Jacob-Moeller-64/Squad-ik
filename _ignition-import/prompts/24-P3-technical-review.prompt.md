---
agent: OpX-Code-Reviewer
description: Comprehensive S-tier technical review for C#/.NET + Fusion/Angular modernization. Covers all 24 steps, OCP cloud, Playwright, xUnit, Fusion. Performs bounded cleanup and targeted code-violation remediation, then reports remaining issues.
tools:
  - agent
  - browser
  - edit/editFiles
  - todo
  - vscode/vscodeAPI
  - fusion/copilot-docs/*
---

# Technical Review - S-Tier Quality Gate

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 24 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 24 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

**Stack**: C#/.NET 10 + Fusion Framework + Angular 20+ | **Target**: OCP Cloud Ready

## Scope

**PROJECT CODE ONLY** - Analyze and fix your application code:
- ? `src/<AppName>.Library/` - Business logic, services, models
- ? `src/<AppName>.Web.Api/` - API controllers, middleware, DI
- ? `src/<AppName>.Web.Client/` - Angular/Fusion frontend
- ? `tests/backend/` - xUnit tests (unit, contract, integration)
- ? `tests/frontend/` - Playwright + Angular tests
- ? `tests/modernization/` - Characterization tests

**DO NOT TOUCH** kit infrastructure:
- ? `.github/` - Prompts, agents, scripts, instructions
- ? `.modernization/` - Guidance, templates, artifacts
- ? `.vscode/` - Workspace config

## Step 24 Remediation Contract

- Step 24 owns bounded cleanup and targeted code-violation remediation for the final review gate.
- Apply deterministic, low-risk fixes only: cleanup, static-analyzer violations, clear compliance defects, and straightforward security or configuration corrections.
- Do not perform high-risk architecture rewrites, broad behavior changes, or migration-scope expansion unless explicitly requested.
- After each remediation batch, rerun focused backend and frontend tests for touched areas and publish what was rerun.
- Persist a disposition ledger for every reviewed issue using `Resolved`, `Deferred`, `Blocked`, or `AcceptedRisk`.
- The Step 24 technical gate must be the final technical-quality input consumed by release and readiness decisions.

---

## How It Works

1. **Analyze** - Run quick checks, find the current issue set
2. **Rate** - Score each category and calculate overall posture
3. **Remediate** - Apply bounded cleanup and targeted code-violation fixes that are deterministic and in-scope
4. **Re-verify** - Re-run focused checks and tests for touched areas
5. **List** - Publish resolved versus remaining issues with severity and disposition
6. **Repeat** - Re-run prompt until quality targets are met or remaining blockers are explicit

---

## GO / NO-GO

| Score | Decision |
|-------|----------|
| **90-100** | ? **GO** - Ship it |
| **80-89** | ?? Close - Fix P1s |
| **< 80** | ? Work needed |

---

## Quick Triage (Run First - 60 seconds)

```powershell
# === BUILD HEALTH ===
dotnet build src/ 2>&1 | Select-String "error|warning" | Measure-Object
cd src/*Client; npm run build 2>&1 | Select-String "error|warning"; cd ../..

# === SECURITY SCAN ===
Select-String -Path src/**/*.cs -Pattern "password|secret|connectionstring|localhost" -Recurse
dotnet list src/ package --vulnerable 2>&1
npm audit --prefix src/*Client 2>&1 | Select-String "vulnerabilities"

# === FUSION COMPLIANCE ===
Select-String -Path src/**/*.cs -Pattern "ILogger[^F]" -Recurse  # Should be IFusionLogger
Get-Content src/*Client/package.json | Select-String "@fusion" | Measure-Object
Select-String -Path src/**/*.cs -Pattern "HttpClient[^Factory]" -Recurse  # Should use Fusion HTTP

# === ACCESSIBILITY & TESTABILITY (CRITICAL) ===
# Count elements with aria-label
(Get-ChildItem src/*Client -Recurse -Include *.html,*.ts | Select-String "aria-label").Count
# Count elements with data-testid
(Get-ChildItem src/*Client -Recurse -Include *.html,*.ts | Select-String "data-testid").Count
# Find buttons/inputs WITHOUT aria-label (violations)
Select-String -Path src/*Client/**/*.html -Pattern "<button[^>]*(?<!aria-label)[^>]*>" -Recurse | Measure-Object
Select-String -Path src/*Client/**/*.html -Pattern "<input[^>]*(?<!aria-label)[^>]*>" -Recurse | Measure-Object

# === TEST HEALTH ===
dotnet test tests/backend/ --no-build --verbosity minimal 2>&1 | Select-String "Passed|Failed"
(Get-ChildItem tests/ -Recurse -Include *.cs | Select-String "\[Fact\]|\[Theory\]").Count
(Get-ChildItem tests/frontend -Recurse -Include *.spec.ts,*.test.ts).Count

# === OCP CLOUD READINESS ===
Test-Path "azure-pipelines*.yml"
Select-String -Path src/*Api/**/*.cs -Pattern "MapHealthChecks|/health|/ready|/live" -Recurse
```

---

## Emoji Integrity Check (Tooling)

```powershell
# Detect and repair mojibake emoji corruption in agent files under .github/agents
$agentFiles = Get-ChildItem .github/agents -Filter *.agent.md -File -ErrorAction SilentlyContinue
$fixedCount = 0
foreach ($f in $agentFiles) {
  $t = Get-Content $f.FullName -Raw -Encoding UTF8
  if ( -match '<MOJIBAKE MARKER>') {
    $b = [System.Text.Encoding]::Latin1.GetBytes($t)
    $fixed = [System.Text.Encoding]::UTF8.GetString($b)
    if ($fixed -ne $t) {
      Set-Content -Path $f.FullName -Value $fixed -Encoding UTF8
      Write-Host "Fixed emoji corruption in: $($f.Name)"
      $fixedCount++
    }
  }
}
if ($fixedCount -eq 0) { Write-Host 'Emoji integrity: OK' } else { Write-Host "Total files fixed: $fixedCount" }
```

# CHECK CATEGORIES

## Evidence Contract Enforcement (MANDATORY)

Review MUST verify that every Phase 2 step honored `/.github/instructions/appmod-phase-agent-contract.instructions.md` rules 20 (Evidence Contract anti-hallucination) and 21 (Self-check before Completed) by sampling `.modernization/portal/data/json/step-response-ledger.json`.

- Sample at least 5 `step-response` entries per phase. Each entry MUST cite real artifact paths for any `is wired`, `is complete`, `is integrated`, or `passes` claim. Unverifiable claims are review failures.
- Sample at least 3 `Completed` entries per phase and verify the self-check fields (`proofPath`, `proofCommand`, `proofResultSummary`) were populated and the cited artifact exists at the time of review.
- A step whose closeout response said `Completed` but whose proof artifact is missing or stale is a review-time defect logged under `.modernization/portal/data/json/review-evidence-defects.json` with `{ stepId, claim, missingArtifact, severity }`.

## Modernization Progress Audit (MANDATORY)

Review MUST recompute every percentage from `### Modernization Progress Metric` against the actual denominators in Step 8 `progressDenominators` and confirm done counts cite real artifacts.

- Recompute `backend.fileMoveCompletion`, `backend.apiEndpointCoverage`, `frontend.routeMigration`, `frontend.componentMigration`, `frontend.controlMigration`, `frontend.subPatternProgress`, `frontend.routeStateParity`, `frontend.fusionCapabilityAdoption`, `tests.pomCoverage`, `tests.featureCoverage`, `tests.controlTestCoverage`, `tests.backendCoverage` plus the rollups.
- For every metric that did not reach its planned target, verify a recorded `deferralId` exists with reason, owner, and follow-up step. Missing deferrals are review failures.
- Verify `frontend.routeStateParity >= 90` per `Slice Parity Floor` in `/.github/instructions/testing-design-contract.instructions.md` unless dispositioned per-row.
- Verify per-route `performanceBudgetPlan` and `initialBundleBytesMaxPerRoute` budgets passed at Step 20 or carry an accepted deferral.

## 1. Parity Review (20%) - Legacy Behavior Match

Does the modern app behave exactly like legacy?

**Quick Check:**
```powershell
# Route parity
(Get-ChildItem LegacyCode/**/Controllers -Filter *.cs -Recurse -ErrorAction SilentlyContinue | Select-String "\[Http").Count
(Get-ChildItem src/*Api/Controllers -Filter *.cs -Recurse | Select-String "\[Http").Count

# Characterization test status
Test-Path "tests/modernization/characterization"
Get-ChildItem tests/modernization/characterization -Recurse -Include *.cs -ErrorAction SilentlyContinue | Measure-Object
```

**Step Coverage** (Steps 7-9, 11):
- [ ] Same API routes exist (Step 8 formation)
- [ ] Same data returned from endpoints
- [ ] Same validation rules and error messages
- [ ] Same business logic calculations
- [ ] Same UI workflows and navigation (Step 11 migration)
- [ ] Characterization tests pass baseline comparison

---

## 2. Functionality Review (18%)

Does everything work correctly?

**Quick Check:**
```powershell
Select-String -Path src/**/*.cs,src/**/*.ts -Pattern "TODO|FIXME|HACK|NotImplemented|throw new NotImplementedException" -Recurse
Select-String -Path src/**/*.cs -Pattern "catch\s*\{|catch\s*\(\s*\)" -Recurse  # Empty catch blocks
```

**Step Coverage** (Steps 8, 11, 16):
- [ ] No TODO/FIXME in critical paths
- [ ] No NotImplementedException in production code
- [ ] Error boundaries on all API endpoints
- [ ] Loading/empty states in UI
- [ ] Client-to-API wiring verified (Step 12)
- [ ] All tests pass (Step 17)

---

## 3. Dominion/Fusion Compliance (15%)

Meets Dominion standards + Fusion Framework + 12-Factor.

**Quick Check:**
```powershell
# Fusion packages - API
Select-String -Path src/*Api/**/*.cs -Pattern "IFusionLogger|IFusionCache|IFusionHttpClient" -Recurse | Measure-Object
Select-String -Path src/*Api/**/*.cs -Pattern "using Fusion\." -Recurse | Measure-Object

# Fusion packages - Client
Get-Content src/*Client/package.json | Select-String "@fusion/core|@fusion/ngx-fusion|@fusion/ngx-auth"

# 12-Factor violations
Select-String -Path src/**/*.cs,src/**/*.json -Pattern "localhost|127\.0\.0\.1|Data Source=|Server=" -Recurse
Select-String -Path src/**/*.cs -Pattern "static\s+.*=\s*new" -Recurse  # Static state anti-pattern
```

**Fusion Backend Checklist** (Steps 7-9, 17):
- [ ] `Fusion.Fx.*` packages in csproj
- [ ] `IFusionLogger` (not raw `ILogger`)
- [ ] `IFusionHttpClientFactory` (not raw `HttpClient`)
- [ ] `IFusionCache` for caching (not `IMemoryCache`)
- [ ] Fusion auth middleware configured
- [ ] Fusion config binding patterns
- [ ] DI via `AddFusion*()` extensions
- [ ] Starter shell Program.cs alignment

**Fusion Frontend Checklist** (Steps 12-15):
- [ ] `@fusion/core` in package.json
- [ ] `@fusion/ngx-fusion` for UI components
- [ ] `@fusion/ngx-auth` for auth
- [ ] Fusion shell/layout components
- [ ] Fusion data grid (not raw AG-Grid)
- [ ] Fusion form controls
- [ ] Fusion theming/styling

**12-Factor Checklist**:
- [ ] Factor II: Dependencies explicit in csproj/package.json
- [ ] Factor III: Config via environment/appsettings (no hardcoded)
- [ ] Factor IV: Backing services as attached resources
- [ ] Factor VI: Stateless processes (no static state)
- [ ] Factor IX: Graceful shutdown (`IHostApplicationLifetime`)
- [ ] Factor XI: Structured logging via Fusion

---

## 4. Code Quality (12%)

Clean, maintainable .NET 10 + Angular 20 code.

**Quick Check:**
```powershell
# Large files
Get-ChildItem src/ -Recurse -Include *.cs,*.ts | Where-Object { (Get-Content $_.FullName).Count -gt 500 } | Select-Object Name,@{N='Lines';E={(Get-Content $_.FullName).Count}}

# Async anti-patterns
Select-String -Path src/**/*.cs -Pattern "\.Result\b|\.Wait\(\)|\.GetAwaiter\(\)\.GetResult\(\)" -Recurse

# Nullable issues
Select-String -Path src/**/*.cs -Pattern "= null!|!\." -Recurse | Measure-Object

# Disposable issues
Select-String -Path src/**/*.cs -Pattern "new\s+(SqlConnection|HttpClient|FileStream)" -Recurse
```

**.NET 10 Checklist**:
- [ ] Nullable reference types enabled (`<Nullable>enable</Nullable>`)
- [ ] No `.Result`, `.Wait()`, `.GetAwaiter().GetResult()` (async anti-patterns)
- [ ] Proper `IDisposable`/`IAsyncDisposable` with `using`
- [ ] No `new HttpClient()` directly (use factory)
- [ ] No static mutable state
- [ ] File-scoped namespaces
- [ ] Primary constructors where appropriate
- [ ] Records for DTOs
- [ ] No magic numbers/strings (use constants)
- [ ] Methods < 50 lines, classes < 500 lines

**Angular 20+ Checklist** (Steps 10-16):
- [ ] `OnPush` change detection on components
- [ ] `inject()` function preferred over constructor DI
- [ ] `takeUntilDestroyed()` or `async` pipe (no manual unsubscribe)
- [ ] `trackBy` on all `@for` / `*ngFor` loops
- [ ] Standalone components (`standalone: true`)
- [ ] Signals for reactive state (signal(), computed(), effect())
- [ ] Control flow syntax (`@if`, `@for`, `@switch`) - NO `*ngIf`/`*ngFor`
- [ ] No `any` types
- [ ] Resource API for async data loading where applicable
- [ ] Zoneless change detection ready

**Accessibility & Testability (REQUIRED):**
- [ ] **ARIA labels on ALL interactive elements** (buttons, inputs, links, selects)
- [ ] **`data-testid` on ALL testable elements** (forms, buttons, grids, modals)
- [ ] `aria-label` or `aria-labelledby` on custom components
- [ ] `aria-describedby` for complex widgets
- [ ] `role` attribute where semantic HTML insufficient
- [ ] Keyboard navigation works (Tab, Enter, Escape)
- [ ] Focus management on modals/dialogs
- [ ] Screen reader tested (NVDA/VoiceOver)

---

## 5. Security (12%)

OWASP-aware, production-secure.

**Quick Check:**
```powershell
# Secrets scan
Select-String -Path src/**/*.cs,src/**/*.ts,src/**/*.json -Pattern "password|secret|apikey|bearer|token|private.?key" -Recurse

# Auth coverage
Select-String -Path src/*Api/Controllers/*.cs -Pattern "\[Authorize\]|\[AllowAnonymous\]" -Recurse | Measure-Object
Get-ChildItem src/*Api/Controllers/*.cs | ForEach-Object { if (-not (Select-String -Path $_.FullName -Pattern "\[Authorize\]|\[AllowAnonymous\]" -Quiet)) { $_.Name } }

# Vulnerable packages
dotnet list src/ package --vulnerable --include-transitive
npm audit --prefix src/*Client --audit-level=high
```

**OWASP Checklist** (Steps 7, 10):
- [ ] No secrets/credentials in code or config files
- [ ] `[Authorize]` on all non-public controllers/actions
- [ ] `[ValidateAntiForgeryToken]` on mutations (or Fusion CSRF)
- [ ] Input validation with DataAnnotations or FluentValidation
- [ ] Parameterized queries (no string concatenation SQL)
- [ ] HTTPS enforced
- [ ] CORS properly configured
- [ ] No vulnerable NuGet/npm packages
- [ ] Content Security Policy headers
- [ ] XSS prevention (Angular auto-sanitization)

---

## 6. Testing (10%) - PLAYWRIGHT + GHERKIN MASTERPIECE

BDD-driven test architecture with Gherkin syntax and Playwright excellence.

**Quick Check:**
```powershell
# === BACKEND (xUnit) ===
(Get-ChildItem tests/backend -Recurse -Include *.cs | Select-String "\[Fact\]").Count
(Get-ChildItem tests/backend -Recurse -Include *.cs | Select-String "\[Theory\]").Count

# === PLAYWRIGHT STRUCTURE ===
Test-Path "tests/frontend/playwright.config.ts"
Test-Path "tests/frontend/e2e"

# === PAGE OBJECT MODEL (REQUIRED) ===
Test-Path "tests/frontend/e2e/pages"
(Get-ChildItem tests/frontend/e2e/pages -Include *.ts -Recurse -ErrorAction SilentlyContinue).Count

# === GHERKIN/BDD STRUCTURE ===
Test-Path "tests/frontend/e2e/features"
(Get-ChildItem tests/frontend/e2e -Include *.feature -Recurse -ErrorAction SilentlyContinue).Count
(Get-ChildItem tests/frontend/e2e -Include *.steps.ts -Recurse -ErrorAction SilentlyContinue).Count

# === TEST CATEGORIES ===
(Get-ChildItem tests/frontend/e2e/smoke -Include *.spec.ts -Recurse -ErrorAction SilentlyContinue).Count
(Get-ChildItem tests/frontend/e2e/journey -Include *.spec.ts -Recurse -ErrorAction SilentlyContinue).Count
(Get-ChildItem tests/frontend/e2e/regression -Include *.spec.ts -Recurse -ErrorAction SilentlyContinue).Count

# === FIXTURES & DATA ===
Test-Path "tests/frontend/e2e/fixtures"
Test-Path "tests/frontend/e2e/test-data"

# Run tests
npx playwright test --reporter=list
dotnet test tests/backend/ --verbosity minimal
```

---

### <MOJIBAKE: emoji> PLAYWRIGHT ARCHITECTURE (Required Structure)

```
tests/frontend/e2e/
+-- playwright.config.ts              # Central config
+-- global-setup.ts                   # Auth, env setup
+-- global-teardown.ts                # Cleanup
|
+-- features/                         # <MOJIBAKE: emoji> GHERKIN FEATURE FILES
|   +-- auth/
|   |   +-- login.feature
|   |   +-- logout.feature
|   +-- dashboard/
|   |   +-- dashboard-view.feature
|   +-- grid/
|       +-- grid-filter.feature
|       +-- grid-export.feature
|
+-- steps/                            # <MOJIBAKE: emoji> STEP DEFINITIONS
|   +-- common.steps.ts               # Shared Given/When/Then
|   +-- auth.steps.ts
|   +-- dashboard.steps.ts
|   +-- grid.steps.ts
|
+-- pages/                            # <MOJIBAKE: emoji> PAGE OBJECT MODEL
|   +-- BasePage.ts                   # Abstract base
|   +-- LoginPage.ts
|   +-- DashboardPage.ts
|   +-- GridPage.ts
|   +-- components/                   # Reusable component POMs
|       +-- HeaderComponent.ts
|       +-- SidebarComponent.ts
|       +-- ModalComponent.ts
|
+-- fixtures/                         # <MOJIBAKE: emoji> TEST FIXTURES
|   +-- auth.fixture.ts               # Authenticated user fixture
|   +-- data.fixture.ts               # Test data fixture
|   +-- api.fixture.ts                # API mocking fixture
|
+-- test-data/                        # <MOJIBAKE: emoji> TEST DATA
|   +-- users.json
|   +-- grid-data.json
|   +-- scenarios/
|       +-- happy-path.json
|
+-- smoke/                            # <MOJIBAKE: emoji> SMOKE TESTS (Critical paths)
|   +-- app-loads.spec.ts
|   +-- auth-flow.spec.ts
|   +-- navigation.spec.ts
|
+-- journey/                          # <MOJIBAKE: emoji> USER JOURNEY TESTS
|   +-- complete-workflow.spec.ts
|   +-- data-entry-flow.spec.ts
|   +-- export-report.spec.ts
|
+-- regression/                       # <MOJIBAKE: emoji> REGRESSION TESTS
|   +-- grid/
|   +-- forms/
|   +-- navigation/
|
+-- visual/                           # <MOJIBAKE: emoji> VISUAL REGRESSION
    +-- snapshots/
    +-- visual-tests.spec.ts
```

---

### <MOJIBAKE: emoji> GHERKIN FEATURE FILES (Required)

Every user-facing feature needs a `.feature` file:

```gherkin
# tests/frontend/e2e/features/auth/login.feature
Feature: User Authentication
  As a user
  I want to log in to the application
  So that I can access my dashboard

  Background:
    Given I am on the login page

  @smoke @critical
  Scenario: Successful login with valid credentials
    Given I have valid user credentials
    When I enter my username "testuser@domain.com"
    And I enter my password
    And I click the login button
    Then I should be redirected to the dashboard
    And I should see my username in the header

  @regression
  Scenario: Login fails with invalid password
    Given I have invalid credentials
    When I enter my username "testuser@domain.com"
    And I enter an incorrect password
    And I click the login button
    Then I should see an error message "Invalid credentials"
    And I should remain on the login page

  @regression
  Scenario Outline: Login validation messages
    When I enter "<username>" as username
    And I enter "<password>" as password
    And I click the login button
    Then I should see "<error_message>"

    Examples:
      | username | password | error_message        |
      |          | pass123  | Username is required |
      | user@x   |          | Password is required |
      | invalid  | pass123  | Invalid email format |
```

---

### <MOJIBAKE: emoji> STEP DEFINITIONS (Given/When/Then)

```typescript
// tests/frontend/e2e/steps/auth.steps.ts
import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';

Given('I am on the login page', async function () {
  await this.loginPage.navigate();
  await expect(this.page).toHaveURL(/\/login/);
});

Given('I have valid user credentials', async function () {
  this.credentials = this.testData.users.validUser;
});

When('I enter my username {string}', async function (username: string) {
  await this.loginPage.enterUsername(username);
});

When('I click the login button', async function () {
  await this.loginPage.clickLogin();
});

Then('I should be redirected to the dashboard', async function () {
  await expect(this.page).toHaveURL(/\/dashboard/);
});

Then('I should see an error message {string}', async function (message: string) {
  await expect(this.loginPage.errorMessage).toHaveText(message);
});
```

---

### <MOJIBAKE: emoji> PAGE OBJECT MODEL (Required)

**BasePage.ts** - All POMs extend this:
```typescript
// tests/frontend/e2e/pages/BasePage.ts
import { Page, Locator } from '@playwright/test';

export abstract class BasePage {
  constructor(protected readonly page: Page) {}

  // Common locators using accessible selectors
  protected getByRole(role: string, options?: object): Locator {
    return this.page.getByRole(role as any, options);
  }

  protected getByLabel(label: string): Locator {
    return this.page.getByLabel(label);
  }

  protected getByTestId(testId: string): Locator {
    return this.page.getByTestId(testId);
  }

  // Common actions
  async waitForPageLoad(): Promise<void> {
    await this.page.waitForLoadState('networkidle');
  }

  abstract navigate(): Promise<void>;
}
```

**Feature Page Example:**
```typescript
// tests/frontend/e2e/pages/LoginPage.ts
import { Page, Locator, expect } from '@playwright/test';
import { BasePage } from './BasePage';

export class LoginPage extends BasePage {
  // Locators - ONLY accessible selectors
  readonly usernameInput: Locator;
  readonly passwordInput: Locator;
  readonly loginButton: Locator;
  readonly errorMessage: Locator;
  readonly forgotPasswordLink: Locator;

  constructor(page: Page) {
    super(page);
    // <MOJIBAKE: emoji> GOOD: Accessible locators
    this.usernameInput = this.getByLabel('Email address');
    this.passwordInput = this.getByLabel('Password');
    this.loginButton = this.getByRole('button', { name: 'Sign in' });
    this.errorMessage = this.getByRole('alert');
    this.forgotPasswordLink = this.getByRole('link', { name: 'Forgot password?' });
  }

  async navigate(): Promise<void> {
    await this.page.goto('/login');
    await this.waitForPageLoad();
  }

  // Actions encapsulated in POM
  async enterUsername(username: string): Promise<void> {
    await this.usernameInput.fill(username);
  }

  async enterPassword(password: string): Promise<void> {
    await this.passwordInput.fill(password);
  }

  async clickLogin(): Promise<void> {
    await this.loginButton.click();
  }

  // Composite actions for common flows
  async login(username: string, password: string): Promise<void> {
    await this.enterUsername(username);
    await this.enterPassword(password);
    await this.clickLogin();
  }

  // Assertions in POM
  async expectErrorVisible(message: string): Promise<void> {
    await expect(this.errorMessage).toBeVisible();
    await expect(this.errorMessage).toHaveText(message);
  }
}
```

---

### <MOJIBAKE: emoji> FIXTURES (Auth, Data, API)

```typescript
// tests/frontend/e2e/fixtures/auth.fixture.ts
import { test as base } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { DashboardPage } from '../pages/DashboardPage';

type AuthFixtures = {
  loginPage: LoginPage;
  dashboardPage: DashboardPage;
  authenticatedPage: DashboardPage;
};

export const test = base.extend<AuthFixtures>({
  loginPage: async ({ page }, use) => {
    await use(new LoginPage(page));
  },

  dashboardPage: async ({ page }, use) => {
    await use(new DashboardPage(page));
  },

  // Pre-authenticated fixture - skips login for most tests
  authenticatedPage: async ({ page }, use) => {
    // Use stored auth state
    await page.goto('/');
    await use(new DashboardPage(page));
  },
});

export { expect } from '@playwright/test';
```

---

### <MOJIBAKE: emoji> PLAYWRIGHT CHECKLIST

**Structure & Organization:**
- [ ] `playwright.config.ts` with proper settings
- [ ] `tests/frontend/e2e/` directory structure per template above
- [ ] Feature files in `features/` directory
- [ ] Step definitions in `steps/` directory
- [ ] POMs in `pages/` directory

**Gherkin/BDD Requirements:**
- [ ] Every user-facing feature has a `.feature` file
- [ ] Scenarios use Given/When/Then syntax
- [ ] Background for common preconditions
- [ ] Scenario Outline for data-driven tests
- [ ] Tags: `@smoke`, `@regression`, `@journey`, `@critical`
- [ ] Step definitions match feature file steps

**Page Object Model (POM) Requirements:**
- [ ] `BasePage.ts` abstract class exists
- [ ] Every page/route has dedicated POM class
- [ ] Component POMs for reusable UI elements
- [ ] **NO raw locators in test files** - use POM only
- [ ] POM encapsulates: locators, actions, assertions
- [ ] POM naming: `<Feature>Page.ts`

**Locator Requirements (STRICT):**
- [ ] `getByRole()` - buttons, links, headings (PREFERRED)
- [ ] `getByLabel()` - form inputs with aria-label
- [ ] `getByTestId()` - **REQUIRED on every testable element**
- [ ] `getByText()` - unique visible text
- [ ] **NO CSS selectors** (`.class`, `#id`)
- [ ] **NO XPath**
- [ ] **NO brittle selectors** (`div > span:nth-child(2)`)

**Mandatory Attributes in Angular Templates:**
```html
<!-- EVERY button needs both -->
<button aria-label="Submit form" data-testid="submit-btn">Submit</button>

<!-- EVERY input needs both -->
<input aria-label="Email address" data-testid="email-input" />

<!-- EVERY link needs both -->
<a aria-label="View dashboard" data-testid="dashboard-link">Dashboard</a>

<!-- Custom components need both -->
<app-grid aria-label="Data grid" data-testid="main-grid"></app-grid>

<!-- Modals/dialogs need both -->
<dialog aria-label="Confirm delete" data-testid="confirm-modal">...</dialog>
```

**Test Categories:**
- [ ] **Smoke tests** - App loads, auth works, nav works (~5 min)
- [ ] **Journey tests** - Complete user workflows (~15 min)
- [ ] **Regression tests** - Feature coverage (~30 min)
- [ ] **Visual tests** - Screenshot comparison

**Fixtures & Data:**
- [ ] Auth fixture for pre-authenticated tests
- [ ] Test data in JSON files
- [ ] API mocking fixture when needed
- [ ] Global setup/teardown configured

---

### xUnit Backend Checklist (Steps 7-9, 17)

- [ ] Unit tests in `tests/backend/unit/`
- [ ] Contract/API tests in `tests/backend/contractApi/`
- [ ] Integration tests in `tests/backend/integrationBackend/`
- [ ] **BDD naming**: `Given_When_Then` or `Method_Scenario_Result`
- [ ] `[Fact]` for single cases, `[Theory]` for parameterized
- [ ] Mocking with Moq or NSubstitute
- [ ] FluentAssertions for readable assertions
- [ ] Test coverage > 80% on business logic

---

### Angular Component Tests

- [ ] Tests in `tests/frontend/angularUnitComponent/`
- [ ] Component tests with TestBed
- [ ] Service tests with HttpTestingController
- [ ] OnPush-compatible test patterns

---

## 7. Architecture (5%)

Proper .NET + Angular patterns.

**Quick Check:**
```powershell
# Architecture patterns
Select-String -Path src/*Api/**/*.cs -Pattern "IMediator|MediatR|IRepository|IService" -Recurse | Measure-Object

# DI registration
Select-String -Path src/*Api/**/*.cs -Pattern "services\.Add|builder\.Services" -Recurse | Measure-Object

# Circular dependency check
Select-String -Path src/*Library/**/*.cs -Pattern "using.*\.Web\.Api|using.*\.Web\.Client" -Recurse
```

**Backend Architecture** (Steps 5-9):
- [ ] Clean/Simple Architecture per Step 6 plan
- [ ] `Library` contains business logic only
- [ ] `Web.Api` contains controllers, DI, middleware
- [ ] No circular dependencies between projects
- [ ] Repository pattern or direct EF Core (per plan)
- [ ] MediatR or direct service calls (per plan)
- [ ] Proper DI registration in `Program.cs`

**Frontend Architecture** (Steps 10-14):
- [ ] Feature module structure
- [ ] Shared module for common components
- [ ] Core module for singleton services
- [ ] Lazy-loaded feature routes
- [ ] State management (signals, NgRx, or services)

---

## 8. OCP Cloud & DevOps (5%)

OpenShift Container Platform ready.

**Quick Check:**
```powershell
# Pipeline
Test-Path "azure-pipelines*.yml"
Get-Content azure-pipelines.yml -ErrorAction SilentlyContinue | Select-String "docker|container|openshift" | Measure-Object

# Health endpoints
Select-String -Path src/*Api/**/*.cs -Pattern "MapHealthChecks|AddHealthChecks|/health|/ready|/live" -Recurse

# Containerization
Test-Path "Dockerfile"
Test-Path "src/*Api/Dockerfile"

# Environment config
Get-ChildItem src/*Api -Filter appsettings*.json | Select-Object Name
```

**OCP Cloud Checklist** (Steps 18, 23):
- [ ] Health check endpoints (`/health`, `/ready`, `/live`)
- [ ] `AddHealthChecks()` with DB, dependencies
- [ ] Graceful shutdown handling
- [ ] Environment-based configuration
- [ ] No file system dependencies (or mounted volumes)
- [ ] Stateless design (no in-memory session)
- [ ] Dockerfile exists and builds
- [ ] Resource limits defined
- [ ] Logging to stdout/stderr

**CI/CD Checklist**:
- [ ] `azure-pipelines.yml` exists
- [ ] Build stage passes
- [ ] Test stage runs all suites
- [ ] Container build stage
- [ ] Deployment stage(s) defined
- [ ] Environment variables externalized

---

## 9. Production Readiness (3%)

Final polish before deployment.

**Quick Check:**
```powershell
# Debug remnants
Select-String -Path src/**/*.cs -Pattern "Console\.Write|Debug\.Write|Debugger\.Break" -Recurse
Select-String -Path src/**/*.ts -Pattern "debugger|console\.log|console\.error|console\.warn" -Recurse

# API documentation
Test-Path "src/*Api/swagger*" -ErrorAction SilentlyContinue
Select-String -Path src/*Api/**/*.cs -Pattern "Scalar|Swagger|OpenApi" -Recurse | Measure-Object

# Error handling
Select-String -Path src/*Api/**/*.cs -Pattern "UseExceptionHandler|ProblemDetails" -Recurse
```

**Production Checklist** (Steps 18, 20, 23):
- [ ] No `Console.WriteLine` in production code
- [ ] No `debugger`/`console.log` in production code
- [ ] Proper logging levels (not all Info)
- [ ] User-friendly error messages
- [ ] API documentation (Scalar/Swagger/OpenAPI)
- [ ] README accurate and current
- [ ] Environment configs complete
- [ ] Secrets in Key Vault/env vars only

---

# STEP VERIFICATION MATRIX

Verify these step-specific artifacts exist:

| Step | Artifact | Check |
|------|----------|-------|
| 1 | Starter validated | `src/Starter.*` or renamed |
| 2 | Legacy runtime proof | `.modernization/portal/data/pages/` |
| 3 | Rename complete | `src/<AppName>.*` exists |
| 4 | Legacy analysis | `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` |
| 6 | Solution design | `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` |
| 7 | .NET upgrade | `.modernization/OpXUtil/Backup/LegacyCode_NET10_Upgrade/` or direct |
| 8 | Backend formation | `src/<AppName>.Library/`, `src/<AppName>.Web.Api/` |
| 9 | Integration hardened | Health checks, auth configured |
| 10 | Frontend scaffold | `src/<AppName>.Web.Client/` |
| 14 | UI Fusion map | `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json` |
| 17 | Tests rewired | `tests/` structure complete |
| 19 | Fusion review | Review findings documented |
| 23 | Final readiness | Release decision recorded |

---

# OUTPUT FORMAT

## Issue List (10-20 items)

```markdown
## Found: 15 issues

| # | Sev | Cat | File:Line | Issue | Effort |
|---|-----|-----|-----------|-------|--------|
| 1 | P1 | Security | UserController.cs:45 | Missing [Authorize] | 2m |
| 2 | P1 | Fusion | DataService.cs:12 | Using ILogger not IFusionLogger | 5m |
| 3 | P1 | Async | CalcService.cs:89 | Using .Result (async anti-pattern) | 10m |
| 4 | P1 | OCP | Program.cs | Missing health checks | 15m |
| 5 | P2 | Angular | grid.component.ts:23 | Missing OnPush | 3m |
| 6 | P2 | Fusion | app.module.ts | Using MatTable not Fusion grid | 30m |
| 7 | P2 | Test | - | No Playwright tests | 60m |
| 8 | P2 | 12-Factor | appsettings.json:8 | Hardcoded connection string | 5m |
| 9 | P3 | Code | TransformerService.cs | 650 lines, needs split | 45m |
| 10 | P3 | xUnit | - | Missing contract tests | 30m |
...

**Score: 72/100** <MOJIBAKE: emoji> NO-GO

**Pick fixes:** "Fix #1, #2, #3" or "Fix all P1" or "Fix #1-8"
```

---

## Near Perfection (< 5 issues)

```markdown
<MOJIBAKE: emoji> **Near Perfect!** Only 3 minor issues.

| # | Sev | Issue |
|---|-----|-------|
| 1 | P4 | Typo in comment line 45 |
| 2 | P4 | Unused import |
| 3 | P3 | Could add more Playwright tests |

**Score: 96/100** <MOJIBAKE: emoji> GO

Optional polish: "Fix #1, #2" or ship as-is.
```

---

## Severity Guide

| Sev | Meaning | Examples |
|-----|---------|----------|
| P1 | Blocker | Security gaps, async anti-patterns, missing Fusion, no health checks |
| P2 | Important | Missing tests, Fusion UI not used, Angular patterns |
| P3 | Nice to have | Large files, more tests, refactoring |
| P4 | Polish | Comments, formatting, minor cleanup |

---

## Remediation ROI Recommendation

After listing issues, ALWAYS include a **"Biggest ROI Fix"** section that maps issues to the step that would fix them most efficiently:

```markdown
## <MOJIBAKE: emoji> Biggest ROI Recommendation

Based on the issues found, here's where to focus for maximum impact:

| Priority | Run This | Fixes Issues | Est. Time | ROI Score |
|----------|----------|--------------|-----------|-----------|
| 1<MOJIBAKE: emoji> | Step 9 (Backend Hardening) | #1, #4, #8 | 30m | <MOJIBAKE: emoji x5> |
| 2<MOJIBAKE: emoji> | Step 11 (Frontend Migration) | #5, #6 | 45m | <MOJIBAKE: emoji x4> |
| 3<MOJIBAKE: emoji> | Step 7 (Upgrade) | #3 | 15m | <MOJIBAKE: emoji x3> |

**My recommendation: Run Step 9 first** - fixes 3 P1 security issues in ~30 minutes.
```

### Issue-to-Step Mapping Reference

| Issue Type | Root Step | Why |
|------------|-----------|-----|
| **Async anti-patterns** (.Result, .Wait) | Step 7 | Upgrade lane enforces modern async |
| **DI violations** (new HttpClient, static state) | Step 8 | Formation lane enforces DI patterns |
| **Missing [Authorize]** | Step 9 | Hardening lane enforces security |
| **Missing health checks** | Step 9 | Hardening lane adds OCP endpoints |
| **No secrets in code** | Step 9 | Hardening lane externalizes config |
| **IFusionLogger not used** | Step 9 | Hardening lane aligns Fusion packages |
| **Missing Playwright tests** | Step 10 | Foundation creates POM/Gherkin scaffold |
| **Missing aria-label** | Step 11 | Migration adds accessibility per component |
| **Missing data-testid** | Step 11 | Migration adds testability per component |
| **Angular patterns** (signals, standalone) | Step 11 | Migration enforces Angular 20+ patterns |
| **Auth flow issues** | Step 12 | Platform integration wires auth |
| **Shell/layout drift** | Step 13 | Shell stabilization fixes layout |
| **Wrong UI primitives** | Step 15 | Fusion UI integration swaps components |
| **Test coverage gaps** | Step 17 | Rewire verifies all test coverage |
| **Dead code, TODOs** | Step 18 | Cleanup removes debris |
| **Backend test coverage < 80%** | Step 8 | Formation creates test structure |

### ROI Calculation

```
ROI Score = (P1 Issues Fixed <MOJIBAKE: emoji> 5) + (P2 Issues Fixed <MOJIBAKE: emoji> 3) + (P3 Issues Fixed <MOJIBAKE: emoji> 1)
            ----------------------------------------------------------------
                             Estimated Time in Minutes
```

**Always recommend the step with the highest ROI Score first.**

### Example Recommendation Output

If Step 24 finds:
- 2 P1 async anti-patterns (Step 7)
- 3 P1 missing [Authorize] (Step 9)
- 1 P1 missing health checks (Step 9)
- 5 P2 missing aria-labels (Step 11)
- 3 P2 missing data-testids (Step 11)

**Recommendation:**
```
<MOJIBAKE: emoji> Biggest ROI: Run **Step 9 Backend Hardening** first
   - Fixes 4 P1 issues (security + health) in ~30 min
   - ROI Score: (4<MOJIBAKE: emoji>5)/30 = 0.67

Then run **Step 11 Frontend Migration** remediation pass
   - Fixes 8 P2 accessibility issues in ~45 min
   - ROI Score: (8<MOJIBAKE: emoji>3)/45 = 0.53

Lowest priority: **Step 7 Upgrade** remediation
   - Fixes 2 P1 async issues in ~20 min
   - ROI Score: (2<MOJIBAKE: emoji>5)/20 = 0.50
```

---

## Category Weights

| Cat | Weight | Key Checks |
|-----|--------|------------|
| Parity | 20% | Route count, characterization tests, same behavior |
| Functionality | 18% | No TODO, tests pass, wiring complete |
| Fusion/Dominion | 15% | IFusionLogger, @fusion packages, 12-Factor |
| Code Quality | 12% | No async anti-patterns, nullable, SOLID |
| Security | 12% | [Authorize], no secrets, OWASP |
| Testing | 10% | xUnit, Playwright, Angular tests |
| Architecture | 5% | Clean structure, no circular deps |
| OCP/DevOps | 5% | Health checks, pipeline, container |
| Production | 3% | No debug code, docs, logging |

---

# REPORT OUTPUT (MANDATORY)

## Step 1: Generate Comprehensive Chat Report

After analysis, output a **full comprehensive report in chat** with these sections in order:

```markdown
# <MOJIBAKE: emoji> Technical Review Report - [AppName]
**Generated**: [Date/Time]
**Reviewer**: Step 24 Technical Review
**Status**: [GO <MOJIBAKE: emoji> / NO-GO <MOJIBAKE: emoji> / CLOSE <MOJIBAKE: emoji>]

---

## Executive Summary

| Metric | Value |
|--------|-------|
| **Overall Score** | [X]/100 |
| **Decision** | [GO/NO-GO/CLOSE] |
| **Total Issues** | [X] (P1: [X], P2: [X], P3: [X], P4: [X]) |
| **Est. Remediation Time** | [X] hours |
| **Biggest ROI Step** | Step [X] - [Name] |

---

## Category Breakdown

| Category | Weight | Score | Issues | Status |
|----------|--------|-------|--------|--------|
| Parity | 20% | [X]/20 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Functionality | 18% | [X]/18 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Fusion/Dominion | 15% | [X]/15 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Code Quality | 12% | [X]/12 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Security | 12% | [X]/12 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Testing | 10% | [X]/10 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Architecture | 5% | [X]/5 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| OCP/DevOps | 5% | [X]/5 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Production | 3% | [X]/3 | [X] | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |

---

## Issue List

| # | Sev | Category | File:Line | Issue | Effort | Fix Step |
|---|-----|----------|-----------|-------|--------|----------|
| 1 | P1 | Security | file.cs:45 | Description | 5m | Step 10 |
| 2 | P2 | Angular | comp.ts:12 | Description | 10m | Step 12 |
...

---

## <MOJIBAKE: emoji> Remediation ROI Recommendation

| Priority | Run This Step | Fixes Issues | Est. Time | ROI Score |
|----------|---------------|--------------|-----------|-----------|
| 1<MOJIBAKE: emoji> | Step [X] ([Name]) | #1, #4, #8 | [X]m | <MOJIBAKE: emoji x5> |
| 2<MOJIBAKE: emoji> | Step [X] ([Name]) | #2, #5 | [X]m | <MOJIBAKE: emoji x4> |
| 3<MOJIBAKE: emoji> | Step [X] ([Name]) | #3 | [X]m | <MOJIBAKE: emoji x3> |

**My recommendation**: Run **Step [X]** first because [reason].

---

## Accessibility Coverage

| Metric | Count | Target | Status |
|--------|-------|--------|--------|
| Elements with `aria-label` | [X] | 100% | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Elements with `data-testid` | [X] | 100% | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |
| Interactive elements total | [X] | - | - |
| Coverage % | [X]% | 100% | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>] |

---

## Test Coverage

| Suite | Files | Pass | Fail | Coverage |
|-------|-------|------|------|----------|
| Backend Unit | [X] | [X] | [X] | [X]% |
| Backend Integration | [X] | [X] | [X] | [X]% |
| Frontend Playwright | [X] | [X] | [X] | [X]% |
| Angular Unit | [X] | [X] | [X] | [X]% |

---

## What's Next

**If NO-GO**: Fix issues in priority order, then rerun Step 23.
**If CLOSE**: Fix P1s only, then rerun Step 23.
**If GO**: Proceed to Step 23/23 sign-off.

---

**Pick fixes**: "Fix #1, #5, #12" or "Fix all P1" or "Fix #1-8"
```

---

## Step 2: Create Persistent Report File (MANDATORY)

After displaying the chat report, **ALWAYS create a markdown file** at:

```
.modernization/ignition-artifacts/technical-review-report.md
```

The file MUST contain:
1. **Full report** (same content as chat)
2. **Raw scan data** (PowerShell output)
3. **Timestamp** for freshness tracking
4. **Previous run comparison** (if prior report exists)

### Report File Template

Create this file with exact content:

```markdown
# Technical Review Report

> **Generated**: [ISO timestamp]
> **App**: [AppName]
> **Score**: [X]/100 [GO/NO-GO/CLOSE]
> **Previous Score**: [X]/100 (if exists) | [<MOJIBAKE: emoji>/<MOJIBAKE: emoji>/=] [X] points

---

## Summary Dashboard

```
+----------------------------------------------------+
<MOJIBAKE: box-drawing>  TECHNICAL REVIEW SCORECARD                    <MOJIBAKE: box-drawing>
+----------------------------------------------------+
<MOJIBAKE: box-drawing>  Overall Score:   [<MOJIBAKE: emoji progress bar>] [X]/100   <MOJIBAKE: box-drawing>
<MOJIBAKE: box-drawing>  Decision:        [GO <MOJIBAKE: emoji> / NO-GO <MOJIBAKE: emoji> / CLOSE <MOJIBAKE: emoji>]   <MOJIBAKE: box-drawing>
<MOJIBAKE: box-drawing>  Issues Found:    [X] total (P1:[X] P2:[X] P3:[X] P4:[X])   <MOJIBAKE: box-drawing>
<MOJIBAKE: box-drawing>  Est. Fix Time:   [X] hours                      <MOJIBAKE: box-drawing>
<MOJIBAKE: box-drawing>  Best ROI Step:   Step [X] - [Name]              <MOJIBAKE: box-drawing>
+----------------------------------------------------+
```

## Category Scores

[Full category breakdown table]

## All Issues (Detailed)

[Full issue list with file paths, line numbers, code snippets]

## ROI Remediation Plan

[Prioritized step recommendations]

## Raw Scan Output

<details>
<summary>Click to expand raw PowerShell scan output</summary>

```powershell
# Build scan output
[paste output]

# Security scan output
[paste output]

# Accessibility scan output
[paste output]

# Test scan output
[paste output]
```

</details>

## History

| Run | Date | Score | Issues | Delta |
|-----|------|-------|--------|-------|
| Current | [date] | [X] | [X] | - |
| Previous | [date] | [X] | [X] | [<MOJIBAKE: emoji>X] |

---

*This report can be referenced before rerunning Step 23 to track progress.*
```

---

## Step 3: Recheck Mode

When user says "recheck" or runs Step 23 again:

1. **Read previous report** from `.modernization/ignition-artifacts/technical-review-report.md`
2. **Run fresh scan**
3. **Compare results** - show delta for each category
4. **Update report file** - preserve history, add new run
5. **Highlight improvements** - "Fixed 5 issues since last run!"

### Recheck Output Format

```markdown
# <MOJIBAKE: emoji> Technical Review Recheck - [AppName]

## Progress Since Last Run

| Metric | Previous | Current | Delta |
|--------|----------|---------|-------|
| Score | 72 | 86 | <MOJIBAKE: emoji> +14 |
| P1 Issues | 5 | 1 | <MOJIBAKE: emoji> -4 <MOJIBAKE: emoji> |
| P2 Issues | 8 | 4 | <MOJIBAKE: emoji> -4 <MOJIBAKE: emoji> |
| P3 Issues | 3 | 3 | = 0 |

## Issues Resolved <MOJIBAKE: emoji>
- #1 Missing [Authorize] - FIXED
- #2 Async anti-pattern - FIXED
- #4 Missing health checks - FIXED
- #5 Missing aria-label (dashboard) - FIXED

## Issues Remaining <MOJIBAKE: emoji>
- #3 Large file (650 lines) - Still needs split
- #6 Missing Playwright tests - Partially addressed

## New Issues Found <MOJIBAKE: emoji>
- #15 New hardcoded string in config

## Updated Recommendation
**Previous**: Run Step 10 first
**Current**: Run Step 19 cleanup (only 1 P1 remains)
```

---

## File Output Rules

1. **Always create** `.modernization/ignition-artifacts/technical-review-report.md`
2. **Append history** - don't overwrite previous runs, add to history table
3. **Include timestamps** - ISO format for sorting
4. **Include raw data** - in collapsed details block
5. **Track deltas** - compare to previous run if exists

