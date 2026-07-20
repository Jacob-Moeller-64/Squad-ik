import { Routes } from '@angular/router';

import { DispatchComponent } from './components/dispatch/dispatch.component';
import { InvoicesComponent } from './components/invoices/invoices.component';
import { LoginComponent } from './components/login/login.component';
import { OrderDetailComponent } from './components/order-detail/order-detail.component';
import { OrderListComponent } from './components/order-list/order-list.component';
import { QuoteComponent } from './components/quote/quote.component';
import { authGuard } from './guards/auth.guard';

export const routes: Routes = [
  { path: 'orders', component: OrderListComponent },
  { path: 'orders/:id', component: OrderDetailComponent },
  { path: 'dispatch', component: DispatchComponent },
  { path: 'quote', component: QuoteComponent },
  { path: 'invoices', component: InvoicesComponent, canActivate: [authGuard] },
  { path: 'login', component: LoginComponent },
  { path: '', redirectTo: '/orders', pathMatch: 'full' },
  { path: '**', redirectTo: '/orders' }
];
