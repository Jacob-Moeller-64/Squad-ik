import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AssignResult, Technician, WorkOrder, apiError } from '../../models';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-dispatch',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './dispatch.component.html',
  styleUrls: ['./dispatch.component.css']
})
export class DispatchComponent implements OnInit {
  private readonly api = inject(ApiService);

  orders: WorkOrder[] = [];
  technicians: Technician[] = [];
  form = { workOrderId: '', technicianId: '' };
  result: AssignResult | null = null;
  error: string | null = null;

  ngOnInit(): void {
    this.api.getWorkOrders().subscribe(orders => (this.orders = orders));
    this.api.getTechnicians().subscribe(technicians => (this.technicians = technicians));
  }

  assign(): void {
    this.result = null;
    this.error = null;
    this.api.assign({
      WorkOrderId: this.form.workOrderId,
      TechnicianId: parseInt(this.form.technicianId, 10)
    }).subscribe({
      next: result => {
        this.result = result; // { TechnicianId, WorkOrderId, ActiveLoad }
      },
      error: err => {
        this.error = apiError(err, 'Assignment failed');
      }
    });
  }
}
