#!/usr/bin/env python3
"""Characterization suite for PricingService (step-04 reference implementation).

These tests pin what the legacy code DOES — quirks and all (D-001). They run against
the harness's behavior-identical port on Linux eval machines; on Windows the same
assertions belong in an MSTest/xUnit project against Services/PricingService.cs itself.
If any assertion surprises you, that is the point: do not "fix" it here — a behavior
change requires a decisions.md entry.

Run via run-characterization.sh / .ps1 (produces artifacts/coverage/coverage.xml).
"""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "harness"))
from pricing import price  # noqa: E402


def line(qty, unit):
    return {"Quantity": qty, "UnitPriceCents": unit}


class TierDiscounts(unittest.TestCase):
    def test_no_discount_at_or_below_20000(self):
        self.assertEqual(price([line(1, 20000)], "")["discountPercent"], 0)

    def test_five_percent_above_20000(self):
        r = price([line(1, 20001)], "")
        self.assertEqual(r["discountPercent"], 5)
        self.assertEqual(r["discountCents"], 1000)  # 20001*5//100 truncates

    def test_ten_percent_above_50000(self):
        self.assertEqual(price([line(1, 50001)], "")["discountPercent"], 10)

    def test_boundary_50000_is_mid_tier_not_top(self):
        # Legacy uses strict >50000: exactly 50000 gets 5%, not 10%.
        self.assertEqual(price([line(1, 50000)], "")["discountPercent"], 5)


class VipQuirk(unittest.TestCase):
    def test_vip_stacks_below_top_tier(self):
        # 20500 -> tier 5 + VIP 15 = 20
        self.assertEqual(price([line(5, 4100)], "VIP")["discountPercent"], 20)

    def test_vip_ignored_above_top_tier_boundary(self):
        # Legacy quirk: VIP silently dropped when subtotal > 50000. Pinned, not fixed.
        self.assertEqual(price([line(1, 55000)], "VIP")["discountPercent"], 10)

    def test_vip_applies_at_exactly_50000(self):
        # <= boundary keeps VIP: 5 (tier) + 15 = 20.
        self.assertEqual(price([line(1, 50000)], "VIP")["discountPercent"], 20)

    def test_non_vip_code_is_inert(self):
        self.assertEqual(price([line(1, 30000)], "vip")["discountPercent"], 5)  # case-sensitive


class BulkAndTruncation(unittest.TestCase):
    def test_bulk_two_percent_at_qty_10(self):
        r = price([line(10, 12999)], "")
        self.assertEqual(r["discountPercent"], 12)  # tier 10 + bulk 2
        self.assertEqual(r["discountCents"], 15598)  # 129990*12//100 = 15598.8 -> 15598
        self.assertEqual(r["totalCents"], 114392)

    def test_no_bulk_at_qty_9(self):
        self.assertEqual(price([line(9, 1000)], "")["discountPercent"], 0)

    def test_truncation_drops_fractional_cents(self):
        r = price([line(10, 3333)], "")  # 33330 * 7% = 2333.1
        self.assertEqual(r["discountPercent"], 7)
        self.assertEqual(r["discountCents"], 2333)


class Rejections(unittest.TestCase):
    def test_empty_order_rejected(self):
        with self.assertRaises(ValueError):
            price([], "")

    def test_zero_quantity_rejected(self):
        with self.assertRaises(ValueError):
            price([line(0, 100)], "")

    def test_negative_quantity_rejected(self):
        with self.assertRaises(ValueError):
            price([line(-1, 100)], "")


if __name__ == "__main__":
    unittest.main()
