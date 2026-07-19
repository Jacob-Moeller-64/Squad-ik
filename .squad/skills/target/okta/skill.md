# Target skill — Okta (auth strangler: steps 09, 14, 17)

Okta is never a single switch-flip: the legacy frontend must keep working through the
backend wave (D-004). Three ordered moves:

## Strangler step 1 — Backend wave (step 09)
- New backend preserves legacy auth, or runs dual-stack: legacy session/cookie auth AND
  Okta bearer-token validation side by side.
- Interim topology checks: CORS between legacy frontend origin and new backend; cookie
  `Secure` + `SameSite=None` if auth is cookie-based cross-site; base paths.
- Gate (smoke suite as defined in pipeline step 09): legacy frontend served against the
  new backend, then goldens replay green + visual diff clean vs Phase-1 baselines. This
  is the shippable milestone — do not proceed until it's real.

## Strangler step 2 — Frontend flip (step 14)
- `src/Client` authenticates via Okta (OIDC). Redirect URIs registered per environment;
  client secrets via environment config, never committed.
- Forwarded-headers middleware must already be in place (fusion-structure step 4) —
  behind a TLS-terminating proxy, ASP.NET otherwise builds `http://` redirect URIs and
  Okta rejects the callback with a redirect-URI mismatch. This is the classic failure;
  check it first when login breaks.
- Protected/public route split comes from `ui-inventory.json`, not from guessing.
- Gate: automated e2e — Okta login → protected route → logout — green.

## Strangler step 3 — Legacy auth removal (step 17)
- Strip the legacy/dual-stack path entirely: middleware, endpoints, config.
- Gate: Okta e2e still green; legacy auth endpoints return 404/410.
- **Never skip.** A "modernized" app with a forgotten legacy auth path is worse than an
  unmodernized one — it looks secure and isn't.
