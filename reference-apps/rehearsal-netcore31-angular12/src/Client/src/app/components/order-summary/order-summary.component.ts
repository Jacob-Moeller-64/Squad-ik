import { Component, input } from '@angular/core';

import { OrderResult } from '../../models';
import { CentsPipe } from '../../pipes/cents.pipe';

@Component({
  selector: 'app-order-summary',
  standalone: true,
  imports: [CentsPipe],
  templateUrl: './order-summary.component.html',
  styleUrls: ['./order-summary.component.css']
})
export class OrderSummaryComponent {
  readonly result = input.required<OrderResult>();
}
