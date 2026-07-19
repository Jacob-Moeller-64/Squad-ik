import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';

import {
  LoginResult,
  OrderHistoryItem,
  OrderRequest,
  OrderResult,
  Product
} from '../models';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private readonly http = inject(HttpClient);

  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>('/api/products', { withCredentials: true });
  }

  searchProducts(q: string): Observable<Product[]> {
    return this.http.get<Product[]>('/api/products/search', {
      params: { q },
      withCredentials: true
    });
  }

  getProduct(id: number | string): Observable<Product> {
    return this.http.get<Product>('/api/products/' + id, { withCredentials: true });
  }

  placeOrder(request: OrderRequest): Observable<OrderResult> {
    return this.http.post<OrderResult>('/api/orders', request, { withCredentials: true });
  }

  getOrderHistory(): Observable<OrderHistoryItem[]> {
    return this.http.get<OrderHistoryItem[]>('/api/orders/history', { withCredentials: true });
  }

  login(username: string, password: string): Observable<LoginResult> {
    return this.http.post<LoginResult>(
      '/api/account/login',
      { username, password },
      { withCredentials: true }
    );
  }

  logout(): Observable<void> {
    return this.http.post<void>('/api/account/logout', {}, { withCredentials: true });
  }
}
