#!/usr/bin/env python3
"""Okta stand-in: a minimal real OIDC issuer for the rehearsal.

Implements the pieces the modernized stack actually exercises — discovery document,
JWKS, an /authorize page (implicit flow for demo simplicity), RS256-signed JWTs — so
the .NET JwtBearer middleware validates tokens exactly as it would against a real Okta
org (authority + audience + JWKS signature). Swap `issuer` config to a real Okta domain
and none of the consuming code changes. NOT production software.

Usage: issuer.py [--port 8321]
"""
import argparse
import base64
import json
import time
import urllib.parse
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

import jwt
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa

KEY_FILE = Path(__file__).parent / "issuer-key.pem"
KID = "rehearsal-key-1"
AUDIENCE = "legacyshop"


def load_key():
    if KEY_FILE.exists():
        return serialization.load_pem_private_key(KEY_FILE.read_bytes(), password=None)
    key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    KEY_FILE.write_bytes(key.private_bytes(
        serialization.Encoding.PEM,
        serialization.PrivateFormat.PKCS8,
        serialization.NoEncryption()))
    return key


KEY = load_key()
ISSUER = None  # set in main from port


def b64url_uint(n: int) -> str:
    data = n.to_bytes((n.bit_length() + 7) // 8, "big")
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode()


def jwks():
    pub = KEY.public_key().public_numbers()
    return {"keys": [{
        "kty": "RSA", "use": "sig", "alg": "RS256", "kid": KID,
        "n": b64url_uint(pub.n), "e": b64url_uint(pub.e),
    }]}


def mint_token(sub="demo", name="Demo User"):
    now = int(time.time())
    return jwt.encode(
        {"iss": ISSUER, "aud": AUDIENCE, "sub": sub, "name": name,
         "iat": now, "exp": now + 3600},
        KEY, algorithm="RS256", headers={"kid": KID})


AUTHORIZE_PAGE = """<!DOCTYPE html>
<html><head><title>Sign in — OktaStand-In</title><style>
  body {{ margin:0; font-family: -apple-system, 'Segoe UI', Roboto, sans-serif;
         background:#f5f6f8; display:flex; align-items:center; justify-content:center; height:100vh; }}
  .card {{ background:#fff; border-radius:8px; box-shadow:0 8px 30px rgba(29,41,57,.12);
          padding:40px 48px; width:340px; text-align:center; }}
  .logo {{ font-weight:800; font-size:22px; color:#00297a; letter-spacing:.5px; margin-bottom:6px; }}
  .logo span {{ color:#1662dd; }}
  .sub {{ color:#6e7780; font-size:13px; margin-bottom:28px; }}
  .app {{ font-size:15px; color:#1d2939; margin-bottom:24px; }}
  .btn {{ display:block; width:100%; padding:12px 0; background:#1662dd; color:#fff; border:none;
         border-radius:6px; font-size:15px; font-weight:600; cursor:pointer; text-decoration:none; }}
  .note {{ margin-top:22px; font-size:11px; color:#98a2b3; }}
</style></head><body>
  <div class="card">
    <div class="logo">okta<span>·standin</span></div>
    <div class="sub">Single Sign-On (rehearsal issuer)</div>
    <div class="app">Sign in to <b>LegacyShop</b> as <b>demo@example.com</b></div>
    <a class="btn" href="{grant_url}">Continue as Demo User</a>
    <div class="note">This is the kit's local OIDC stand-in. Point Oidc:Issuer at a real
    Okta org and the application code is unchanged.</div>
  </div>
</body></html>"""


class Handler(BaseHTTPRequestHandler):
    def _send(self, status, body, ctype="application/json", extra=None):
        data = body.encode() if isinstance(body, str) else json.dumps(body).encode()
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.send_header("Access-Control-Allow-Origin", "*")
        for k, v in (extra or {}).items():
            self.send_header(k, v)
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        url = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(url.query)
        if url.path == "/.well-known/openid-configuration":
            return self._send(200, {
                "issuer": ISSUER,
                "authorization_endpoint": f"{ISSUER}/authorize",
                "token_endpoint": f"{ISSUER}/token",
                "jwks_uri": f"{ISSUER}/jwks",
                "response_types_supported": ["token", "id_token"],
                "subject_types_supported": ["public"],
                "id_token_signing_alg_values_supported": ["RS256"],
            })
        if url.path == "/jwks":
            return self._send(200, jwks())
        if url.path == "/authorize":
            redirect = qs.get("redirect_uri", [""])[0]
            state = qs.get("state", [""])[0]
            token = mint_token()
            fragment = urllib.parse.urlencode({"access_token": token, "token_type": "Bearer", "state": state})
            grant_url = f"{redirect}#{fragment}"
            if qs.get("auto") == ["1"]:
                self.send_response(302)
                self.send_header("Location", grant_url)
                self.send_header("Content-Length", "0")
                self.end_headers()
                return None
            return self._send(200, AUTHORIZE_PAGE.format(grant_url=grant_url), "text/html")
        return self._send(404, {"error": "not found"})

    def log_message(self, fmt, *args):
        pass


def main():
    global ISSUER
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8321)
    args = ap.parse_args()
    ISSUER = f"http://127.0.0.1:{args.port}"
    print(f"OIDC stand-in issuer on {ISSUER}")
    ThreadingHTTPServer(("127.0.0.1", args.port), Handler).serve_forever()


if __name__ == "__main__":
    main()
