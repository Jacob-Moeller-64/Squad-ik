import { Component, input } from '@angular/core';

import { QuoteResult } from '../../models';
import { MoneyCentsPipe } from '../../pipes/money-cents.pipe';

/**
 * Port of the legacy quoteSummary .component() (one-way binding). Selector kept
 * as the legacy element name so the DOM matches verbatim. result is the
 * PascalCase /Invoices/Quote payload; hidden while null.
 */
@Component({
  selector: 'quote-summary',
  standalone: true,
  imports: [MoneyCentsPipe],
  templateUrl: './quote-summary.component.html',
  styleUrls: ['./quote-summary.component.css']
})
export class QuoteSummaryComponent {
  readonly result = input<QuoteResult | null>(null);
}
