using System;
using LegacyShop.Library.Data;

namespace LegacyShop.Library.Services
{
    // Warehouse allocation rules. Quirks pinned by characterization:
    //  1. Requests over 100 units are rejected outright ("bulk desk" policy, 2018).
    //  2. Partial allocation is silent: you get min(requested, available) and the
    //     remainder is reported as backordered — no error.
    public class InventoryAllocator
    {
        public (int allocated, int backordered) Allocate(int productId, int requested)
        {
            if (requested <= 0) throw new ArgumentException("bad quantity");
            if (requested > 100) throw new InvalidOperationException("bulk desk");

            var product = Repo.FindProduct(productId);
            if (product == null) throw new ArgumentException("no such product");

            Repo.Allocations.TryGetValue(productId, out var already);
            int available = product.StockQty - already;
            if (available < 0) available = 0;

            int allocated = Math.Min(requested, available);
            Repo.Allocations[productId] = already + allocated;
            return (allocated, requested - allocated);
        }
    }
}
