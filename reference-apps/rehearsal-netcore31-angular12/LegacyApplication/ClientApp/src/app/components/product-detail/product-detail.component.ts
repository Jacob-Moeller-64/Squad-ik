import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpErrorResponse } from '@angular/common/http';

import { ApiService } from '../../services/api.service';
import { Product } from '../../models';

@Component({
  selector: 'app-product-detail',
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.css']
})
export class ProductDetailComponent implements OnInit {
  product: Product | null = null;
  loading = false;
  error = '';

  constructor(private route: ActivatedRoute, private api: ApiService) { }

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (!id) {
      this.error = 'Product not found.';
      return;
    }
    this.loading = true;
    this.api.getProduct(id).subscribe(
      product => {
        this.product = product;
        this.loading = false;
      },
      (err: HttpErrorResponse) => {
        this.loading = false;
        if (err.error && err.error.error) {
          this.error = err.error.error;
        } else {
          this.error = 'Product not found.';
        }
      }
    );
  }
}
