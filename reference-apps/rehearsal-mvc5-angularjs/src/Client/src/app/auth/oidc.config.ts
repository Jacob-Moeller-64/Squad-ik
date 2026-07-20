/**
 * OIDC settings for the SSO-only sign-in path (Okta-shaped stand-in issuer).
 * Auth strangler complete: the legacy forms-credentials path is gone; the SPA
 * obtains a bearer token via the implicit redirect and the API validates it.
 */
export const OIDC = {
  issuer: 'http://127.0.0.1:8322',
  clientId: 'fieldserve-spa',
  audience: 'fieldserve'
};
