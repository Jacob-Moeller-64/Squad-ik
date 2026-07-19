import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

import { ApiService } from './api.service';
import { LoginResult } from '../models';

@Injectable({ providedIn: 'root' })
export class AuthService {
  readonly isLoggedIn$ = new BehaviorSubject<boolean>(false);
  readonly user$ = new BehaviorSubject<string | null>(null);

  constructor(private api: ApiService) { }

  get isLoggedIn(): boolean {
    return this.isLoggedIn$.value;
  }

  login(username: string, password: string): Observable<LoginResult> {
    return this.api.login(username, password).pipe(
      tap(result => {
        if (result && result.ok) {
          this.isLoggedIn$.next(true);
          this.user$.next(result.user);
        }
      })
    );
  }

  logout(): void {
    this.api.logout().subscribe(
      () => {
        this.isLoggedIn$.next(false);
        this.user$.next(null);
      },
      () => {
        // Even if the server call fails, treat the client as logged out.
        this.isLoggedIn$.next(false);
        this.user$.next(null);
      }
    );
  }
}
