#!/usr/bin/env python3
"""Behavior-identical port of Services/PricingService.cs — quirks preserved exactly.

This is the harness's 'Library layer': the characterization suite targets this module
and its branch coverage feeds the scorecard's test-coverage dimension. If
PricingService.cs changes, this must change with it (and the goldens re-captured).
"""


def price(lines, promo_code):
    if not lines:
        raise ValueError("order has no lines")
    subtotal = 0
    for line in lines:
        qty = int(line.get("Quantity", line.get("quantity", 0)))
        unit = int(line.get("UnitPriceCents", line.get("unitPriceCents", 0)))
        if qty <= 0:
            raise ValueError("bad quantity")
        subtotal += qty * unit

    pct = 0
    if subtotal > 50000:
        pct += 10
    elif subtotal > 20000:
        pct += 5
    if any(int(l.get("Quantity", l.get("quantity", 0))) >= 10 for l in lines):
        pct += 2
    # Legacy quirk: VIP was never made stackable with the top tier (PricingService.cs).
    if promo_code == "VIP" and subtotal <= 50000:
        pct += 15

    discount = subtotal * pct // 100  # C# int division: truncates
    return {"subtotalCents": subtotal, "discountPercent": pct,
            "discountCents": discount, "totalCents": subtotal - discount}
