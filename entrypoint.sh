#!/bin/sh
set -e

# Debug: print environment variables
echo "Environment variables:"
echo "MAPS_DOMAIN=${MAPS_DOMAIN}"
echo "MAPS_PMTILES_LOCATION=${MAPS_PMTILES_LOCATION}"
echo "MAPS_EMAIL=${MAPS_EMAIL}"
echo "MAPS_SERVE_DOMAIN=${MAPS_SERVE_DOMAIN}"

# Replace environment variables in Caddyfile
export MAPS_DOMAIN
export MAPS_PMTILES_LOCATION
export MAPS_EMAIL
export MAPS_SERVE_DOMAIN
envsubst '${MAPS_DOMAIN} ${MAPS_PMTILES_LOCATION} ${MAPS_EMAIL} ${MAPS_SERVE_DOMAIN}' < /etc/caddy/Caddyfile.template > /etc/caddy/Caddyfile

echo "Caddyfile:"
cat /etc/caddy/Caddyfile

# Execute Caddy
exec /usr/bin/caddy run --config /etc/caddy/Caddyfile
