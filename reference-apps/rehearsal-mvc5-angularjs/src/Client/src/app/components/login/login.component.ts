import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { OIDC } from '../../auth/oidc.config';
import { AuthService } from '../../services/auth.service';

/**
 * SSO-only sign-in (approved visual deviation from the legacy credentials
 * form — the legacy /Account/Login path no longer exists in the API).
 */
@Component({
  selector: 'app-login',
  standalone: true,
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);
  private readonly route = inject(ActivatedRoute);

  ngOnInit(): void {
    // OIDC implicit-flow callback: the issuer redirects back to /login with
    // #access_token=...&state=<returnUrl>. Store the token, clean the hash,
    // and continue to the requested route.
    const hash = window.location.hash;
    if (hash && hash.indexOf('access_token=') !== -1) {
      const params = new URLSearchParams(hash.substring(1));
      const token = params.get('access_token');
      const state = params.get('state') || '/invoices';
      history.replaceState(null, '', window.location.pathname + window.location.search);
      if (token) {
        this.auth.setToken(token);
        this.router.navigateByUrl(state);
      }
    }
  }

  loginWithSso(): void {
    const returnUrl = this.route.snapshot.queryParamMap.get('returnUrl') || '/invoices';
    window.location.href =
      OIDC.issuer + '/authorize' +
      '?client_id=' + OIDC.clientId +
      '&redirect_uri=' + encodeURIComponent(location.origin + '/login') +
      '&response_type=token' +
      '&state=' + encodeURIComponent(returnUrl);
  }
}
