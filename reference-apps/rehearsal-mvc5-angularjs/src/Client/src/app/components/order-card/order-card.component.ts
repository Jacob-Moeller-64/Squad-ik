import { Component, ElementRef, HostListener, inject, input } from '@angular/core';
import { RouterLink } from '@angular/router';

import { StatusBadgeComponent } from '../status-badge/status-badge.component';

/**
 * Port of the legacy orderCard element directive ('@' string bindings plus
 * link-fn DOM fiddling). Selector kept as the legacy element name so the DOM
 * matches verbatim; the jQuery-era hover class toggle is reproduced with host
 * listeners (site.css defines no .hover rule — behavior kept for parity).
 */
@Component({
  selector: 'order-card',
  standalone: true,
  imports: [RouterLink, StatusBadgeComponent],
  templateUrl: './order-card.component.html',
  styleUrls: ['./order-card.component.css']
})
export class OrderCardComponent {
  readonly orderId = input.required<string>();
  readonly title = input.required<string>();
  readonly status = input.required<string>();
  readonly priority = input.required<string>();
  readonly site = input.required<string>();

  private readonly host = inject<ElementRef<HTMLElement>>(ElementRef);

  @HostListener('mouseenter')
  onMouseEnter(): void {
    Array.from(this.host.nativeElement.children).forEach(child => child.classList.add('hover'));
  }

  @HostListener('mouseleave')
  onMouseLeave(): void {
    Array.from(this.host.nativeElement.children).forEach(child => child.classList.remove('hover'));
  }
}
