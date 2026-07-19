import { HttpErrorResponse } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { OrderLine, OrderResult } from '../../models';
import { ApiService } from '../../services/api.service';
import { OrderSummaryComponent } from '../order-summary/order-summary.component';
import { SpinnerComponent } from '../spinner/spinner.component';

@Component({
  selector: 'app-order-form',
  standalone: true,
  imports: [FormsModule, OrderSummaryComponent, SpinnerComponent],
  templateUrl: './order-form.component.html',
  styleUrls: ['./order-form.component.css']
})
export class OrderFormComponent {
  private readonly api = inject(ApiService);

  lines: OrderLine[] = [
    { productId: 1, quantity: 1, unitPriceCents: 0 }
  ];
  promoCode = '';
  region = 'US';
  submitting = false;
  error = '';
  result: OrderResult | null = null;

  addLine(): void {
    this.lines.push({ productId: 1, quantity: 1, unitPriceCents: 0 });
  }

  removeLine(index: number): void {
    if (this.lines.length > 1) {
      this.lines.splice(index, 1);
    }
  }

  onSubmit(): void {
    this.error = '';
    this.result = null;
    this.submitting = true;
    this.api.placeOrder({
      lines: this.lines,
      promoCode: this.promoCode,
      shipTo: { region: this.region }
    }).subscribe({
      next: result => {
        this.result = result;
        this.submitting = false;
      },
      error: (err: HttpErrorResponse) => {
        this.submitting = false;
        if (err.error && err.error.error) {
          this.error = err.error.error;
        } else {
          this.error = 'The order could not be placed. Please review your entries and try again.';
        }
      }
    });
  }
}
