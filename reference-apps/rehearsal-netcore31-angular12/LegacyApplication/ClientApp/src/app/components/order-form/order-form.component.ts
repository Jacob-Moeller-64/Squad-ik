import { Component } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';

import { ApiService } from '../../services/api.service';
import { OrderLine, OrderResult } from '../../models';

@Component({
  selector: 'app-order-form',
  templateUrl: './order-form.component.html',
  styleUrls: ['./order-form.component.css']
})
export class OrderFormComponent {
  lines: OrderLine[] = [
    { productId: 1, quantity: 1, unitPriceCents: 0 }
  ];
  promoCode = '';
  region = 'US';
  submitting = false;
  error = '';
  result: OrderResult | null = null;

  constructor(private api: ApiService) { }

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
    }).subscribe(
      result => {
        this.result = result;
        this.submitting = false;
      },
      (err: HttpErrorResponse) => {
        this.submitting = false;
        if (err.error && err.error.error) {
          this.error = err.error.error;
        } else {
          this.error = 'The order could not be placed. Please review your entries and try again.';
        }
      }
    );
  }
}
