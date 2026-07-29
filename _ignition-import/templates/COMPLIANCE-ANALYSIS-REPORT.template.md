# {{STACK}} {{PHASE}} Compliance Report

NOTE: If emojis render as `??`, ensure this file is saved as UTF-8.

**Application:** {{APP_NAME}}
**Generated:** {{REPORT_DATE}}
**Scope:** {{SCOPE}}
**Excluded:** {{EXCLUDED_PATHS}}
**Rules source:** {{RULES_SOURCE}}

---

## COMPLIANCE SCORE: {{COMPLIANCE_SCORE}}/100 {{COMPLIANCE_SCORE_BADGE}}

### Scoring Method

`Score = 100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`

### Score Breakdown
| Severity | Count | Points Deducted |
|----------|-------|-----------------|
| CRITICAL | {{CRITICAL_COUNT}} | -{{CRITICAL_DEDUCT}} |
| HIGH | {{HIGH_COUNT}} | -{{HIGH_DEDUCT}} |
| MEDIUM | {{MEDIUM_COUNT}} | -{{MEDIUM_DEDUCT}} |
| **TOTAL DEDUCTIONS** | | **-{{TOTAL_DEDUCTIONS}}** |

**Compliance Score Calculation**
`100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`
`100 - ({{CRITICAL_COUNT}}x10) - ({{HIGH_COUNT}}x5) - ({{MEDIUM_COUNT}}x2) = {{COMPLIANCE_SCORE}}`

### Deployment Gate Status
| Gate | Required | Current | Status |
|------|----------|---------|--------|
| Compliance Score | >= 80 | {{COMPLIANCE_SCORE}} | {{GATE_SCORE_STATUS}} |
| CRITICAL Issues | 0 | {{CRITICAL_COUNT}} | {{GATE_CRITICAL_STATUS}} |
| Test Coverage | >= 80% | {{TEST_COVERAGE_PERCENT}} | {{GATE_COVERAGE_STATUS}} |
| Review complete | 100% files + every category judged | {{REVIEW_COMPLETENESS}} | {{GATE_REVIEW_STATUS}} |

**Deployment Readiness:** {{DEPLOYMENT_READINESS}}

---

## Evidence Snapshot

> Provide the latest objective artifacts used to support this report.

- **Build status:** {{BUILD_STATUS}}
- **Test status:** {{TEST_STATUS}}
- **Test coverage:** {{TEST_COVERAGE_PERCENT}} (source: {{TEST_COVERAGE_SOURCE}})
- **Dependency vulnerability scan:** {{VULNERABLE_PACKAGES_SUMMARY}}
- **Secrets scan:** {{SECRETS_SCAN_SUMMARY}}

---

## Scan Completeness

> Use this section to prove the report covers the intended scope.

- **Repo / commit:** {{REPO_REF}}
- **Scan inventory file:** {{SCAN_INVENTORY_FILE}}
- **Total files in scope:** {{TOTAL_FILES_IN_SCOPE}}
- **Total files scanned:** {{TOTAL_FILES_SCANNED}}
- **Scan completeness:** {{SCAN_COMPLETENESS_PERCENT}}

NOTE: If you cannot compute counts deterministically, set them to `UNKNOWN` and point to the inventory file and the exact scope/excludes used.

---

## Executive Summary

- **Baseline test coverage:** {{TEST_COVERAGE_PERCENT}} (source: {{TEST_COVERAGE_SOURCE}})
- **Primary blockers:** {{PRIMARY_BLOCKERS}}
- **Test health (informational):** {{TEST_HEALTH_SUMMARY}}

---

## Issue Counts by Severity

- **CRITICAL:** {{CRITICAL_COUNT}}
- **HIGH:** {{HIGH_COUNT}}
- **MEDIUM:** {{MEDIUM_COUNT}}
- **TOTAL:** {{TOTAL_ISSUES_FOUND}}

### {{REQUIREMENTS_SOURCE_NAME}} Requirements Checklist

> This table is the FIXED category set - identical for every application that runs through the kit.
> Rows are never added, removed, renamed, or reordered by a review; only Status/Findings/Notes vary.
> `UNKNOWN` means "not yet judged" (a worksheet placeholder), never "not applicable".
>
> Judged categories: {{REQUIREMENTS_JUDGED}}

