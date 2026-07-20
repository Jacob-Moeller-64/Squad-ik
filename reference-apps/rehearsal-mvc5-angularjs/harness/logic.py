#!/usr/bin/env python3
"""Behavior-identical ports of FieldServe's three legacy services — quirks preserved.

Keep in sync with:
  LegacyApplication/Services/SlaCalculator.cs
  LegacyApplication/Services/InvoiceCalculator.cs
  LegacyApplication/Services/DispatchAllocator.cs
  LegacyApplication/Data/Repo.cs

This is the harness's 'Library layer': characterization suites target this module.
If any of the C# files above change, this must change with it (and goldens
re-captured). C# ArgumentException -> ValueError, InvalidOperationException ->
RuntimeError; the messages match the C# messages exactly.
"""

# ---------------------------------------------------------------------------
# Seed data — keep in sync with Data/Repo.cs (PascalCase: MVC5 JsonResult casing).
# ---------------------------------------------------------------------------

WORK_ORDERS = [
    {"Id": "WO-1001", "Title": "Rooftop HVAC compressor failure", "Status": "Open",       "Priority": "Critical", "Site": "Northside Mall"},
    {"Id": "WO-1002", "Title": "Quarterly boiler inspection",     "Status": "InProgress", "Priority": "Normal",   "Site": "Lakeview Plant"},
    {"Id": "WO-1003", "Title": "Walk-in freezer temp alarm",      "Status": "InProgress", "Priority": "High",     "Site": "Harborside Grocery"},
    {"Id": "WO-1004", "Title": "Parking lot light bank out",      "Status": "InProgress", "Priority": "Low",      "Site": "Eastgate Office Park"},
    {"Id": "WO-1005", "Title": "Backup generator fuel leak",      "Status": "InProgress", "Priority": "Critical", "Site": "Riverbend Hospital"},
    {"Id": "WO-1006", "Title": "Replace lobby thermostat",        "Status": "Closed",     "Priority": "Low",      "Site": "Summit Tower"},
]

TECHNICIANS = [
    {"Id": 1, "Name": "Dana Whitfield", "Skill": "HVAC",          "Region": "North"},
    {"Id": 2, "Name": "Miguel Ortega",  "Skill": "Electrical",    "Region": "East"},
    {"Id": 3, "Name": "Priya Raman",    "Skill": "Refrigeration", "Region": "Harbor"},
    {"Id": 4, "Name": "Karl Jensen",    "Skill": "Plumbing",      "Region": "West"},
]

# workOrderId -> technicianId. Technician 3 is seeded AT the 3-job capacity limit.
def seed_assignments():
    return {"WO-1002": 1, "WO-1003": 3, "WO-1004": 3, "WO-1005": 3}


INVOICES = [
    {"InvoiceId": "INV-2018-0412", "IssuedAt": "2018-03-14T00:00:00", "TotalCents": 187425},
    {"InvoiceId": "INV-2018-0505", "IssuedAt": "2018-06-02T00:00:00", "TotalCents": 96200},
]

MAX_ACTIVE_ASSIGNMENTS = 3
_BASE_HOURS = {"Critical": 4, "High": 8, "Normal": 24, "Low": 72}


# ---------------------------------------------------------------------------
# Services/SlaCalculator.cs
# ---------------------------------------------------------------------------

def due_in_hours(priority, contract_tier, weekend):
    if priority not in _BASE_HOURS:
        raise ValueError("bad priority")  # C# ArgumentException
    hours = _BASE_HOURS[priority]

    # Quirk: weekend padding is applied FIRST, so the Gold halving below acts on
    # the padded number. Order of operations is depended on.
    if weekend:
        hours = hours + 24

    # Quirk: the Gold-tier halving was never implemented for Critical tickets.
    # // mirrors C# int division (truncates).
    if contract_tier == "Gold" and priority != "Critical":
        hours = hours // 2

    return hours


# ---------------------------------------------------------------------------
# Services/InvoiceCalculator.cs
# ---------------------------------------------------------------------------

def quote(labor_hours, hourly_rate_cents, parts_cents, visits):
    if labor_hours <= 0:
        raise ValueError("bad labor hours")  # C# ArgumentException
    if visits <= 0:
        raise ValueError("bad visits")  # C# ArgumentException

    labor = labor_hours * hourly_rate_cents

    # Quirk: the travel waiver is checked against LABOR ONLY, decided before
    # parts are summed. Tiny labor + huge parts still pays travel.
    travel = 2500 * visits
    if labor > 50000:
        travel = 0  # waived entirely

    parts = sum(parts_cents or [])

    # Quirk: travel is NOT in the tax base. // mirrors C# int division (truncates).
    tax = (labor + parts) * 8 // 100

    return {
        "LaborCents": labor,
        "PartsCents": parts,
        "TravelCents": travel,
        "TaxCents": tax,
        "TotalCents": labor + parts + travel + tax,
    }


# ---------------------------------------------------------------------------
# Services/DispatchAllocator.cs
# ---------------------------------------------------------------------------

def assign(assignments, work_order_id, technician_id):
    """Mutates `assignments`; returns the technician's active load AFTER assigning."""
    if not any(t["Id"] == technician_id for t in TECHNICIANS):
        raise ValueError("no such technician")  # C# ArgumentException

    # Quirk: assigning the SAME work order again silently re-assigns it — the
    # dict write below overwrites the old row, so the old slot is excluded from
    # the capacity count (no error, ever).
    active = sum(1 for wo, tech in assignments.items()
                 if tech == technician_id and wo != work_order_id)

    if active >= MAX_ACTIVE_ASSIGNMENTS:
        raise RuntimeError("over capacity")  # C# InvalidOperationException

    assignments[work_order_id] = technician_id
    return active + 1
