/**
 * OIDC settings for the modern (Okta-style) sign-in path.
 * Strangler step 2: SPA obtains a bearer token from the identity provider;
 * the API validates it side by side with the legacy auth cookie.
 */
export const OIDC = {
  issuer: 'http://127.0.0.1:8321',
  clientId: 'legacyshop-spa',
  audience: 'legacyshop'
};