| Requirement area | Status | Findings | Notes / evidence |
|---|---:|---|---|
| 12-factor overall | {{REQ_12_FACTOR_STATUS}} | {{REQ_12_FACTOR_FINDINGS}} | {{REQ_12_FACTOR_NOTES}} |
| 12-factor - externalized config | {{REQ_12_FACTOR_CONFIG_STATUS}} | {{REQ_12_FACTOR_CONFIG_FINDINGS}} | {{REQ_12_FACTOR_CONFIG_NOTES}} |
| 12-factor - backing services | {{REQ_12_FACTOR_BACKING_STATUS}} | {{REQ_12_FACTOR_BACKING_FINDINGS}} | {{REQ_12_FACTOR_BACKING_NOTES}} |
| 12-factor - logs as event stream | {{REQ_12_FACTOR_LOGS_STATUS}} | {{REQ_12_FACTOR_LOGS_FINDINGS}} | {{REQ_12_FACTOR_LOGS_NOTES}} |
| 12-factor - stateless processes | {{REQ_12_FACTOR_STATELESS_STATUS}} | {{REQ_12_FACTOR_STATELESS_FINDINGS}} | {{REQ_12_FACTOR_STATELESS_NOTES}} |
| SOLID overall | {{REQ_SOLID_STATUS}} | {{REQ_SOLID_FINDINGS}} | {{REQ_SOLID_NOTES}} |
| SOLID - single responsibility | {{REQ_SOLID_SRP_STATUS}} | {{REQ_SOLID_SRP_FINDINGS}} | {{REQ_SOLID_SRP_NOTES}} |
| SOLID - open/closed | {{REQ_SOLID_OCP_STATUS}} | {{REQ_SOLID_OCP_FINDINGS}} | {{REQ_SOLID_OCP_NOTES}} |
| SOLID - liskov substitution | {{REQ_SOLID_LSP_STATUS}} | {{REQ_SOLID_LSP_FINDINGS}} | {{REQ_SOLID_LSP_NOTES}} |
| SOLID - interface segregation | {{REQ_SOLID_ISP_STATUS}} | {{REQ_SOLID_ISP_FINDINGS}} | {{REQ_SOLID_ISP_NOTES}} |
| SOLID - dependency inversion | {{REQ_SOLID_DIP_STATUS}} | {{REQ_SOLID_DIP_FINDINGS}} | {{REQ_SOLID_DIP_NOTES}} |
| OAuth 2.0 OIDC or SAML authentication | {{REQ_AUTH_STATUS}} | {{REQ_AUTH_FINDINGS}} | {{REQ_AUTH_NOTES}} |
| Policy-based authorization (no Roles / `User.IsInRole`) | {{REQ_AUTHZ_STATUS}} | {{REQ_AUTHZ_FINDINGS}} | {{REQ_AUTHZ_NOTES}} |
| Stateless API / no static mutable state | {{REQ_STATELESS_STATUS}} | {{REQ_STATELESS_FINDINGS}} | {{REQ_STATELESS_NOTES}} |
| RESTful API endpoints | {{REQ_REST_STATUS}} | {{REQ_REST_FINDINGS}} | {{REQ_REST_NOTES}} |
| JSON responses | {{REQ_JSON_STATUS}} | {{REQ_JSON_FINDINGS}} | {{REQ_JSON_NOTES}} |
| API Docs (Scalar/OpenAPI) config-driven and disabled in production | {{REQ_SWAGGER_STATUS}} | {{REQ_SWAGGER_FINDINGS}} | {{REQ_SWAGGER_NOTES}} |
| Logging: 7 types + event-stream (stdout/stderr) | {{REQ_LOGGING_STATUS}} | {{REQ_LOGGING_FINDINGS}} | {{REQ_LOGGING_NOTES}} |
| All I/O operations async | {{REQ_ASYNC_STATUS}} | {{REQ_ASYNC_FINDINGS}} | {{REQ_ASYNC_NOTES}} |
| Test coverage >= 80% | {{REQ_COVERAGE_STATUS}} | {{REQ_COVERAGE_FINDINGS}} | {{REQ_COVERAGE_NOTES}} |
| Packages approved | {{REQ_APPROVALS_STATUS}} | {{REQ_APPROVALS_FINDINGS}} | {{REQ_APPROVALS_NOTES}} |

---

## Findings

> Enumerate ALL CRITICAL and HIGH findings. Include line numbers when available.
>
> For consistency, each finding should include:
> - **Severity:** (CRITICAL/HIGH/MEDIUM)
> - **Why it matters:** (1-2 sentences)
> - **Evidence:** (file paths + line numbers when available)
> - **Recommendation:** (what to change)

### CRITICAL Findings (Deployment Blockers)

{{CRITICAL_FINDINGS}}

### HIGH Findings (Fix Before Production)

{{HIGH_FINDINGS}}

### MEDIUM Findings (Recommended)

{{MEDIUM_FINDINGS}}

---

## Summary of CRITICAL & HIGH Issues

| ID | Severity | Description | File path | Line(s) |
|---|---|---|---|---|
{{CRITICAL_HIGH_SUMMARY_ROWS}}

---

## Progress Comparison (Baseline -> Current)

> Required for post-modernization reports only.
>
> For baseline reports:
> - Set `{{BASELINE_*}}` fields to the values in THIS report.
> - Set `{{CURRENT_*}}` fields to `N/A`.
> - Set all `{{*_CHANGE}}` fields to `N/A`.

| Metric | Baseline | Current | Change |
|--------|----------|---------|--------|
| **Compliance Score** | {{BASELINE_SCORE}} | {{CURRENT_SCORE}} | {{SCORE_CHANGE}} |
| CRITICAL Issues | {{BASELINE_CRITICAL}} | {{CURRENT_CRITICAL}} | {{CRITICAL_CHANGE}} |
| HIGH Issues | {{BASELINE_HIGH}} | {{CURRENT_HIGH}} | {{HIGH_CHANGE}} |
| MEDIUM Issues | {{BASELINE_MEDIUM}} | {{CURRENT_MEDIUM}} | {{MEDIUM_CHANGE}} |
| Test Coverage | {{BASELINE_COVERAGE}} | {{CURRENT_COVERAGE}} | {{COVERAGE_CHANGE}} |

### Issues Resolved Since Baseline

{{ISSUES_RESOLVED}}

### Issues Remaining

{{ISSUES_REMAINING}}

---

## Appendix

### Excluded Paths

{{EXCLUDED_PATHS}}
