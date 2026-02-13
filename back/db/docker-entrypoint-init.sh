#!/bin/sh
set -e

# Start PostgreSQL in background
docker-entrypoint.sh postgres &

# Wait until DB is ready
until pg_isready -h localhost -U "$POSTGRES_USER"; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

# Run init script
echo "Running DB initialization..."
/db/init_db.sh /db

# Wait for PostgreSQL process to keep container alive
wait