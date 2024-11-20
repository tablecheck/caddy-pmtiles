# Caddy PMTiles Server

A Docker container that serves PMTiles using Caddy with S3 bucket support and CORS configuration.

## Features

- PMTiles serving from S3 buckets
- Automatic CORS handling for specified domains
- Built-in support for MapLibre
- Configurable cache size
- TLS support via Caddy

## Usage

### Environment Variables

- `MAPS_DOMAIN`: Your domain name (e.g., `tiles.example.com`)
- `MAPS_SERVE_DOMAIN`: Domain pattern for CORS (e.g., `example.com`)
- `MAPS_PMTILES_LOCATION`: S3 bucket URL (e.g., `s3://your-bucket`)
- `MAPS_EMAIL`: Email for Let's Encrypt
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_REGION`: AWS region

### Running the Container

```bash
docker run -d \
-e MAPS_DOMAIN=tiles.example.com \
-e MAPS_SERVE_DOMAIN=https://([a-zA-Z0-9-]+\\.)*example.com \
-e MAPS_PMTILES_LOCATION=s3://your-bucket \
-e AWS_ACCESS_KEY_ID=your_key \
-e AWS_SECRET_ACCESS_KEY=your_secret \
-e AWS_REGION=us-east-1 \
-e MAPS_EMAIL=admin@example.com \
-p 80:80 -p 443:443 \
caddy-pmtiles
```

### Development

Build the image

```bash
docker build -t caddy-pmtiles .
```

Run locally
```bash
docker run -t \
-e MAPS_DOMAIN=localhost:8080 \
-e MAPS_SERVE_DOMAIN=localhost \
-e MAPS_PMTILES_LOCATION=s3://your-bucket \
-e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
-e AWS_REGION=$AWS_REGION \
-e MAPS_EMAIL="test@localhost" \
-p 8080:8080 \
caddy-pmtiles
```


## CORS Configuration

The server allows CORS requests from:
- Any subdomain of `MAPS_SERVE_DOMAIN`
- https://maplibre.org

## Cache Configuration

The PMTiles cache size is set to 19000 MB by default. Adjust the `cache_size` in the Caddyfile if needed.
