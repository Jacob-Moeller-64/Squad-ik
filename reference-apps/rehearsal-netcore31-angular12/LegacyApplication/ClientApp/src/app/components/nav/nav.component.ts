import { Component } from '@angular/core';
import { Router } from '@angular/router';

import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.css']
})
export class NavComponent {
  constructor(public auth: AuthService, private router: Router) { }

  onLogout(): void {
    this.auth.logout();
    this.router.navigate(['/products']);
  }
}
