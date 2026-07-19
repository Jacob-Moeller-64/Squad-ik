import { Pipe, PipeTransform } from '@angular/core';

/**
 * Transforms an integer number of cents into a US dollar string,
 * e.g. 123456 -> "$1,234.56".
 */
@Pipe({ name: 'cents' })
export class CentsPipe implements PipeTransform {
  transform(value: number | null | undefined): string {
    if (value === null || value === undefined || isNaN(value)) {
      return '$0.00';
    }
    const rounded = Math.round(value);
    const negative = rounded < 0;
    const abs = Math.abs(rounded);
    const dollars = Math.floor(abs / 100);
    const cents = abs % 100;
    const dollarsStr = dollars.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    const centsStr = cents < 10 ? '0' + cents.toString() : cents.toString();
    return (negative ? '-$' : '$') + dollarsStr + '.' + centsStr;
  }
}
