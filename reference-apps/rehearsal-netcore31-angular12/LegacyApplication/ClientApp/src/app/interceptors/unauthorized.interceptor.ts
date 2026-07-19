import { Injectable } from '@angular/core';
import {
  HttpErrorResponse,
  HttpEvent,
  HttpHandler,
  HttpInterceptor,
  HttpRequest
} from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

/**
 * Redirects to /login whenever the API answers 401 Unauthorized.
 * The login call itself is excluded so a failed login shows its own error.
 */
@Injectable()
export class UnauthorizedInterceptor implements HttpInterceptor {
  constructor(private router: Router) { }

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    return next.handle(req).pipe(
      catchError((err: HttpErrorResponse) => {
        if (err.status === 401 && req.url.indexOf('/api/account/login') === -1) {
          this.router.navigate(['/login']);
        }
        return throwError(err);
      })
    );
  }
}
