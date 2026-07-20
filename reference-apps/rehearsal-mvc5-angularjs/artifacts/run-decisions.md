# Run decisions — rehearsal-mvc5-angularjs (FieldServe)

Mirrors app 1's decision set (rehearsal-netcore31-angular12) — same policies, same
treatment, per the kit's cross-app consistency requirement.

**RD-1** · steps 06/11 · Characterization suite re-pointed through the restructure;
assertions unchanged (D-001).

**RD-2** · step 15 · Visual triage standard: legacy-pixel parity for the port; the
login SSO flip is the approved intentional diff (D-004 step 14), re-baselined.

**RD-3** · step 17 · Legacy forms-cookie auth removed: /Account/Login|Logout deleted
from API and inventory; anonymous protected access now 401 (bearer) instead of MVC5's
302-to-login; protected goldens replay with TEST_BEARER. Planned strangler completion.

**RD-4** · structure gates · LegacyApplication/ retained as before-reference;
full-phase gates run against the src/-only app view.

**RD-5** · environment · MVC5 legacy ran via the Python harness (Windows/IIS
unavailable); Okta/Fusion are config-swappable stand-ins. Issuer audience: fieldserve
(port 8322).
