import { Pipe, PipeTransform } from '@angular/core';

/**
 * moneyCents: integer cents -> "$1,234.56". Exact port of the legacy AngularJS
 * moneyCents filter — all API money fields are integer cents (PascalCase, e.g.
 * TotalCents); nothing in the app uses floats.
 */
@Pipe({ name: 'moneyCents', standalone: true })
export class MoneyCentsPipe implements PipeTransform {
  transform(cents: number | null | undefined): string {
    if (cents === null || cents === undefined || isNaN(cents)) {
      return '';
    }
    const negative = cents < 0;
    const abs = Math.abs(Math.floor(cents));
    const dollars = String(Math.floor(abs / 100)).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    const rem = ('0' + (abs % 100)).slice(-2);
    return (negative ? '-$' : '$') + dollars + '.' + rem;
  }
}
