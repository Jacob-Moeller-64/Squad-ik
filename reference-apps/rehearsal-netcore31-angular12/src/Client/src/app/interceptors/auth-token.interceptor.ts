import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';

import { AuthService } from '../services/auth.service';

/**
 * Adds "Authorization: Bearer <token>" to /api/* requests whenever the modern
 * OIDC token is held in memory. Cookie-only sessions send no header.
 */
export const authTokenInterceptor: HttpInterceptorFn = (req, next) => {
  const auth = inject(AuthService);
  const token = auth.token;

  if (token && req.url.startsWith('/api')) {
    return next(req.clone({ setHeaders: { Authorization: 'Bearer ' + token } }));
  }
  return next(req);
};
