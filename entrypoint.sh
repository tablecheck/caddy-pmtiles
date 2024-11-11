#!/bin/sh
set -e

# Extract port from MAPS_DOMAIN if it exists
DOMAIN_WITHOUT_PORT=$(echo "${MAPS_DOMAIN}" | cut -d: -f1)
PORT=$(echo "${MAPS_DOMAIN}" | grep -o ':[0-9]\+' | cut -d: -f2)
PORT=${PORT:-443}  # Default to 443 if no port specified

# Export cleaned domain and port
export MAPS_DOMAIN=$DOMAIN_WITHOUT_PORT
export MAPS_PORT=$PORT

echo "Environment variables:"
echo "MAPS_DOMAIN=${MAPS_DOMAIN}"
echo "MAPS_PORT=${MAPS_PORT}"
echo "MAPS_PMTILES_LOCATION=${MAPS_PMTILES_LOCATION}"
echo "MAPS_EMAIL=${MAPS_EMAIL}"
echo "MAPS_SERVE_DOMAIN=${MAPS_SERVE_DOMAIN}"

# Replace environment variables in Caddyfile
export MAPS_DOMAIN
export MAPS_PMTILES_LOCATION
export MAPS_EMAIL
export MAPS_SERVE_DOMAIN
export MAPS_PORT
envsubst '${MAPS_DOMAIN} ${MAPS_PORT} ${MAPS_PMTILES_LOCATION} ${MAPS_EMAIL} ${MAPS_SERVE_DOMAIN}' < /etc/caddy/Caddyfile.template > /etc/caddy/Caddyfile

echo "Caddyfile:"
cat /etc/caddy/Caddyfile

# Execute Caddy
exec /usr/bin/caddy run --config /etc/caddy/Caddyfile
