#!/bin/sh

set -euo pipefail

echo ${BACKEND_DOMAIN}
echo ${BACKEND_HOST}
echo ${BACKEND_PORT}
echo ${FRONTEND_DOMAIN}
echo ${FRONTEND_HOST}
echo ${FRONTEND_PORT}
echo

# for backwards compatibility, seperates host and port from url
export FRONTEND_DOMAIN=${FRONTEND_DOMAIN:-${FRONTEND_HOST%:*}}
export FRONTEND_PORT=${FRONTEND_PORT:-${FRONTEND_HOST##*:}}

export BACKEND_DOMAIN=${BACKEND_DOMAIN:-${BACKEND_HOST%:*}}
export BACKEND_PORT=${BACKEND_PORT:-${BACKEND_HOST##*:}}

echo ${FRONTEND_DOMAIN:-${FRONTEND_HOST%:*}}
echo ${FRONTEND_PORT:-${FRONTEND_HOST##*:}}
echo ${BACKEND_DOMAIN:-${BACKEND_HOST%:*}}
echo ${BACKEND_PORT:-${BACKEND_HOST##*:}}

# strip https:// or https:// from domain if necessary
FRONTEND_DOMAIN=${FRONTEND_DOMAIN##*://}
BACKEND_DOMAIN=${BACKEND_DOMAIN##*://}

echo using frontend: ${FRONTEND_DOMAIN} with port: ${FRONTEND_PORT}
echo using backend: ${BACKEND_DOMAIN} with port: ${BACKEND_PORT}

exec caddy run --config Caddyfile --adapter caddyfile 2>&1