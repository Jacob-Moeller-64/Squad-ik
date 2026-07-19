import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';

import { Product } from '../../models';
import { CentsPipe } from '../../pipes/cents.pipe';
import { ApiService } from '../../services/api.service';
import { SpinnerComponent } from '../spinner/spinner.component';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [RouterLink, CentsPipe, SpinnerComponent],
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.css']
})
export class ProductDetailComponent implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly api = inject(ApiService);

  product: Product | null = null;
  loading = false;
  error = '';

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (!id) {
      this.error = 'Product not found.';
      return;
    }
    this.loading = true;
    this.api.getProduct(id).subscribe({
      next: product => {
        this.product = product;
        this.loading = false;
      },
      error: (err: HttpErrorResponse) => {
        this.loading = false;
        if (err.error && err.error.error) {
          this.error = err.error.error;
        } else {
          this.error = 'Product not found.';
        }
      }
    });
  }
}
