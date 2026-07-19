using System;
using System.Collections.Generic;
using System.Linq;
using LegacyApplication.Models;

namespace LegacyApplication.Services
{
    // Discount rules accreted over years. The integer truncation and the VIP/tier
    // interaction are load-bearing legacy behavior: characterization tests must pin
    // them exactly as-is (kit decision D-001).
    public class PricingService
    {
        public PricingResult Price(IList<OrderLine> lines, string promoCode)
        {
            if (lines == null || lines.Count == 0)
                throw new ArgumentException("order has no lines");

            int subtotalCents = 0;
            foreach (var line in lines)
            {
                if (line.Quantity <= 0) throw new ArgumentException("bad quantity");
                subtotalCents += line.Quantity * line.UnitPriceCents;
            }

            int pct = 0;
            if (subtotalCents > 50000) pct += 10;
            else if (subtotalCents > 20000) pct += 5;

            if (lines.Any(l => l.Quantity >= 10)) pct += 2;

            // Legacy quirk: VIP was never made stackable with the top tier. Nobody
            // remembers why. Behavior is depended on by finance reports.
            if (promoCode == "VIP" && subtotalCents <= 50000) pct += 15;

            int discountCents = subtotalCents * pct / 100; // int division: truncates
            return new PricingResult
            {
                SubtotalCents = subtotalCents,
                DiscountPercent = pct,
                DiscountCents = discountCents,
                TotalCents = subtotalCents - discountCents
            };
        }
    }
}
