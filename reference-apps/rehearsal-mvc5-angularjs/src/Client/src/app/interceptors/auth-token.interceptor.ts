import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';

import { AuthService } from '../services/auth.service';

/** MVC5-style PascalCase controller roots served by the FieldServe API. */
const API_PREFIXES = ['/WorkOrders', '/Technicians', '/Invoices', '/Dispatch'];

/**
 * Adds "Authorization: Bearer <token>" to FieldServe API requests whenever the
 * OIDC token is held in memory. Anonymous sessions send no header.
 */
export const authTokenInterceptor: HttpInterceptorFn = (req, next) => {
  const auth = inject(AuthService);
  const token = auth.token;

  if (token && API_PREFIXES.some(prefix => req.url.startsWith(prefix))) {
    return next(req.clone({ setHeaders: { Authorization: 'Bearer ' + token } }));
  }
  return next(req);
};
