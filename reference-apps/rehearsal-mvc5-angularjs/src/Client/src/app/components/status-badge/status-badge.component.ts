import { Component, input } from '@angular/core';

/**
 * Port of the legacy statusBadge directive: status -> colored badge class.
 * Selector kept as the legacy element name so the DOM matches verbatim.
 */
@Component({
  selector: 'status-badge',
  standalone: true,
  templateUrl: './status-badge.component.html',
  styleUrls: ['./status-badge.component.css']
})
export class StatusBadgeComponent {
  readonly status = input.required<string>();
}
