using System;
using System.Collections.Generic;
using FieldServe.Models;

namespace FieldServe.Services
{
    // Billing rules ported from a 2009 VB6 tool, quirks and all. The travel-waiver
    // ordering (labor only, parts ignored) and the untaxed travel are load-bearing
    // legacy behavior: finance reconciles against these exact numbers, so
    // characterization tests must pin them as-is. Do NOT "fix" the ordering.
    public class InvoiceCalculator
    {
        public InvoiceQuote Quote(int laborHours, int hourlyRateCents, IList<int> partsCents, int visits)
        {
            if (laborHours <= 0) throw new ArgumentException("bad labor hours");
            if (visits <= 0) throw new ArgumentException("bad visits");

            int labor = laborHours * hourlyRateCents;

            // Quirk: the travel waiver is checked against LABOR ONLY, and it is
            // decided BEFORE parts are summed. A quote with tiny labor and huge
            // parts still pays travel; big-labor jobs never do.
            int travel = 2500 * visits;
            if (labor > 50000) travel = 0; // waived entirely

            int parts = 0;
            if (partsCents != null)
            {
                foreach (var p in partsCents) parts += p;
            }

            // Quirk: travel was never added to the tax base (a 2011 "temporary"
            // workaround for a county tax dispute that became permanent).
            // Integer division truncates the tax.
            int tax = (labor + parts) * 8 / 100; // int division: truncates

            return new InvoiceQuote
            {
                LaborCents = labor,
                PartsCents = parts,
                TravelCents = travel,
                TaxCents = tax,
                TotalCents = labor + parts + travel + tax
            };
        }
    }
}
