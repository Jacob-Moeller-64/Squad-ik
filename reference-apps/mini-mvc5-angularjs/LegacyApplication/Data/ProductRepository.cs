using System.Collections.Generic;
using System.Linq;
using LegacyApplication.Models;

namespace LegacyApplication.Data
{
    public static class ProductRepository
    {
        // In-memory stand-in for the legacy database; keep in sync with harness/serve.py.
        public static readonly List<Product> Products = new List<Product>
        {
            new Product { Id = 1, Name = "Anvil",        Category = "Hardware", UnitPriceCents = 12999, InStock = true  },
            new Product { Id = 2, Name = "Rocket Skates", Category = "Transport", UnitPriceCents = 24950, InStock = true  },
            new Product { Id = 3, Name = "Bird Seed",    Category = "Supplies", UnitPriceCents =   599, InStock = false },
            new Product { Id = 4, Name = "Giant Magnet", Category = "Hardware", UnitPriceCents = 55000, InStock = true  },
        };

        public static Product Find(int id)
        {
            return Products.FirstOrDefault(p => p.Id == id);
        }
    }
}
