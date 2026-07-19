namespace LegacyApplication.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public int UnitPriceCents { get; set; }
        public bool InStock { get; set; }
    }

    public class OrderLine
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public int UnitPriceCents { get; set; }
    }

    public class PricingResult
    {
        public int SubtotalCents { get; set; }
        public int DiscountPercent { get; set; }
        public int DiscountCents { get; set; }
        public int TotalCents { get; set; }
    }
}
