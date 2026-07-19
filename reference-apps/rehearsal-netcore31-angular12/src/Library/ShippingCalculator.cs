using System.Collections.Generic;
using LegacyShop.Library.Models;

namespace LegacyShop.Library.Services
{
    // Shipping rules accreted 2017-2020. Three quirks, all pinned by characterization:
    //  1. The free-shipping threshold is checked against the PRE-discount subtotal.
    //  2. Oversize handling (unit price > 50000) is charged PER LINE, not per unit.
    //  3. Free shipping waives only base+region; oversize handling still applies.
    public class ShippingCalculator
    {
        private const int BaseCents = 999;
        private const int EuSurchargeCents = 500;
        private const int OversizeHandlingCents = 1500;
        private const int FreeShippingThresholdCents = 75000;
        private const int OversizeUnitPriceCents = 50000;

        public int Calculate(IList<OrderLine> lines, string region, int preDiscountSubtotalCents)
        {
            int handling = 0;
            foreach (var line in lines)
            {
                if (line.UnitPriceCents > OversizeUnitPriceCents)
                    handling += OversizeHandlingCents; // per line, not per unit
            }

            if (preDiscountSubtotalCents >= FreeShippingThresholdCents)
                return handling; // base + region waived; handling survives

            int shipping = BaseCents;
            if (region == "EU") shipping += EuSurchargeCents;
            return shipping + handling;
        }
    }
}
