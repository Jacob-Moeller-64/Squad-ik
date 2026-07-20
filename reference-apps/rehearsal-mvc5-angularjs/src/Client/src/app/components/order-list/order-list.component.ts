import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { CreateWorkOrderResult, WorkOrder, apiError } from '../../models';
import { ApiService } from '../../services/api.service';
import { OrderCardComponent } from '../order-card/order-card.component';

@Component({
  selector: 'app-order-list',
  standalone: true,
  imports: [FormsModule, OrderCardComponent],
  templateUrl: './order-list.component.html',
  styleUrls: ['./order-list.component.css']
})
export class OrderListComponent implements OnInit {
  private readonly api = inject(ApiService);

  loading = true;
  error: string | null = null;
  orders: WorkOrder[] = [];
  statusFilter = '';
  readonly statuses = ['Open', 'InProgress', 'Closed'];

  // Inline "new work order" panel (exercises /WorkOrders/Create + SlaCalculator).
  newOrder = { Title: '', Priority: 'Normal', ContractTier: 'Standard', Weekend: false };
  readonly priorities = ['Critical', 'High', 'Normal', 'Low'];
  readonly tiers = ['Standard', 'Gold'];
  created: CreateWorkOrderResult | null = null;
  createError: string | null = null;

  ngOnInit(): void {
    this.load();
  }

  reload(): void {
    this.load();
  }

  create(): void {
    this.created = null;
    this.createError = null;
    this.api.createWorkOrder({
      Title: this.newOrder.Title,
      Priority: this.newOrder.Priority,
      ContractTier: this.newOrder.ContractTier,
      Weekend: this.newOrder.Weekend
    }).subscribe({
      next: result => {
        this.created = result; // { WorkOrderId, Title, Priority, DueInHours }
      },
      error: err => {
        this.createError = apiError(err, 'Create failed');
      }
    });
  }

  private load(): void {
    this.loading = true;
    this.error = null;
    const request = this.statusFilter
      ? this.api.searchWorkOrders(this.statusFilter)
      : this.api.getWorkOrders();
    request.subscribe({
      next: orders => {
        this.orders = orders;
        this.loading = false;
      },
      error: () => {
        this.error = 'Could not load work orders';
        this.loading = false;
      }
    });
  }
}
