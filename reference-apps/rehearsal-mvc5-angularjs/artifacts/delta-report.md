# Modernization Delta Report — FieldServe (rehearsal-mvc5-angularjs)

**Before: 40/100 → After: 84/100** (frozen engine 0.2.1 both phases — D-008)

| Dimension | Before | After |
|---|---|---|
| solid | 15/15 | 15/15 |
| twelve-factor | 3/15 | 15/15 |
| security-cve | 13/20 | 20/20 |
| dependency-eol | 4/10 | 10/10 |
| test-coverage | 0/15 | 15/15 |
| complexity | 5/5 | 5/5 |
| ocp-readiness | 0/10 | 4/10 |
| qualitative | 0/10 | 0/10 |

Behavior preservation: goldens 18/18 on the final bearer-only stack (33 captured at
Phase 1; account endpoints retired per RD-3); characterization suite green throughout;
Angular port pixel-identical on 4/6 routes after the preserveWhitespaces fix (promoted
to the angularjs adapter as a learned gotcha), 2 intentional SSO diffs re-baselined.

Transformation: MVC5-era backend → .NET 10 in src/{Library,API}; AngularJS 1.x →
Angular 18 standalone in src/Client; Swagger-era docs → Scalar; forms-cookie auth →
OIDC bearer (issuer audience fieldserve); fusion-ui swap (5 swap / 6 survive / 0
blocked) using the shared token block byte-identical with app 1.
