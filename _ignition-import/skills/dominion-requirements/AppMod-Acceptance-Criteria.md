# AppMod Acceptance Criteria

This document is the canonical acceptance-criteria reference used by the Discovery baseline and final compliance reviews.

## Review Intent

- Use these criteria to assess legacy and modernized code for modernization readiness and compliance risk.
- Treat the baseline review as evidence gathering before modernization.
- Treat the final review as evidence that the target implementation meets the same standards after modernization.

## Deterministic Patterns

### Critical

- Hardcoded credentials or secrets in source.
- SQL assembled from interpolated or concatenated input.
- Tokens stored in localStorage or sessionStorage.
- Unsanitized innerHTML or equivalent unsafe HTML injection.
- Sensitive data written to logs.

### High

- Forms authentication or Windows/role-centric authorization patterns instead of OAuth/OIDC and policy-based authorization.
- Blocking async calls such as .Result, .Wait(), or GetAwaiter().GetResult().
- async void outside true event handlers.
- Direct instantiation of service-layer dependencies or HttpClient.
- Service locator patterns.
- Hardcoded connection strings, API URLs, or environment-specific endpoints.
- Mutable static state or ASP.NET session state.
- File-based logging or local file persistence used as application state.
- NotImplementedException in active code paths.
- Direct DOM or jQuery usage in Angular application code.

### Medium

- Console logging in application code.
- String concatenation inside logger calls.
- Magic numbers without clear intent.
- Environment checks hardcoded in code.
- HttpClient injected directly into Angular components.
- fetch() used in Angular component code instead of an injectable service.
- Missing ChangeDetectionStrategy.OnPush where appropriate.
- Observable subscriptions without cleanup.
- XML formatter usage where JSON-first APIs are expected.
- Swagger enabled outside development-only guards.
- Verb-based API routes.
- Empty catch blocks or overly broad exception handling without rethrow or translation.

## Judgment-Based Review Areas

### SOLID

- Single responsibility.
- Open/closed design.
- Liskov substitution.
- Interface segregation.
- Dependency inversion.

### Security

- Authorization coverage on sensitive endpoints.
- Sensitive-data exposure in logs, responses, and errors.
- True SQL injection context for dynamic query construction.
- XSS risk for HTML trust and rendering flows.

### Twelve-Factor

- Configuration externalization.
- Backing service abstraction.
- Stateless design.
- Disposability and cancellation handling.
- Structured logging quality.

### API Design

- RESTful resource design and HTTP verb usage.
- Consistent error handling.

### Angular

- Component responsibility.
- State-management discipline and subscription cleanup.
- Route protection for privileged flows.

## File-Level Heuristics

- Class line count: more than 500 lines is High, 300 to 500 lines is Medium.
- Constructor parameters: more than 7 is High, 5 to 7 is Medium.
- Interface methods: more than 15 is High, 8 to 15 is Medium.

## Non-Violations

- Creating DTOs or collections with new.
- static readonly and const values.
- IMemoryCache usage for performance caching.
- new expressions inside test setup.

## Scoring

Score = 100 - (Critical x 10) - (High x 5) - (Medium x 2)
