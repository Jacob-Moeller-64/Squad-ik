using System;
using LegacyShop.Library.Data;
using LegacyShop.Library.Services;
using Xunit;

namespace LegacyShop.Characterization
{
    public class InventoryCharacterization : IDisposable
    {
        private readonly InventoryAllocator _svc = new InventoryAllocator();

        public InventoryCharacterization() => Repo.Allocations.Clear();
        public void Dispose() => Repo.Allocations.Clear();

        [Fact]
        public void AllocatesUpToAvailable_SilentPartial_LegacyQuirk()
        {
            // Giant Magnet stock = 3: ask for 5, silently get 3 + 2 backordered. No error.
            var (allocated, backordered) = _svc.Allocate(4, 5);
            Assert.Equal(3, allocated);
            Assert.Equal(2, backordered);
        }

        [Fact]
        public void SecondAllocationSeesReducedAvailability()
        {
            _svc.Allocate(1, 30); // Anvil stock 40
            var (allocated, backordered) = _svc.Allocate(1, 30);
            Assert.Equal(10, allocated);
            Assert.Equal(20, backordered);
        }

        [Fact]
        public void BulkDeskRejectsOver100_LegacyQuirk()
        {
            var ex = Assert.Throws<InvalidOperationException>(() => _svc.Allocate(8, 101));
            Assert.Equal("bulk desk", ex.Message);
        }

        [Fact]
        public void Exactly100IsAllowed()
        {
            var (allocated, backordered) = _svc.Allocate(8, 100); // Iron Bird Seed stock 400
            Assert.Equal(100, allocated);
            Assert.Equal(0, backordered);
        }

        [Fact]
        public void BadInputsRejected()
        {
            Assert.Throws<ArgumentException>(() => _svc.Allocate(1, 0));
            Assert.Throws<ArgumentException>(() => _svc.Allocate(999, 1));
        }
    }
}
