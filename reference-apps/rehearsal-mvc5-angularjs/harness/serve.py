#!/usr/bin/env python3
"""IIS Express stand-in for Linux eval environments.

Serves the real AngularJS frontend from LegacyApplication/ and implements the
same endpoints as the MVC5 controllers with behavior-identical logic — including
every seeded quirk (SLA weekend-before-Gold ordering, Critical exemption; travel
waiver on labor only with untaxed travel; silent dispatch re-assign). ALL JSON is
PascalCase, matching MVC5 JsonResult serialization of the C# property names.

This file is eval scaffolding, NOT part of the migration subject. Keep in sync
with LegacyApplication/Controllers/*.cs and harness/logic.py; if those change,
this must change with them (and any goldens re-captured).

Deterministic: fixed seed data from logic.py; uuid is used ONLY for the
WorkOrderId in /WorkOrders/Create responses.

Usage: serve.py [--port 8135]
"""
import argparse
import json
import re
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, quote, urlparse

import logic

LEGACY = Path(__file__).resolve().parent.parent / "LegacyApplication"

STATIC_TYPES = {".js": "application/javascript", ".css": "text/css", ".html": "text/html", ".png": "image/png"}

# Forms-auth stand-in for web.config <authentication mode="Forms">: fixed ticket
# value so goldens stay deterministic.
AUTH_COOKIE_NAME = ".FSAUTH"
AUTH_TICKET = "demo-ticket"
DEMO_USER = ("demo", "demo123")

# Mutable dispatch board state (mirrors Repo.Assignments' static-mutable hazard).
ASSIGNMENTS = logic.seed_assignments()


def index_html():
    """Index.cshtml with ~/ paths resolved — what IIS would effectively serve."""
    cshtml = (LEGACY / "Views" / "Home" / "Index.cshtml").read_text()
    return cshtml.replace('"~/', '"/')


def field(body, name):
    """JsonConvert matches properties case-insensitively; accept camelCase too."""
    if name in body:
        return body[name]
    return body.get(name[0].lower() + name[1:])


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

    def _read_json(self):
        raw = self.rfile.read(int(self.headers.get("Content-Length", 0))) or b"{}"
        return json.loads(raw)

    def do_GET(self):
        parsed = urlparse(self.path)
        path = parsed.path

        if path in ("/", "/Home/Index"):
            return self._send(200, index_html(), "text/html")

        if path == "/WorkOrders/List":
            return self._send(200, logic.WORK_ORDERS)

        if path == "/WorkOrders/Search":
            status = parse_qs(parsed.query).get("status", [None])[0]
            matches = [w for w in logic.WORK_ORDERS if w["Status"] == status]
            return self._send(200, matches)

        m = re.fullmatch(r"/WorkOrders/Detail/([^/]+)", path)
        if m:
            order = next((w for w in logic.WORK_ORDERS if w["Id"] == m.group(1)), None)
            if order is None:
                return self._send(404, {"Error": "not found"})
            return self._send(200, order)

        if path == "/Technicians/List":
            return self._send(200, logic.TECHNICIANS)

        m = re.fullmatch(r"/Technicians/Detail/(\d+)", path)
        if m:
            tech = next((t for t in logic.TECHNICIANS if t["Id"] == int(m.group(1))), None)
            if tech is None:
                return self._send(404, {"Error": "not found"})
            return self._send(200, tech)

        if path == "/Invoices/Recent":
            if not self._authed():
                # Real MVC5 forms auth: [Authorize] 302s to the web.config loginUrl.
                self.send_response(302)
                self.send_header("Location", f"/Account/Login?ReturnUrl={quote(self.path, safe='')}")
                self.send_header("Content-Length", "0")
                self.end_headers()
                return None
            return self._send(200, logic.INVOICES)

        # static files from the legacy app
        rel = path.lstrip("/")
        if rel.startswith(("Scripts/", "Content/")):
            f = (LEGACY / rel).resolve()
            if str(f).startswith(str(LEGACY)) and f.is_file():
                return self._send(200, f.read_bytes(), STATIC_TYPES.get(f.suffix, "application/octet-stream"))
        return self._send(404, {"Error": "not found"})

    def do_POST(self):
        path = self.path.split("?")[0]
        try:
            body = self._read_json()
        except json.JSONDecodeError:
            return self._send(400, {"Error": "bad json"})
        if not isinstance(body, dict):
            body = {}

        if path == "/Account/Login":
            if (field(body, "Username") or "", field(body, "Password") or "") == DEMO_USER:
                data = json.dumps({"Ok": True, "User": "demo"}).encode()
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Set-Cookie", f"{AUTH_COOKIE_NAME}={AUTH_TICKET}; Path=/; HttpOnly")
                self.send_header("Content-Length", str(len(data)))
                self.end_headers()
                self.wfile.write(data)
                return None
            return self._send(401, {"Error": "invalid credentials"})

        if path == "/Account/Logout":
            data = json.dumps({"Ok": True}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Set-Cookie",
                             f"{AUTH_COOKIE_NAME}=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT")
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)
            return None

        if path == "/WorkOrders/Create":
            try:
                due = logic.due_in_hours(field(body, "Priority"),
                                         field(body, "ContractTier"),
                                         bool(field(body, "Weekend")))
            except ValueError as e:
                return self._send(400, {"Error": str(e)})
            # uuid here is the ONLY nondeterminism, matching Guid.NewGuid().ToString("N").
            return self._send(200, {
                "WorkOrderId": uuid.uuid4().hex,
                "Title": field(body, "Title"),
                "Priority": field(body, "Priority"),
                "DueInHours": due,
            })

        if path == "/Dispatch/Assign":
            work_order_id = field(body, "WorkOrderId")
            technician_id = field(body, "TechnicianId") or 0  # C# int default
            try:
                active_load = logic.assign(ASSIGNMENTS, work_order_id, technician_id)
            except ValueError:
                return self._send(400, {"Error": "no such technician"})
            except RuntimeError:
                return self._send(422, {"Error": "over capacity"})
            return self._send(200, {
                "TechnicianId": technician_id,
                "WorkOrderId": work_order_id,
                "ActiveLoad": active_load,
            })

        if path == "/Invoices/Quote":
            try:
                result = logic.quote(field(body, "LaborHours") or 0,
                                     field(body, "HourlyRateCents") or 0,
                                     field(body, "PartsCents") or [],
                                     field(body, "Visits") or 0)
            except ValueError as e:
                return self._send(400, {"Error": str(e)})
            return self._send(200, result)

        return self._send(404, {"Error": "not found"})

    def log_message(self, fmt, *args):  # quiet
        pass


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8135)
    args = ap.parse_args()
    print(f"legacy harness on http://localhost:{args.port}/ (serving {LEGACY})")
    ThreadingHTTPServer(("127.0.0.1", args.port), Handler).serve_forever()


if __name__ == "__main__":
    main()
