# Metabase ARM64 for Coolify

This repository contains a custom Dockerfile to build Metabase for ARM64 architecture, specifically designed for deployment with Coolify.

## Features
- Official Metabase JAR (not community builds)
- ARM64 native performance
- Configurable version via build args
- Health checks included
- Optimized for Coolify deployment

## Version Management
To update Metabase version, set the `METABASE_VERSION` build argument in Coolify:
- Current default: v0.55.4.x
- Example: v0.56.0.x (when available)

## Usage in Coolify
1. Create new Application from Git Repository
2. Point to this repository
3. Set environment variables as needed
4. Deploy

## Environment Variables
- `METABASE_VERSION`: Metabase version to download (build arg)
- `MB_DB_TYPE`: Database type (postgres, mysql, etc.)
- `MB_DB_HOST`: Database host
- `MB_DB_PORT`: Database port
- `MB_DB_DBNAME`: Database name
- `MB_DB_USER`: Database user
- `MB_DB_PASS`: Database password
- `JAVA_TIMEZONE`: Java timezone (optional)

## Health Check
The container includes a health check endpoint at `/api/health` that Coolify can use for monitoring.
