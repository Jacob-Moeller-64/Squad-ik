using System.Collections.Generic;
using System.Linq;
using FieldServe.Models;

namespace FieldServe.Data
{
    // In-memory stand-in for the legacy database; keep in sync with harness/logic.py.
    // Static mutable state (Assignments) is itself a seeded statelessness hazard.
    public static class Repo
    {
        public static readonly List<WorkOrder> WorkOrders = new List<WorkOrder>
        {
            new WorkOrder { Id = "WO-1001", Title = "Rooftop HVAC compressor failure", Status = "Open",       Priority = "Critical", Site = "Northside Mall" },
            new WorkOrder { Id = "WO-1002", Title = "Quarterly boiler inspection",     Status = "InProgress", Priority = "Normal",   Site = "Lakeview Plant" },
            new WorkOrder { Id = "WO-1003", Title = "Walk-in freezer temp alarm",      Status = "InProgress", Priority = "High",     Site = "Harborside Grocery" },
            new WorkOrder { Id = "WO-1004", Title = "Parking lot light bank out",      Status = "InProgress", Priority = "Low",      Site = "Eastgate Office Park" },
            new WorkOrder { Id = "WO-1005", Title = "Backup generator fuel leak",      Status = "InProgress", Priority = "Critical", Site = "Riverbend Hospital" },
            new WorkOrder { Id = "WO-1006", Title = "Replace lobby thermostat",        Status = "Closed",     Priority = "Low",      Site = "Summit Tower" },
        };

        public static readonly List<Technician> Technicians = new List<Technician>
        {
            new Technician { Id = 1, Name = "Dana Whitfield", Skill = "HVAC",          Region = "North" },
            new Technician { Id = 2, Name = "Miguel Ortega",  Skill = "Electrical",    Region = "East" },
            new Technician { Id = 3, Name = "Priya Raman",    Skill = "Refrigeration", Region = "Harbor" },
            new Technician { Id = 4, Name = "Karl Jensen",    Skill = "Plumbing",      Region = "West" },
        };

        // workOrderId -> technicianId. Seeded so technician 3 starts AT the 3-job
        // capacity limit (the next Assign to tech 3 must throw "over capacity").
        public static readonly Dictionary<string, int> Assignments = new Dictionary<string, int>
        {
            { "WO-1002", 1 },
            { "WO-1003", 3 },
            { "WO-1004", 3 },
            { "WO-1005", 3 },
        };

        // Fixed seed data behind the [Authorize]-protected /Invoices/Recent.
        public static readonly List<Invoice> Invoices = new List<Invoice>
        {
            new Invoice { InvoiceId = "INV-2018-0412", IssuedAt = "2018-03-14T00:00:00", TotalCents = 187425 },
            new Invoice { InvoiceId = "INV-2018-0505", IssuedAt = "2018-06-02T00:00:00", TotalCents =  96200 },
        };

        public static WorkOrder FindWorkOrder(string id)
        {
            return WorkOrders.FirstOrDefault(w => w.Id == id);
        }

        public static Technician FindTechnician(int id)
        {
            return Technicians.FirstOrDefault(t => t.Id == id);
        }
    }
}
