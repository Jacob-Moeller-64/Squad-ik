namespace FieldServe.Models
{
    // NOTE: property names are the JSON contract. MVC5 JsonResult serializes them
    // as written (PascalCase); the AngularJS frontend and the Python harness both
    // depend on that casing exactly.

    public class WorkOrder
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Status { get; set; }   // Open | InProgress | Closed
        public string Priority { get; set; } // Critical | High | Normal | Low
        public string Site { get; set; }
    }

    public class Technician
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Skill { get; set; }
        public string Region { get; set; }
    }

    public class Invoice
    {
        public string InvoiceId { get; set; }
        public string IssuedAt { get; set; } // fixed 2018 dates; string keeps the JSON stable
        public int TotalCents { get; set; }
    }

    // POST /WorkOrders/Create request body
    public class CreateWorkOrderRequest
    {
        public string Title { get; set; }
        public string Priority { get; set; }
        public string ContractTier { get; set; } // "Gold" triggers the SLA halving quirk
        public bool Weekend { get; set; }
    }

    // POST /Dispatch/Assign request body
    public class AssignRequest
    {
        public string WorkOrderId { get; set; }
        public int TechnicianId { get; set; }
    }

    // POST /Invoices/Quote request body
    public class QuoteRequest
    {
        public int LaborHours { get; set; }
        public int HourlyRateCents { get; set; }
        public int[] PartsCents { get; set; }
        public int Visits { get; set; }
    }

    public class InvoiceQuote
    {
        public int LaborCents { get; set; }
        public int PartsCents { get; set; }
        public int TravelCents { get; set; }
        public int TaxCents { get; set; }
        public int TotalCents { get; set; }
    }
}
