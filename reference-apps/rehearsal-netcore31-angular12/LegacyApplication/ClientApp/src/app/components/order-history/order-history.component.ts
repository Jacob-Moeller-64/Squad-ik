import { Component, OnInit } from '@angular/core';

import { ApiService } from '../../services/api.service';
import { OrderHistoryItem } from '../../models';

@Component({
  selector: 'app-order-history',
  templateUrl: './order-history.component.html',
  styleUrls: ['./order-history.component.css']
})
export class OrderHistoryComponent implements OnInit {
  orders: OrderHistoryItem[] = [];
  loading = false;
  error = '';

  constructor(private api: ApiService) { }

  ngOnInit(): void {
    this.loading = true;
    this.api.getOrderHistory().subscribe(
      orders => {
        this.orders = orders;
        this.loading = false;
      },
      () => {
        this.error = 'Failed to load your order history.';
        this.loading = false;
      }
    );
  }
}
