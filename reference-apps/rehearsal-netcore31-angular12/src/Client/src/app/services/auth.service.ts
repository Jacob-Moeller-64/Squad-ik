import { Injectable, computed, inject, signal } from '@angular/core';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

import { LoginResult } from '../models';
import { ApiService } from './api.service';

/**
 * Auth strangler step 2: the modern OIDC bearer token (kept in memory only)
 * lives side by side with the legacy cookie session. A user counts as logged
 * in when either path is active.
 */
@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly api = inject(ApiService);

  private readonly cookieLoggedIn = signal(false);
  private readonly accessToken = signal<string | null>(null);

  readonly user = signal<string | null>(null);
  readonly isLoggedIn = computed(() => this.cookieLoggedIn() || this.accessToken() !== null);

  /** Current OIDC bearer token, or null when only the cookie path (or nothing) is active. */
  get token(): string | null {
    return this.accessToken();
  }

  /** Legacy path: cookie session established by POST /api/account/login. */
  login(username: string, password: string): Observable<LoginResult> {
    return this.api.login(username, password).pipe(
      tap(result => {
        if (result && result.ok) {
          this.cookieLoggedIn.set(true);
          this.user.set(result.user);
        }
      })
    );
  }

  /** Modern path: store the bearer token obtained from the OIDC implicit redirect. */
  setToken(token: string): void {
    this.accessToken.set(token);
    this.user.set(this.readUserFromToken(token));
  }

  logout(): void {
    this.accessToken.set(null);
    this.api.logout().subscribe({
      next: () => {
        this.cookieLoggedIn.set(false);
        this.user.set(null);
      },
      error: () => {
        // Even if the server call fails, treat the client as logged out.
        this.cookieLoggedIn.set(false);
        this.user.set(null);
      }
    });
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
