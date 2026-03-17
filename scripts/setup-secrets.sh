#!/usr/bin/env bash
# Creates the blog-secrets Kubernetes Secret from environment variables.
# Safe to run on every deploy: skips creation if the secret already exists.
#
# Required env vars:
#   DB_HOST           – PostgreSQL host (CNPG: default-cluster-rw)
#   DB_USERNAME       – PostgreSQL username (CNPG)
#   DB_PASSWORD       – PostgreSQL password (CNPG)
#   RAILS_MASTER_KEY  – Rails credentials master key

set -euo pipefail

NAMESPACE="${NAMESPACE:-default}"
SECRET_NAME="${SECRET_NAME:-blog-secrets}"

: "${DB_HOST:?DB_HOST is required}"
: "${DB_USERNAME:?DB_USERNAME is required}"
: "${DB_PASSWORD:?DB_PASSWORD is required}"
: "${RAILS_MASTER_KEY:?RAILS_MASTER_KEY is required}"

echo "==> Applying secret '${SECRET_NAME}' in namespace '${NAMESPACE}'"

kubectl create secret generic "$SECRET_NAME" \
  --namespace "$NAMESPACE" \
  --from-literal=DB_HOST="$DB_HOST" \
  --from-literal=DB_USERNAME="$DB_USERNAME" \
  --from-literal=DB_PASSWORD="$DB_PASSWORD" \
  --from-literal=RAILS_MASTER_KEY="$RAILS_MASTER_KEY" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "==> Secret '${SECRET_NAME}' applied."
