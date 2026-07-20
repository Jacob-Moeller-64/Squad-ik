#!/usr/bin/env python3
"""Characterization suite for FieldServe's legacy services (step-04, D-001).

Pins what the code DOES — quirks included. Runs against the harness's
behavior-identical ports (harness/logic.py) on Linux; on Windows the same assertions
belong in an MSTest/xUnit project against Services/*.cs.
Run via run-characterization.sh / .ps1 (produces artifacts/coverage/coverage.xml).
"""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "harness"))
import logic  # noqa: E402


class SlaCharacterization(unittest.TestCase):
    def test_base_hours(self):
        self.assertEqual(logic.due_in_hours("Critical", "", False), 4)
        self.assertEqual(logic.due_in_hours("High", "", False), 8)
        self.assertEqual(logic.due_in_hours("Normal", "", False), 24)
        self.assertEqual(logic.due_in_hours("Low", "", False), 72)

    def test_weekend_applied_before_gold_halving_quirk(self):
        # High: (8+24)//2 = 16 — weekend first, THEN halve.
        self.assertEqual(logic.due_in_hours("High", "Gold", True), 16)

    def test_gold_halving_skipped_for_critical_quirk(self):
        # Critical never got the Gold halving: 4+24 = 28, NOT 14.
        self.assertEqual(logic.due_in_hours("Critical", "Gold", True), 28)
        self.assertEqual(logic.due_in_hours("Critical", "Gold", False), 4)

    def test_gold_int_division_truncates(self):
        # Low+weekend Gold: (72+24)//2 = 48; Normal no weekend: 24//2 = 12.
        self.assertEqual(logic.due_in_hours("Low", "Gold", True), 48)
        self.assertEqual(logic.due_in_hours("Normal", "Gold", False), 12)

    def test_bad_priority_rejected(self):
        with self.assertRaises(ValueError):
            logic.due_in_hours("Whenever", "", False)


class InvoiceCharacterization(unittest.TestCase):
    def test_travel_waiver_checks_labor_only_quirk(self):
        # Labor 60000 > 50000 -> travel waived even though quote includes parts.
        q = logic.quote(6, 10000, [3000], 2)
        self.assertEqual(q["TravelCents"], 0)
        self.assertEqual(q["TaxCents"], 5040)  # (60000+3000)*8//100
        self.assertEqual(q["TotalCents"], 68040)

    def test_labor_at_exactly_50000_still_charged_travel(self):
        q = logic.quote(5, 10000, [], 1)
        self.assertEqual(q["TravelCents"], 2500)  # strict >, so 50000 pays travel

    def test_travel_never_taxed_quirk(self):
        q = logic.quote(2, 10000, [1500, 2500], 2)
        self.assertEqual(q["TravelCents"], 5000)
        self.assertEqual(q["TaxCents"], 1920)  # (20000+4000)*8//100 — travel excluded
        self.assertEqual(q["TotalCents"], 30920)

    def test_tax_truncates(self):
        q = logic.quote(1, 101, [], 1)  # labor 101, tax 101*8//100 = 8.08 -> 8
        self.assertEqual(q["TaxCents"], 8)

    def test_rejections(self):
        with self.assertRaises(ValueError):
            logic.quote(0, 10000, [], 1)
        with self.assertRaises(ValueError):
            logic.quote(2, 10000, [], 0)


class DispatchCharacterization(unittest.TestCase):
    def setUp(self):
        self.assignments = logic.seed_assignments()

    def test_unknown_technician_rejected(self):
        with self.assertRaises(ValueError):
            logic.assign(self.assignments, "WO-1006", 42)

    def test_over_capacity_at_three_active(self):
        with self.assertRaises(RuntimeError):
            logic.assign(self.assignments, "WO-1006", 3)  # tech 3 seeded at 3 active

    def test_reassignment_silently_overwrites_quirk(self):
        # WO-1003 is already tech 3's: re-assigning it does NOT trip capacity.
        load = logic.assign(self.assignments, "WO-1003", 3)
        self.assertEqual(load, 3)

    def test_assign_returns_new_active_load(self):
        load = logic.assign(self.assignments, "WO-1006", 1)  # tech 1 has 1 seeded
        self.assertEqual(load, 2)

    def test_reassignment_across_technicians(self):
        # Moving tech 3's order to tech 1 frees tech 3.
        logic.assign(self.assignments, "WO-1003", 1)
        load = logic.assign(self.assignments, "WO-1006", 3)  # now only 2 active
        self.assertEqual(load, 3)


if __name__ == "__main__":
    unittest.main()
