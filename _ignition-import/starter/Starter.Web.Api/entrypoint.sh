#!/usr/bin/env sh
set -eu

# OpenShift patterns often provide PORT. Prefer explicit ASPNETCORE_URLS if set.
if [ -z "${ASPNETCORE_URLS:-}" ]; then
  if [ -n "${PORT:-}" ]; then
    export ASPNETCORE_URLS="http://0.0.0.0:${PORT}"
  else
    export ASPNETCORE_URLS="http://0.0.0.0:8080"
  fi
fi

exec dotnet Starter.Web.Api.dll
