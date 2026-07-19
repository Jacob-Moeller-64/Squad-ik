import { Component, OnInit } from '@angular/core';

import { ApiService } from '../../services/api.service';
import { Product } from '../../models';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {
  products: Product[] = [];
  loading = false;
  error = '';

  constructor(private api: ApiService) { }

  ngOnInit(): void {
    this.loading = true;
    this.api.getProducts().subscribe(
      products => {
        this.products = products;
        this.loading = false;
      },
      () => {
        this.error = 'Failed to load the product catalog. Please try again later.';
        this.loading = false;
      }
    );
  }
}
