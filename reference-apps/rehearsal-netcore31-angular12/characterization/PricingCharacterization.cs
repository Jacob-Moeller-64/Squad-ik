using System;
using System.Collections.Generic;
using LegacyShop.Library.Models;
using LegacyShop.Library.Services;
using Xunit;

namespace LegacyShop.Characterization
{
    // Pins what the legacy code DOES — quirks included (kit decision D-001).
    // A surprising assertion is the point: do not "fix" it here.
    public class PricingCharacterization
    {
        private static OrderLine L(int qty, int unit) => new OrderLine { Quantity = qty, UnitPriceCents = unit };
        private readonly PricingService _svc = new PricingService();

        [Fact]
        public void NoDiscountAtOrBelow20000()
            => Assert.Equal(0, _svc.Price(new List<OrderLine> { L(1, 20000) }, "").DiscountPercent);

        [Fact]
        public void FivePercentAbove20000_TruncatesCents()
        {
            var r = _svc.Price(new List<OrderLine> { L(1, 20001) }, "");
            Assert.Equal(5, r.DiscountPercent);
            Assert.Equal(1000, r.DiscountCents); // 20001*5/100 = 1000.05 -> 1000
        }

        [Fact]
        public void TenPercentAbove50000()
            => Assert.Equal(10, _svc.Price(new List<OrderLine> { L(1, 50001) }, "").DiscountPercent);

        [Fact]
        public void Boundary50000IsMidTierNotTop()
            => Assert.Equal(5, _svc.Price(new List<OrderLine> { L(1, 50000) }, "").DiscountPercent);

        [Fact]
        public void VipStacksBelowTopTier()
            => Assert.Equal(20, _svc.Price(new List<OrderLine> { L(5, 4100) }, "VIP").DiscountPercent);

        [Fact]
        public void VipIgnoredAboveTopTierBoundary_LegacyQuirk()
            => Assert.Equal(10, _svc.Price(new List<OrderLine> { L(1, 55000) }, "VIP").DiscountPercent);

        [Fact]
        public void VipAppliesAtExactly50000()
            => Assert.Equal(20, _svc.Price(new List<OrderLine> { L(1, 50000) }, "VIP").DiscountPercent);

        [Fact]
        public void PromoCodeIsCaseSensitive()
            => Assert.Equal(5, _svc.Price(new List<OrderLine> { L(1, 30000) }, "vip").DiscountPercent);

        [Fact]
        public void BulkTwoPercentAtQty10_WithTruncation()
        {
            var r = _svc.Price(new List<OrderLine> { L(10, 12999) }, "");
            Assert.Equal(12, r.DiscountPercent);
            Assert.Equal(15598, r.DiscountCents); // 129990*12/100 = 15598.8 -> 15598
        }

        [Fact]
        public void EmptyOrZeroQuantityRejected()
        {
            Assert.Throws<ArgumentException>(() => _svc.Price(new List<OrderLine>(), ""));
            Assert.Throws<ArgumentException>(() => _svc.Price(new List<OrderLine> { L(0, 100) }, ""));
        }
    }
}
