import { DatePipe } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';

import { OrderHistoryItem } from '../../models';
import { CentsPipe } from '../../pipes/cents.pipe';
import { ApiService } from '../../services/api.service';
import { SpinnerComponent } from '../spinner/spinner.component';

@Component({
  selector: 'app-order-history',
  standalone: true,
  imports: [DatePipe, CentsPipe, SpinnerComponent],
  templateUrl: './order-history.component.html',
  styleUrls: ['./order-history.component.css']
})
export class OrderHistoryComponent implements OnInit {
  private readonly api = inject(ApiService);

  orders: OrderHistoryItem[] = [];
  loading = false;
  error = '';

  ngOnInit(): void {
    this.loading = true;
    this.api.getOrderHistory().subscribe({
      next: orders => {
        this.orders = orders;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load your order history.';
        this.loading = false;
      }
    });
  }
}
