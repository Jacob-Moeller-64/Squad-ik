#!/usr/bin/env python3
"""IIS Express stand-in for Linux eval environments.

Serves the real AngularJS frontend from LegacyApplication/ and implements the same
three endpoints with behavior-identical logic — including the PricingService quirks
(integer truncation; VIP ignored above the top tier boundary). This file is eval
scaffolding, NOT part of the migration subject. If PricingService.cs changes, this
must change with it (and the goldens re-captured).

Usage: serve.py [--port 8123]
"""
import argparse
import json
import re
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

from pricing import price

LEGACY = Path(__file__).resolve().parent.parent / "LegacyApplication"

# Keep in sync with Data/ProductRepository.cs (PascalCase: MVC5 JsonResult casing).
PRODUCTS = [
    {"Id": 1, "Name": "Anvil", "Category": "Hardware", "UnitPriceCents": 12999, "InStock": True},
    {"Id": 2, "Name": "Rocket Skates", "Category": "Transport", "UnitPriceCents": 24950, "InStock": True},
    {"Id": 3, "Name": "Bird Seed", "Category": "Supplies", "UnitPriceCents": 599, "InStock": False},
    {"Id": 4, "Name": "Giant Magnet", "Category": "Hardware", "UnitPriceCents": 55000, "InStock": True},
]

STATIC_TYPES = {".js": "application/javascript", ".css": "text/css", ".html": "text/html", ".png": "image/png"}

# Forms-auth stand-in: fixed ticket value so goldens are deterministic (TEST_COOKIE env).
AUTH_COOKIE_NAME = ".ASPXAUTH"
AUTH_TICKET = "demo-ticket"
DEMO_USER = ("demo", "demo123")
ORDER_HISTORY = [
    {"OrderId": "a1f0", "TotalCents": 49500},
    {"OrderId": "b2e1", "TotalCents": 16400},
]


def index_html():
    """Index.cshtml with ~/ paths resolved — what IIS would effectively serve."""
    cshtml = (LEGACY / "Views" / "Home" / "Index.cshtml").read_text()
    return cshtml.replace('"~/', '"/')


class Handler(BaseHTTPRequestHandler):
    def _send(self, status, body, ctype="application/json"):
        data = body if isinstance(body, bytes) else json.dumps(body).encode()
        if ctype.startswith("text/"):
            data = body.encode() if isinstance(body, str) else data
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def _authed(self):
        cookies = self.headers.get("Cookie", "")
        return f"{AUTH_COOKIE_NAME}={AUTH_TICKET}" in cookies

    def do_GET(self):
        path = self.path.split("?")[0]
        if path in ("/", "/Home/Index"):
            return self._send(200, index_html(), "text/html")
        if path == "/Products/List":
            return self._send(200, PRODUCTS)
        if path == "/Orders/History":
            if not self._authed():
                # Real MVC5 forms auth: [Authorize] redirects to the login URL.
                self.send_response(302)
                self.send_header("Location", f"/Account/Login?ReturnUrl={self.path}")
                self.send_header("Content-Length", "0")
                self.end_headers()
                return None
            return self._send(200, ORDER_HISTORY)
        m = re.fullmatch(r"/Products/Detail/(\d+)", path)
        if m:
            product = next((p for p in PRODUCTS if p["Id"] == int(m.group(1))), None)
            if product is None:
                return self._send(404, {"error": "not found"})
            return self._send(200, product)
        # static files from the legacy app
        rel = path.lstrip("/")
        if rel.startswith(("Scripts/", "Content/")):
            f = (LEGACY / rel).resolve()
            if str(f).startswith(str(LEGACY)) and f.is_file():
                return self._send(200, f.read_bytes(), STATIC_TYPES.get(f.suffix, "application/octet-stream"))
        return self._send(404, {"error": "not found"})

    def do_POST(self):
        path = self.path.split("?")[0]
        if path == "/Account/Login":
            try:
                body = json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")
            except json.JSONDecodeError:
                return self._send(400, {"error": "bad json"})
            user = body.get("Username") or body.get("username") or ""
            pw = body.get("Password") or body.get("password") or ""
            if (user, pw) == DEMO_USER:
                data = json.dumps({"ok": True, "user": "demo"}).encode()
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Set-Cookie", f"{AUTH_COOKIE_NAME}={AUTH_TICKET}; Path=/; HttpOnly")
                self.send_header("Content-Length", str(len(data)))
                self.end_headers()
                self.wfile.write(data)
                return None
            return self._send(401, {"error": "invalid credentials"})
        if path != "/Orders/Create":
            return self._send(404, {"error": "not found"})
        try:
            body = json.loads(self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}")
            lines = body.get("Lines") or body.get("lines") or []
            promo = body.get("PromoCode") or body.get("promoCode") or ""
            result = price(lines, promo)
        except json.JSONDecodeError:  # must precede ValueError: JSONDecodeError subclasses it
            return self._send(400, {"error": "bad json"})
        except ValueError as e:
            return self._send(400, {"error": str(e)})
        result = {"orderId": uuid.uuid4().hex, **result}
        return self._send(200, result)

    def log_message(self, fmt, *args):  # quiet
        pass


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8123)
    args = ap.parse_args()
    print(f"legacy harness on http://localhost:{args.port}/ (serving {LEGACY})")
    ThreadingHTTPServer(("127.0.0.1", args.port), Handler).serve_forever()


if __name__ == "__main__":
    main()
