using System;
using System.Collections.Generic;

namespace LegacyShop.Library.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public int UnitPriceCents { get; set; }
        public bool InStock { get; set; }
        public int StockQty { get; set; }
    }

    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Region { get; set; }
        public string Tier { get; set; }
    }

    public class OrderLine
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public int UnitPriceCents { get; set; }
    }

    public class ShipTo
    {
        public string Region { get; set; }
    }

    public class OrderRequest
    {
        public List<OrderLine> Lines { get; set; }
        public string PromoCode { get; set; }
        public ShipTo ShipTo { get; set; }
    }

    public class PricingResult
    {
        public int SubtotalCents { get; set; }
        public int DiscountPercent { get; set; }
        public int DiscountCents { get; set; }
    }

    public class OrderRecord
    {
        public string OrderId { get; set; }
        public DateTime PlacedAt { get; set; }
        public int TotalCents { get; set; }
    }

    public class AllocationRequest
    {
        public int ProductId { get; set; }
        public int Qty { get; set; }
    }
}
