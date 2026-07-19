import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  username = '';
  password = '';
  loading = false;
  error = '';

  constructor(
    private auth: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) { }

  onSubmit(): void {
    this.error = '';
    this.loading = true;
    this.auth.login(this.username, this.password).subscribe(
      result => {
        this.loading = false;
        if (result && result.ok) {
          const returnUrl = this.route.snapshot.queryParamMap.get('returnUrl') || '/products';
          this.router.navigateByUrl(returnUrl);
        } else {
          this.error = 'Invalid username or password.';
        }
      },
      () => {
        this.loading = false;
        this.error = 'Invalid username or password.';
      }
    );
  }
}
