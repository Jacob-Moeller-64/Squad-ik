using System.Collections.Generic;
using LegacyShop.Library.Models;
using LegacyShop.Library.Services;
using Xunit;

namespace LegacyShop.Characterization
{
    public class ShippingCharacterization
    {
        private static OrderLine L(int qty, int unit) => new OrderLine { Quantity = qty, UnitPriceCents = unit };
        private readonly ShippingCalculator _svc = new ShippingCalculator();

        [Fact]
        public void BaseRateUs()
            => Assert.Equal(999, _svc.Calculate(new List<OrderLine> { L(1, 1000) }, "US", 1000));

        [Fact]
        public void EuSurcharge()
            => Assert.Equal(1499, _svc.Calculate(new List<OrderLine> { L(1, 1000) }, "EU", 1000));

        [Fact]
        public void FreeShippingUsesPreDiscountSubtotal_LegacyQuirk()
        {
            // 75000 pre-discount qualifies even though the customer may pay less after discount.
            Assert.Equal(0, _svc.Calculate(new List<OrderLine> { L(3, 25000) }, "US", 75000));
        }

        [Fact]
        public void OversizeHandlingIsPerLineNotPerUnit_LegacyQuirk()
        {
            // Two oversize units on ONE line: one 1500 charge, not two.
            Assert.Equal(999 + 1500, _svc.Calculate(new List<OrderLine> { L(2, 55000) }, "US", 1000));
            // Same units split across TWO lines: two charges.
            Assert.Equal(999 + 3000, _svc.Calculate(
                new List<OrderLine> { L(1, 55000), L(1, 55000) }, "US", 1000));
        }

        [Fact]
        public void FreeShippingWaivesBaseAndRegionButNotHandling_LegacyQuirk()
        {
            // Oversize handling survives free shipping.
            Assert.Equal(1500, _svc.Calculate(new List<OrderLine> { L(1, 89900) }, "EU", 89900));
        }

        [Fact]
        public void ExactThresholdQualifiesForFree()
            => Assert.Equal(0, _svc.Calculate(new List<OrderLine> { L(1, 30000) }, "US", 75000));
    }
}
