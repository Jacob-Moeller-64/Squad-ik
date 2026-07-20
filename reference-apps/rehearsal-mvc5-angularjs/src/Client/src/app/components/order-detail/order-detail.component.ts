import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';

import { WorkOrder } from '../../models';
import { ApiService } from '../../services/api.service';
import { StatusBadgeComponent } from '../status-badge/status-badge.component';

@Component({
  selector: 'app-order-detail',
  standalone: true,
  imports: [RouterLink, StatusBadgeComponent],
  templateUrl: './order-detail.component.html',
  styleUrls: ['./order-detail.component.css']
})
export class OrderDetailComponent implements OnInit {
  private readonly api = inject(ApiService);
  private readonly route = inject(ActivatedRoute);

  loading = true;
  error: string | null = null;
  order: WorkOrder | null = null;

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id') ?? '';
    this.api.getWorkOrder(id).subscribe({
      next: order => {
        this.order = order;
        this.loading = false;
      },
      error: () => {
        this.error = 'Work order not found';
        this.loading = false;
      }
    });
  }
}
