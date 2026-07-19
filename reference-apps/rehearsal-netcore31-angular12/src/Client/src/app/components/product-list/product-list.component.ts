import { Component, OnInit, inject } from '@angular/core';

import { Product } from '../../models';
import { ApiService } from '../../services/api.service';
import { ProductCardComponent } from '../product-card/product-card.component';
import { SpinnerComponent } from '../spinner/spinner.component';

@Component({
  selector: 'app-product-list',
  standalone: true,
  imports: [ProductCardComponent, SpinnerComponent],
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {
  private readonly api = inject(ApiService);

  products: Product[] = [];
  loading = false;
  error = '';

  ngOnInit(): void {
    this.loading = true;
    this.api.getProducts().subscribe({
      next: products => {
        this.products = products;
        this.loading = false;
      },
      error: () => {
        this.error = 'Failed to load the product catalog. Please try again later.';
        this.loading = false;
      }
    });
  }
}
