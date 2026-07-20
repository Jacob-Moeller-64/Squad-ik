import { bootstrapApplication } from '@angular/platform-browser';

import { AppComponent } from './app/app.component';
import { appConfig } from './app/app.config';

// Legacy deep links use AngularJS hashbang URLs (/#!/orders/WO-1002). Rewrite
// them onto the modern path-based routes before the router boots so every
// inventoried route keeps working at its original address. The OIDC callback
// hash (#access_token=...) does not start with "#!" and is left untouched.
const hash = window.location.hash;
if (hash.startsWith('#!')) {
  const path = hash.substring(2);
  history.replaceState(null, '', path.startsWith('/') ? path : '/' + path);
}

bootstrapApplication(AppComponent, appConfig)
  .catch(err => console.error(err));
