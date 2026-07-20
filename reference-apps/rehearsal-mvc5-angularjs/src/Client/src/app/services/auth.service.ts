import { Injectable, computed, signal } from '@angular/core';

/**
 * SSO-only auth state. The OIDC bearer token is kept in memory only (no
 * localStorage/cookies); a page reload simply returns the user to anonymous.
 */
@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly accessToken = signal<string | null>(null);

  readonly user = signal<string | null>(null);
  readonly isLoggedIn = computed(() => this.accessToken() !== null);

  /** Current OIDC bearer token, or null when signed out. */
  get token(): string | null {
    return this.accessToken();
  }

  /** Store the bearer token obtained from the OIDC implicit redirect. */
  setToken(token: string): void {
    this.accessToken.set(token);
    this.user.set(this.readUserFromToken(token));
  }

  logout(): void {
    this.accessToken.set(null);
    this.user.set(null);
  }

  private readUserFromToken(token: string): string {
    try {
      const parts = token.split('.');
      if (parts.length < 2) {
        return 'sso-user';
      }
      const payload: unknown = JSON.parse(atob(parts[1].replace(/-/g, '+').replace(/_/g, '/')));
      if (payload && typeof payload === 'object') {
        const claims = payload as { name?: unknown; sub?: unknown };
        if (typeof claims.name === 'string' && claims.name) {
          return claims.name;
        }
        if (typeof claims.sub === 'string' && claims.sub) {
          return claims.sub;
        }
      }
      return 'sso-user';
    } catch {
      return 'sso-user';
    }
  }
}
