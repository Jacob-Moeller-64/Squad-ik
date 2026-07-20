import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';

import {
  AssignRequest,
  AssignResult,
  CreateWorkOrderRequest,
  CreateWorkOrderResult,
  Invoice,
  QuoteRequest,
  QuoteResult,
  Technician,
  WorkOrder
} from '../models';

/** FieldServe API client. Routes and JSON casing are MVC5-style PascalCase. */
@Injectable({ providedIn: 'root' })
export class ApiService {
  private readonly http = inject(HttpClient);

  getWorkOrders(): Observable<WorkOrder[]> {
    return this.http.get<WorkOrder[]>('/WorkOrders/List');
  }

  searchWorkOrders(status: string): Observable<WorkOrder[]> {
    return this.http.get<WorkOrder[]>('/WorkOrders/Search', { params: { status } });
  }

  getWorkOrder(id: string): Observable<WorkOrder> {
    return this.http.get<WorkOrder>('/WorkOrders/Detail/' + encodeURIComponent(id));
  }

  createWorkOrder(request: CreateWorkOrderRequest): Observable<CreateWorkOrderResult> {
    return this.http.post<CreateWorkOrderResult>('/WorkOrders/Create', request);
  }

  getTechnicians(): Observable<Technician[]> {
    return this.http.get<Technician[]>('/Technicians/List');
  }

  assign(request: AssignRequest): Observable<AssignResult> {
    return this.http.post<AssignResult>('/Dispatch/Assign', request);
  }

  quote(request: QuoteRequest): Observable<QuoteResult> {
    return this.http.post<QuoteResult>('/Invoices/Quote', request);
  }

  getRecentInvoices(): Observable<Invoice[]> {
    return this.http.get<Invoice[]>('/Invoices/Recent');
  }
}
