---
description: Step 12 browser platform-integration lane that aligns protected API ownership, auth behavior, and client runtime control points after route migration.
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

# Step 12 Frontend Platform Integration

**Recommended model tier:** Premium reasoning (medium-high thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 12 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before editing platform-owned client seams: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 12 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change client runtime ownership until the restore point is present.
> - Scaffold-debt scan before closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-scaffold-debt.ps1 -CurrentStep 12 -Quiet`. This flags surviving scaffold-debt markers ("Step N wires this", "wired in a Later step", placeholder bodies) whose owning step has been reached. Exit 2 means overdue markers survive: finish the announced behavior against the legacy answer key and remove the now-stale marker, or accept a genuinely-intentional note in the scaffold-debt registry. The output verify below fails while overdue markers remain.
> - Backend functionality-parity scan before closeout (MANDATORY): run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-backend-parity.ps1 -Quiet`. This proves every LEGACY backend endpoint - especially every mutation (POST/PUT/DELETE/PATCH: Add/Edit/Delete/Link/Export) - has a modern counterpart. Exit 2 means the modernization ported only the read path and DROPPED write functionality the legacy app shipped (the exact failure where the UI still shows Add/Edit/Delete buttons over placeholder modals while no backend endpoint exists). Port the missing endpoints and wire their UI actions, or record genuinely out-of-scope operations in `.modernization/ignition-artifacts/discovery/backend-parity-registry.json` (`acceptedDrops[]` with a reason). The output verify below fails while any Legacy mutation endpoint has no modern counterpart and no accepted waiver.
> - Functional Parity Ledger scan before closeout (MANDATORY): run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-functional-parity-ledger.ps1 -Quiet`. This answers "are ALL legacy behaviors implemented?" -- not just endpoints (backend-parity) and fields (dto-coverage), but every interactive control classified at Step 3 by effectClass: Add/Edit/Delete (mutate), filter/search (filter), navigation (navigate), exports, and form dialogs. Exit 2 means major gaps remain -- behaviors inventoried at Step 3 have no modern implementation. The user sees missing buttons, dead filters, or filter controls that show identical rows before and after applying. Fix by porting unimplemented behaviors, or record explicit waivers in `functional-parity-registry.json` with a written reason per entry. The output verify below fails while any major gap remains.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 12 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Wires the moved-in app to the real protected backend - sign-in/auth, the bearer-token or approved protected-request path, callback and logout behavior, default landing - and proves every in-scope route loads real data under a real authenticated session.
- **Why it matters:** This is the app's single authoritative data gate. If a route's data call is broken (wrong endpoint, an unregistered server route, a `400`/`500` payload mismatch, a `403` role gap), this is where it must be caught and fixed. A page that rendered with stub or dev data in Step 11 becomes truly functional here, or it does not ship.
- **What you will have when it is done:**
  - `perRouteApiWiringList` - per route: the primary endpoint, observed status, and whether the data source is `live`, `stub`, or `missing`.
  - `ui-api-wiring-map.json` - every UI call resolved to a real controller action (no broken calls).
  - Auth journey E2E coverage (login, logout, unauthorized, 403) proving the protected flows from the browser.
  - `runtime-parity-checkpoint.json` - proof each in-scope route renders real data under auth with no unexplained `4xx`/`5xx`. For routes with `filter` ledger entries, `filterAssertions[]` must show `rowsChanged: true` for each filter control (a filter that returns identical rows before and after applying is a `filterEffect: fail`). For routes with sibling list sections backed by separate data calls, `siblingListDistinctness[]` must confirm each section returns distinct first-row content (identical rows across sections is a `siblingListDistinctness: fail`). For routes with `mutate` ledger entries, `mutateWiringAssertions[]` must confirm each shows `networkCallObserved: true` (a modal that opens but never fires a write call is a `mutateWiring: fail`).

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 12 OWNS the single authoritative live-data + auth verdict for the whole app.** Auth wiring, protected-API ownership, callback/logout, and "every in-scope route returns real data under a real authenticated session - including parameterized/detail routes, with no `4xx`/`5xx` route-contract error and no surviving placeholder" are settled here. This is THE data gate of record; Steps 11 and 13 defer to it.
- **This step does NOT own:** the styling foundation (Step 10), control/column presence (Step 11 - if a control or column is missing, that is a Step 11 regression to fix at its source), visual/layout polish (Step 13), or Fusion swaps (Steps 15-16).
- **This step CONSUMES:** Step 11's migrated routes and `perRouteBehaviorList` (items Step 11 deferred to Step 12 are wired live here), and the Step 10 styling foundation (run `scan-styling-foundation.ps1` as an entry check; report regressions back to Step 10).

**Desired completed state:** every in-scope route's primary protected call attaches the approved auth, returns real data under a real authenticated session with an observed success status, and renders that data in the legacy column/field set - `perRouteApiWiringStatus: LiveAllInScope` - with the auth journey (login, logout, unauthorized, 403) proven from the browser and zero broken UI->API calls remaining.

## Step 12 Verdict Model (deterministic gate of record + render confirmation)

> Step 12 proves two *different* things. Keep them as two explicit verdicts so the step stays honest on every app - with or without a usable auth session in the current environment.

- **`routeContractStatus` is the auth-free GATE OF RECORD.** The UI->API wiring gate (`generate-ui-api-map.ps1 -FailOnBrokenCalls`) is deterministic and needs no credentials: it proves every client call resolves to a real controller action+verb. `brokenCallCount = 0` -> `Clean`; `brokenCallCount > 0` -> `BrokenCalls` (closure-blocking - a guaranteed runtime failure); only method-built/dynamic URLs left in `unresolvedClientCalls` -> `UnresolvedOnly` (advisory). `Clean` is required to close Step 12 and is obtainable on any app without a login.
- **`liveDataRenderStatus` is the authenticated confirmation - and is never faked.** It is `Verified` only when each in-scope route is observed rendering real rows under a real authenticated session. A `401`, a scanner result, a `200`, or a carried-forward prior observation are NOT `Verified`. A route that errors under auth (`4xx`/`5xx`/empty grid) is `Failed`. When no usable auth session exists in the current environment, record `UnverifiedPendingAuth` (honest Partial) - never infer `live` from a protected `401`.
- **Canonical way to obtain the render confirmation:** open the running app in the integrated browser and have the operator complete the real sign-in in that shared page, then observe each route's live render. If that path is unavailable, close the deterministic half and report `liveDataRenderStatus: UnverifiedPendingAuth` rather than guessing.
- **Closure:** Step 12 is fully complete only when `routeContractStatus: Clean` AND `liveDataRenderStatus: Verified`. With `Clean` + `UnverifiedPendingAuth` the deterministic contract is proven but the step stays Partial (awaiting authenticated confirmation) - it does not advance as Complete on an unconfirmed or carried-forward render.

About To Do
- Context: Step 12 is the browser platform-ownership lane after route migration. It must prove the frontend is talking to the real protected backend through the approved client platform seams, not just that pages render.
- Dev work: Align auth, protected API ownership, callback/logout behavior, landing behavior, and client runtime control points to the Step 5 contract, then rerun the narrowest proof that can falsify the integration claim.
- QA plan: Use `[WORKFLOW] Frontend Platform Integration` inside the active Step 12 loop at meaningful checkpoints and at closeout to confirm the browser runtime matches the control-point contract and that skipped client preflight coverage is not overstated as proof.

Objective
- Execute Step 12 `Frontend Platform Integration` as the browser platform-ownership lane after Step 11 moved the route families.
- Align protected API ownership, callback or logout behavior, default landing behavior, and client runtime control points to the Step 5 contract without broad restyling.
- Classify Step 12 completion explicitly with these statuses:
  - `routeContractStatus` (deterministic, auth-free GATE OF RECORD - from the UI->API wiring gate): `Clean`, `BrokenCalls`, or `UnresolvedOnly`
  - `liveDataRenderStatus` (authenticated render confirmation - never carried forward, never inferred from a `401`): `Verified`, `UnverifiedPendingAuth`, or `Failed`
  - `protectedApiOwnershipStatus`: `Aligned`, `DriftDetected`, or `Blocked`
  - `authRuntimeStatus`: `Verified`, `403GapOpen`, or `Blocked`
  - `perRouteApiWiringStatus` (per-route live-data roll-up; may be `LiveAllInScope` only when `liveDataRenderStatus: Verified`): `LiveAllInScope`, `PartialPerRouteList`, or `Blocked`
- Do not close Step 12 when the browser reaches the API but still fails the positive path, when callback or logout ownership is still drifting from the Step 5 contract, when migrated routes still render placeholder/seed/hard-coded data instead of the real protected backend response, when interactive controls on migrated routes are still wired to dead handlers or missing service calls, or when current proof comes only from skipped install, test, or compile coverage without saying so plainly.

Execution mode
- This prompt is operational, not advisory. Resolve the current browser platform-ownership gaps, apply the smallest truthful fixes, and rerun proof until the current integration checkpoint is either real or blocked.
- Treat the mapped QA workflow as the Step 12 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json` before editing browser auth, HTTP transport, callback or logout behavior, landing behavior, or client runtime ownership.
- Integrate platform-owned client concerns through the protected starter shell instead of building a parallel client platform stack.

**Angular 20+ Code Quality (MANDATORY)**
All platform integration code MUST follow:
- Use standalone components with `imports: []` (no NgModules)
- Use signals for reactive state: `signal()`, `computed()`, `effect()`
- Use `@let` syntax for template variables
- Use `inject()` in constructors, not `@Inject()` decorators
- Use control flow: `@if`, `@for`, `@switch` (not `*ngIf`, `*ngFor`)
- Use `DestroyRef` and `takeUntilDestroyed()` for subscriptions
- Platform code with NgModules or legacy patterns is incomplete Step 12 coverage.

**Accessibility & Testability (MANDATORY)**
Every interactive element added or modified MUST have:
- `aria-label` or `aria-labelledby` for screen readers
- `data-testid` for Playwright automation
- Proper `role` attribute when semantic HTML is insufficient
- Focus management for auth flows and callbacks
- Error messages linked via `aria-describedby`
- Platform integration without accessibility attributes is incomplete Step 12 coverage.

**AUTH FLOW TESTING (MANDATORY)**

Step 12 MUST create comprehensive auth testing infrastructure:

**Auth Page Object Models (REQUIRED)**
Create these auth-specific POMs in `tests/frontend/e2e/pages/`:
```typescript
// LoginPage.ts
import { BasePage } from './BasePage';
import { Page } from '@playwright/test';

export class LoginPage extends BasePage {
  readonly signInButton = () => this.getByRole('button', { name: /sign in/i });
  readonly usernameInput = () => this.getByLabel('Username');
  readonly passwordInput = () => this.getByLabel('Password');
  readonly errorMessage = () => this.getByTestId('login-error-message');

  async login(username: string, password: string): Promise<void> {
    await this.usernameInput().fill(username);
    await this.passwordInput().fill(password);
    await this.signInButton().click();
  }

  async expectError(message: string): Promise<void> {
    await this.expectVisible(this.errorMessage());
  }
}

// CallbackPage.ts
export class CallbackPage extends BasePage {
  readonly loadingIndicator = () => this.getByTestId('auth-callback-loading');

  async waitForRedirect(): Promise<void> {
    await this.page.waitForURL('**/home**', { timeout: 10000 });
  }
}

// UnauthorizedPage.ts
export class UnauthorizedPage extends BasePage {
  readonly accessDeniedMessage = () => this.getByRole('heading', { name: /access denied/i });
  readonly loginLink = () => this.getByRole('link', { name: /sign in/i });
}
```

**E2E Auth Testing (REQUIRED - NO .feature files)**

Step 12 must create Playwright E2E tests with detailed inline documentation. All test scenarios live as JSDoc-style comments in the test code itself. Do NOT create .feature files or step definitions.

**Auth E2E Test Template:**

Create `tests/frontend/e2e/auth.journey.spec.ts`:
```typescript
/**
 * This file protects the authentication user journey for Step 12.
 * This file verifies that users can successfully login, logout, and access protected routes.
 * This file stays in the E2E lane so auth flows are proven from the browser perspective.
 * This file makes the Step 12 auth contract explicit before deployment depends on it.
 */

import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';

test.describe('Authentication Flows', () => {

  test('User can sign in successfully', async ({ page }) => {
    /**
     * CaseId: STEP12-E2E-AUTH-001
     * Scenario: User needs to sign in to access protected application features.
     * Description: The login flow should authenticate the user and redirect to home page with valid session.
     * Input: Valid username and password credentials from environment variables.
     * Expected: User is redirected to /home with authenticated session and profile visible.
     */

    // Given: the user is on the login page.
    const loginPage = new LoginPage(page);
    await loginPage.goto();

    // When: the user enters valid credentials and submits.
    await loginPage.login(process.env.TEST_USER!, process.env.TEST_PASS!);

    // Then: the user is redirected to the home page with authenticated state.
    await expect(page).toHaveURL(/.*\/home/);
    await expect(page.locator('[data-testid="user-profile"]')).toBeVisible();
  });

  test('User can sign out', async ({ page }) => {
    /**
     * CaseId: STEP12-E2E-AUTH-002
     * Scenario: Authenticated user needs to securely sign out and clear session.
     * Description: The logout flow should clear session state and redirect to login page.
     * Input: Authenticated user session with valid login.
     * Expected: Session is cleared and user is redirected to /login.
     */

    // Given: the user is already authenticated.
    const loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(process.env.TEST_USER!, process.env.TEST_PASS!);

    // When: the user clicks the sign out button.
    await page.locator('[data-testid="sign-out-button"]').click();

    // Then: the user is redirected to login page with session cleared.
    await expect(page).toHaveURL(/.*\/login/);
    await expect(page.locator('[data-testid="user-profile"]')).not.toBeVisible();
  });

  test('Unauthorized user is redirected', async ({ page }) => {
    /**
     * CaseId: STEP12-E2E-AUTH-003
     * Scenario: Unauthenticated user attempts to access protected route.
     * Description: The auth guard should block access and redirect to access denied or login page.
     * Input: No authenticated session, attempt to navigate to /dashboard.
     * Expected: User is redirected to access denied page or login page.
     */

    // Given: the user has no authenticated session.
    await page.context().clearCookies();

    // When: the user tries to access a protected route.
    await page.goto('/dashboard');

    // Then: the user sees the access denied page or login redirect.
    await expect(page).toHaveURL(/.*\/(login|access-denied)/);
  });

  test('Insufficient permissions shows 403', async ({ page }) => {
    /**
     * CaseId: STEP12-E2E-AUTH-004
     * Scenario: Authenticated user with insufficient role attempts to access admin route.
     * Description: The authorization check should return 403 Forbidden for insufficient permissions.
     * Input: Authenticated user with LIMITED_USER role attempts /admin route.
     * Expected: 403 Forbidden message is displayed.
     */

    // Given: the user is authenticated with limited permissions.
    const loginPage = new LoginPage(page);
    await loginPage.goto();
    await loginPage.login(process.env.TEST_LIMITED_USER!, process.env.TEST_PASS!);

    // When: the user tries to access an admin-only route.
    const response = await page.goto('/admin');

    // Then: the response is 403 Forbidden.
    expect(response?.status()).toBe(403);
    await expect(page.locator('[data-testid="forbidden-message"]')).toBeVisible();
  });
});
```

**Auth POM Updates (REQUIRED):**

Update or create `tests/frontend/e2e/pages/LoginPage.ts`:

```typescript
/**
 * This file protects the Login page interaction model for Step 12.
 * This file verifies that the LoginPage POM correctly encapsulates login form selectors and actions.
 * This file stays in the POM lane so auth E2E tests have a stable interface to the login UI.
 * This file makes the Step 12 login page contract explicit before E2E tests depend on it.
 */

import { Page } from '@playwright/test';

export class LoginPage {
  constructor(private readonly page: Page) {}

  async goto(): Promise<void> {
    await this.page.goto('/login');
  }

  async login(username: string, password: string): Promise<void> {
    // Interact with login form using data-testid selectors
    await this.page.locator('[data-testid="username-input"]').fill(username);
    await this.page.locator('[data-testid="password-input"]').fill(password);
    await this.page.locator('[data-testid="login-button"]').click();
  }
}
```

**Step 12 E2E Test Exit Criteria:**
- [ ] QA phase announcement made after dev work complete
- [ ] `auth.journey.spec.ts` created with all 4+ auth scenarios
- [ ] LoginPage POM updated with data-testid selectors
- [ ] All test files have 4-line file-level purpose block
- [ ] All test methods have CaseId/Scenario/Description/Input/Expected comments
- [ ] NO .feature files created (all scenarios inline as comments)
- [ ] NO step definition files created
- [ ] All auth tests pass (`npx playwright test auth.journey.spec.ts`)
- [ ] test-accumulation-tracker.json updated

**Test Accumulation Tracker Update (MANDATORY)**
At end of Step 12, update `.modernization/portal/data/json/test-accumulation-tracker.json`:
```json
{
  "currentStep": 12,
  "authTestCoverage": {
    "loginPagePom": true,
    "authJourneyTests": true,
    "authTestsPass": true
  }
}
```

- Inventory the client service endpoints or browser-to-API calls touched in the current pass and check that each one points at a real modern backend route family before calling the slice wired.
- Treat duplicated api-prefix ownership as a Step 12 defect when Fusion config already owns the shared /api base path.
- Include a short plain-language wiring summary in the numbered-step response that says what was checked, fixed, and still unwired.
- **Run the Step 8 API Surface Smoke before any integration work.** Before executing the UI -> API wiring generator or any `frontend-integration` spec, re-run the Step 8-planned API smoke probe set under `tests/backend/smoke/` and require 100% pass against `progressDenominators.totalApiEndpoints`. The smoke is the cheapest signal that the backend process actually loaded the current build (a stale-DLL / stale-process regression - verb missing, route 404, auth middleware unwired, validation gate skipped - is exactly the failure mode this gate exists to catch before any UI spec runs). Honor the tiered safety contract in `.github/instructions/testing-design-contract.instructions.md` -> "API Smoke Probe - Safety Tiers": T1 unauth-reachability is the floor for every endpoint, T2 covers CORS preflight, T3/T4 cover mutating verbs only with the recorded validation-gate or `mutatesState:false` evidence, and T5 stays OFF unless `kit-params.md` declares ephemeral data and the user has opted in. Sub-100% smoke coverage MUST be a tracked deferral with a `deferralId`, not a silent skip.
- **Run the UI -> API wiring generator and resolve every broken call before Step 14 closes.** Execute `powershell -NoProfile -ExecutionPolicy Bypass -File .\.github\scripts\QA\generate-ui-api-map.ps1 -FailOnBrokenCalls`, then read `.modernization/ignition-artifacts/discovery/ui-api-wiring-map.json`. Then run `powershell -NoProfile -ExecutionPolicy Bypass -File .\.github\scripts\QA\generate-integration-tests.ps1` to refresh the auto-generated Playwright integration suite under `tests/frontend/e2e/integration/generated/` - one spec per resolved `{trigger, apiCall}` chain, with mutating verbs intercepted via `page.route(...)` so the GET-only data-safety default is preserved. The `-FailOnBrokenCalls` switch makes the script exit non-zero whenever `summary.brokenCallCount > 0`, so the Step 14 hard gate is machine-enforced and cannot be inadvertently overlooked. Step 14 cannot close while `summary.brokenCallCount > 0` (a UI service call points at an endpoint+verb that does not match any modern controller action - that is a guaranteed runtime failure). Each entry in `orphanApiActions[]` must be reconciled: either remove the dead endpoint, wire the missing UI control, or record an explicit Step 8 retirement decision. Each in-scope route must have at least one `frontend-integration` spec under `tests/frontend/integrationFrontend/` derived from `tests/frontend/integrationFrontend/_template/ui-api-wiring.spec.template.ts` that drives a representative wired control and asserts (a) the expected verb+route fired, (b) the response was 2xx for read-only verbs OR the request was observed via interception for mutating verbs, (c) the UI populated with the response data. **Honor the read-only default**: routes whose only wired controls are GET/HEAD use Pattern A (live backend). Routes with POST/PUT/PATCH/DELETE controls default to Pattern B (interception) so the backend is never mutated; only escalate to live mutation when the Step 8 catalog row has `dataSafety: \"mutates\"` and a reviewer-approved `isolationMechanism`. See the `UI -> API Integration Contract` and `Read-Only Default (Data Safety)` sections of `.github/instructions/testing-design-contract.instructions.md` for the full contract.
- Prove per-route data wiring is live, not only that the platform seam exists. Step 14 owns the gate that every migrated route's primary data calls actually reach the real protected backend and render real data. Using the Step 8 per-route behavior plan or the Step 13 `perRouteBehaviorList` as the work order, for every in-scope route prove and record:
  - the route's primary protected data call(s) attach the approved auth mechanism (bearer token, cookie, or Step 7-approved equivalent)
  - the call is observed end-to-end from the modernized client and the response is consumed by the route's component, not swallowed
  - the observed HTTP status is `200` or `204` (or another explicit non-error status documented in the Step 5 control-point contract), and any non-success status is recorded with reason
  - the route renders real backend data, with no surviving placeholder, seed, fixture, or hard-coded sample where the legacy route had a real backing call
  - the route renders that backend data in the **legacy column/field set**, not a collapsed or generic subset: a grid bound to a real response but showing fewer or more generic columns than the legacy route (column collapse) is a field-parity defect carried into Step 13, so restore the legacy columns here or record the dropped column as an owned residual item reclassified to Step 13 or later with a reason
  - any per-route hand-off classified by Step 11 as deferred to Step 12 (legacy click handlers, modal/banner triggers, export/print/download/upload controls, data-bound grids) is now wired to a real component method and service call, or explicitly reclassified to Step 13 or later with a reason
  - **authoritative authenticated render, never a status proxy:** the verdict for every route is observed in an authenticated browser session that fires the route's primary calls and shows real rows in the DOM. An unauthenticated `401`, a clean build, a scanner `majorGaps=0`, an SPA route returning HTTP 200, or a carried-forward prior-session row count are NOT a pass. Watch the backend log for `4xx` and `5xx`, not just `500`: a route whose authenticated load returns a validation `400`, a server `500`, or an empty/placeholder grid is `live`-failed for that route. If you cannot authenticate and render in the current environment, record the route `UnverifiedPendingAuth` (this rolls up to `liveDataRenderStatus: UnverifiedPendingAuth`) and keep the step open instead of writing `live`.
  - **drive parameterized/detail routes with a real record - never defer:** open every path-parameter route (for example `filekeys/log/:keyNo/:changeNo`) with a REAL record reached from its parent grid and assert its data load under auth. Do not close the step with a detail route marked "route-verified, deferred to UAT because it needs a real record": that deferral hides a `404` (the client calls a path-parameter endpoint the backend never registered - it exposed only a query-string GET) or a `4xx`/`5xx` when the backing query faults. A client API path with no matching server route is a route-contract defect this step owns.
- Record one entry per in-scope route in `Returned Data.perRouteApiWiringList` with `{route, primaryEndpoint, observedStatus, dataSource: live|stub|missing, residualBehaviorItems}`. `perRouteApiWiringStatus` may be `LiveAllInScope` only when every entry in the list has `dataSource: live` and `residualBehaviorItems` is empty or explicitly classified.
- **Workflow Trace coverage gate (state-machine parity, not just edge parity).** Step 14 must also load `.modernization/legacy-analysis/workflow-trace-inventory.json` (produced in Step 5). For every row whose `workflowStatus` is `fully-traced`, the integration suite under `tests/frontend/integrationFrontend/` MUST include a spec that drives the workflow's `triggerEvent` on the workflow's `surface` and asserts: (a) the request fired with the expected verb and URL, (b) **the request payload structure matches `requestShape` exactly** - including nested-vs-flat object structure and the casing of every property name (flat-vs-nested mismatches such as `selectedSubstationName: "name"` vs `selectedSubstationName: { selectedSubstationName: "name" }` are the most common parity 400 and MUST be caught here), (c) the response was bound to the documented UI surfaces, and (d) **every `visibleStateLabels` entry appeared and disappeared at the correct point in the state machine** (the pre-call label is absent before the click, the in-flight label or labels such as `CALCULATING: <sub> - <tref>` and `Completing N calculations...` appear after the click and before the response resolves, and the post-success label such as `CALCS COMPLETE FOR: <sub> - <tref>` appears once the response is bound). Asserting only that the API was called is insufficient and has shipped parity defects to users. Step 14 cannot close while any `fully-traced` row lacks a passing spec covering all four assertions, or while any `partially-traced` row has not been promoted to `fully-traced` or to a recorded Step 8 retirement decision.
- For protected API traffic:
  - use `FusionHttpService` or the explicitly approved app-owned bearer-token interceptor where the Step 5 contract requires bearer-token protection
  - do not leave plain `HttpClient`-only or cookie-only bypass paths as the final state for protected `/api` traffic when Step 5 marked those paths as protected
  - prove Authorization: Bearer behavior or the approved protected-request mechanism for the significant protected client API paths touched in this pass
  - prove that at least one significant protected client API path touched in this pass succeeds end-to-end from the modernized frontend under an authenticated session, not just that the browser sends a bearer token
  - when the app depends on a current-user, bootstrap, or role-projection call, prove that call succeeds from the modernized frontend and aligns to the same membership source used by the protected API path
  - if the browser sends the approved protected-request mechanism but the positive-path call still returns `403`, treat that as an unresolved role-mapping or membership-source gap, keep Step 14 open, and obtain or record the authoritative group identifiers or equivalent auth input before closing the step
- Prove callback paths, logout behavior, protected-route gating, default landing behavior, and client service or provider ownership against `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`.
- When Step 14 cites current startup-proof evidence from `.modernization/portal/data/json/test-workspace-gates.json`, report whether `Client install`, `Angular tests`, and `Client compile` ran or were skipped through `skipFlags.skipInstall`, `skipFlags.skipTests`, and `skipFlags.skipBuild`. Do not treat skipped client coverage as equivalent to current browser platform proof.
- Run the real client build after the first substantive platform edit, repair only the same platform slice until it is green, then run the narrowest runtime proof that can falsify the current integration claim.
- Record any remaining client `Temporary bridge` behavior explicitly. Do not treat old auth, old HTTP ownership, or old runtime paths as the final state once Step 5 marked a Fusion-owned or approved app-owned final mechanism.

Completion gate
- **Deterministic gate of record:** Step 12 cannot close unless `routeContractStatus: Clean` (the UI->API wiring gate exits 0 - every client call resolves to a real controller action+verb). `BrokenCalls` is closure-blocking; fix the contract (add the endpoint, retarget the caller, or record an explicit Step 8 retirement) and re-run the gate. This verdict is auth-free and applies on every app.
- **Deferral-drain gate (Step 12 owns "no button is dead"):** run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-ui-parity-gaps.ps1 -CurrentStep 12 -Quiet`. Any inert handler whose deferral `ownerStep <= 12` in `.modernization/ignition-artifacts/discovery/ui-deferral-registry.json` is re-flagged as a Major `InertControl` (exit 2), so a still-stubbed export/add/delete/selection handler blocks closure. Wire it now, or - only if it genuinely belongs to a later step whose gate verifies that behavior - re-point its `ownerStep` in the registry with a written reason. `deferredInertControlCount` for Step-12-or-earlier owners must reach `0` before this step closes; a `majorGaps = 0` with parked stubs still owed here is not a pass.
- **Full completion** requires `routeContractStatus: Clean` AND `liveDataRenderStatus: Verified` - the current protected API ownership, auth callback or logout behavior, default landing behavior, and client runtime control points match the Step 5 contract closely enough to stabilize the shell, the modernized frontend can complete at least one significant protected API success path without unexpected `403` results, every in-scope migrated route in `perRouteApiWiringList` records `dataSource: live` (or is explicitly classified to Step 13 or later with reason), and no migrated route still ships placeholder, seed, fixture, or hard-coded data where the legacy route had a real backing call.
- **Honest Partial (auth unavailable):** when `routeContractStatus: Clean` but no usable auth session exists in the current environment, report `liveDataRenderStatus: UnverifiedPendingAuth` and keep the exact next step on `Step 12 Frontend Platform Integration`. The deterministic contract is proven, but the step does not advance as Complete on an unconfirmed or carried-forward render.
- Otherwise keep the exact next step on `Step 12 Frontend Platform Integration`.
- In the numbered-step response, include explicit `routeContractStatus`, `liveDataRenderStatus`, `protectedApiOwnershipStatus`, `authRuntimeStatus`, `perRouteApiWiringStatus`, `perRouteApiWiringList`, and `startupProofStatus` values.

Per-Route HAR Diff Gate (MANDATORY)
- For every route exercised by Step 14 platform integration, record a HAR file for the same scripted user journey against both the legacy runtime and the modern runtime.
- Persist `/.modernization/ignition-artifacts/modernize/fusion-restructure/route-har-diff/<routeId>.json` with the diff: ``apiCallSequenceLegacy[]``, ``apiCallSequenceModern[]``, ``extraCallsInModern[]``, ``missingCallsInModern[]``, ``reorderedCalls[]``, ``payloadShapeDeltas[]``, ``authHeaderDeltas[]``, ``totalCallCountLegacy``, ``totalCallCountModern``, ``totalBytesLegacy``, ``totalBytesModern``.
- Any of ``extraCallsInModern``, ``missingCallsInModern``, ``reorderedCalls``, or auth-header drift blocks the route from closing unless documented as an intentional plan delta in Step 7's ``apiIntegrationPlan`` with reviewer approval.
- Generic across MVC, Razor Pages, Web Forms, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. The journey script comes from ``screenshotCoverageMatrix`` and ``userJourneyCatalog``, not from hand-written per-app scripts.

Runtime Error Watch (API + component, integrated browser)
- Use the integrated browser as the primary proof surface and keep the backend log stream open beside it. During every per-route check, watch both surfaces: the browser DevTools console for component/runtime errors (Angular template errors, unhandled promise rejections, failed XHR) and the backend log for API `4xx`/`5xx`. Any unexplained error is a Step 12 failure for that route - diagnose and fix it in-step. A route that "looks loaded" while the console shows a swallowed `400` or the backend logged a `500` is not `live`.

If You Hit A Blocker (finish this step, do not drift)
- A route that reaches the API but fails the positive path, or still ships placeholder data, poisons Step 13 visual parity and every Fusion slice stacked on top of it, so finish the live-data wiring here instead of advancing.
- Name the exact failing route and call, the most likely cause in plain language (for example: the client calls a path-parameter endpoint the backend never registered, or the payload is nested where the controller expects flat), the concrete fix to finish Step 12, and whether the real gap belongs upstream in Step 11 (a missing control/column) or in Step 5/8 (an auth or contract decision). Apply the smallest in-scope fix and re-run the affected route proof before reporting `Blocked`.
- Only advance when every in-scope route records `dataSource: live` (or an explicit, owned reclassification). Otherwise keep the exact next step on `Step 12 Frontend Platform Integration`.

## Step 12 DEV complete - next action

Step 12 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 12 QA will:** Verify protected API ownership, auth interceptors, and client runtime control points align with Fusion patterns.
**Lanes:** Contract, Auth interceptor checks
**Expected ETA:** 5-8 min ET

Reply with the number of your choice:
1. `QA` - run `12-QA-frontend-platform-integration` now (recommended).
2. `next` - continue to Step 13 DEV (Frontend Shell Stabilization).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/12-QA-frontend-platform-integration`.
