#!/usr/bin/env python3
"""Tier-0 unit tests for the goldens replayer. Run: python3 -m unittest discover -s . -v"""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from verify_goldens import normalize, strict_equal  # noqa: E402


class StrictEqual(unittest.TestCase):
    def test_bool_is_not_int(self):
        self.assertFalse(strict_equal({"InStock": 1}, {"InStock": True}))
        self.assertFalse(strict_equal(True, 1))

    def test_int_is_not_float(self):
        self.assertFalse(strict_equal({"Price": 12999.0}, {"Price": 12999}))

    def test_matching_types_and_values(self):
        self.assertTrue(strict_equal(
            {"a": [1, 2, {"b": True, "c": None}]},
            {"a": [1, 2, {"b": True, "c": None}]},
        ))

    def test_value_mismatch_and_shape_mismatch(self):
        self.assertFalse(strict_equal({"a": 1}, {"a": 2}))
        self.assertFalse(strict_equal({"a": 1}, {"a": 1, "b": 2}))
        self.assertFalse(strict_equal([1, 2], [1, 2, 3]))


class Normalize(unittest.TestCase):
    def test_named_fields_replaced_recursively(self):
        doc = {"orderId": "abc", "nested": [{"orderId": "def", "total": 5}]}
        out = normalize(doc, {"orderId"})
        self.assertEqual(out["orderId"], "<NORMALIZED>")
        self.assertEqual(out["nested"][0]["orderId"], "<NORMALIZED>")
        self.assertEqual(out["nested"][0]["total"], 5)


if __name__ == "__main__":
    unittest.main()
