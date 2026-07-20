import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';

import { Invoice } from '../../models';
import { ApiService } from '../../services/api.service';
import { MoneyCentsPipe } from '../../pipes/money-cents.pipe';

@Component({
  selector: 'app-invoices',
  standalone: true,
  imports: [MoneyCentsPipe],
  templateUrl: './invoices.component.html',
  styleUrls: ['./invoices.component.css']
})
export class InvoicesComponent implements OnInit {
  private readonly api = inject(ApiService);
  private readonly router = inject(Router);

  loading = true;
  invoices: Invoice[] = [];

  ngOnInit(): void {
    this.api.getRecentInvoices().subscribe({
      next: invoices => {
        this.invoices = invoices;
        this.loading = false;
      },
      error: () => {
        // The 401 interceptor already redirects; this keeps the legacy
        // "anything that is not the invoice list means sign in" behavior.
        this.router.navigate(['/login']);
      }
    });
  }
}
