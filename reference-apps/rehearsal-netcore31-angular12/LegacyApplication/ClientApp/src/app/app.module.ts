import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavComponent } from './components/nav/nav.component';
import { ProductListComponent } from './components/product-list/product-list.component';
import { ProductCardComponent } from './components/product-card/product-card.component';
import { ProductDetailComponent } from './components/product-detail/product-detail.component';
import { OrderFormComponent } from './components/order-form/order-form.component';
import { OrderSummaryComponent } from './components/order-summary/order-summary.component';
import { OrderHistoryComponent } from './components/order-history/order-history.component';
import { LoginComponent } from './components/login/login.component';
import { SpinnerComponent } from './components/spinner/spinner.component';
import { CentsPipe } from './pipes/cents.pipe';
import { UnauthorizedInterceptor } from './interceptors/unauthorized.interceptor';

@NgModule({
  declarations: [
    AppComponent,
    NavComponent,
    ProductListComponent,
    ProductCardComponent,
    ProductDetailComponent,
    OrderFormComponent,
    OrderSummaryComponent,
    OrderHistoryComponent,
    LoginComponent,
    SpinnerComponent,
    CentsPipe
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [
    { provide: HTTP_INTERCEPTORS, useClass: UnauthorizedInterceptor, multi: true }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
