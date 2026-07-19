import { Component, Input } from '@angular/core';

import { OrderResult } from '../../models';

@Component({
  selector: 'app-order-summary',
  templateUrl: './order-summary.component.html',
  styleUrls: ['./order-summary.component.css']
})
export class OrderSummaryComponent {
  @Input() result!: OrderResult;
}
