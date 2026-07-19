using System.Collections.Generic;
using System.Linq;
using LegacyShop.Api.Models;

namespace LegacyShop.Api.Data
{
    // In-memory stand-in for the legacy database. Static mutable state: a seeded
    // statelessness hazard on top of session use.
    public static class Repo
    {
        public static readonly List<Product> Products = new List<Product>
        {
            new Product { Id = 1, Name = "Anvil",         Category = "Hardware",  UnitPriceCents = 12999, InStock = true,  StockQty = 40 },
            new Product { Id = 2, Name = "Rocket Skates", Category = "Transport", UnitPriceCents = 24950, InStock = true,  StockQty = 12 },
            new Product { Id = 3, Name = "Bird Seed",     Category = "Supplies",  UnitPriceCents = 599,   InStock = false, StockQty = 0 },
            new Product { Id = 4, Name = "Giant Magnet",  Category = "Hardware",  UnitPriceCents = 55000, InStock = true,  StockQty = 3 },
            new Product { Id = 5, Name = "Tornado Kit",   Category = "Weather",   UnitPriceCents = 89900, InStock = true,  StockQty = 2 },
            new Product { Id = 6, Name = "Dehydrated Boulders", Category = "Supplies", UnitPriceCents = 4500, InStock = true, StockQty = 120 },
            new Product { Id = 7, Name = "Jet Propelled Unicycle", Category = "Transport", UnitPriceCents = 61250, InStock = true, StockQty = 5 },
            new Product { Id = 8, Name = "Iron Bird Seed", Category = "Supplies", UnitPriceCents = 1299, InStock = true, StockQty = 400 },
        };

        public static readonly List<Customer> Customers = new List<Customer>
        {
            new Customer { Id = 1, Name = "W. E. Coyote",   Region = "US", Tier = "VIP" },
            new Customer { Id = 2, Name = "R. Runner",       Region = "US", Tier = "Standard" },
            new Customer { Id = 3, Name = "Acme EU GmbH",    Region = "EU", Tier = "Standard" },
        };

        public static readonly Dictionary<int, int> Allocations = new Dictionary<int, int>();

        public static readonly List<OrderRecord> OrderHistory = new List<OrderRecord>
        {
            new OrderRecord { OrderId = "hist-0001", PlacedAt = new System.DateTime(2019, 4, 2, 10, 30, 0, System.DateTimeKind.Utc), TotalCents = 49500 },
            new OrderRecord { OrderId = "hist-0002", PlacedAt = new System.DateTime(2019, 4, 9, 14, 5, 0, System.DateTimeKind.Utc),  TotalCents = 16400 },
        };

        public static Product FindProduct(int id) => Products.FirstOrDefault(p => p.Id == id);
    }
}
