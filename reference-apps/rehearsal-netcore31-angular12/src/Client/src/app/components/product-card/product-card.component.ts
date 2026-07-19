import { Component, input } from '@angular/core';
import { RouterLink } from '@angular/router';

import { Product } from '../../models';
import { CentsPipe } from '../../pipes/cents.pipe';

@Component({
  selector: 'app-product-card',
  standalone: true,
  imports: [RouterLink, CentsPipe],
  templateUrl: './product-card.component.html',
  styleUrls: ['./product-card.component.css']
})
export class ProductCardComponent {
  readonly product = input.required<Product>();
}
