import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { QuoteResult, apiError } from '../../models';
import { ApiService } from '../../services/api.service';
import { QuoteSummaryComponent } from '../quote-summary/quote-summary.component';

@Component({
  selector: 'app-quote',
  standalone: true,
  imports: [FormsModule, QuoteSummaryComponent],
  templateUrl: './quote.component.html',
  styleUrls: ['./quote.component.css']
})
export class QuoteComponent {
  private readonly api = inject(ApiService);

  laborHours = 2;
  hourlyRateCents = 9500;
  parts: { cents: number }[] = [{ cents: 0 }];
  visits = 1;
  result: QuoteResult | null = null;
  error: string | null = null;

  addPart(): void {
    this.parts.push({ cents: 0 });
  }

  removePart(index: number): void {
    this.parts.splice(index, 1);
  }

  submit(): void {
    this.result = null;
    this.error = null;
    this.api.quote({
      LaborHours: this.laborHours,
      HourlyRateCents: this.hourlyRateCents,
      PartsCents: this.parts.map(p => parseInt(String(p.cents), 10) || 0),
      Visits: this.visits
    }).subscribe({
      next: result => {
        this.result = result; // { LaborCents, PartsCents, TravelCents, TaxCents, TotalCents }
      },
      error: err => {
        this.error = apiError(err, 'Quote failed');
      }
    });
  }
}
