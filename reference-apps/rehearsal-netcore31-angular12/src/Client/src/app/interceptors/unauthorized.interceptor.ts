import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

/**
 * Redirects to /login whenever the API answers 401 Unauthorized.
 * The login call itself is excluded so a failed login shows its own error.
 */
export const unauthorizedInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);

  return next(req).pipe(
    catchError((err: HttpErrorResponse) => {
      if (err.status === 401 && req.url.indexOf('/api/account/login') === -1) {
        router.navigate(['/login']);
      }
      return throwError(() => err);
    })
  );
};
