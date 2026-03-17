#!/usr/bin/env bash
# Build and push the Docker image to DockerHub.
#
# Usage:
#   ./scripts/build.sh               # builds :latest
#   ./scripts/build.sh <tag>         # builds :<tag> AND :latest
#
# Environment variables:
#   DOCKERHUB_USERNAME  – DockerHub username  (default: faboborgeslima)
#   IMAGE_NAME          – image name           (default: blog)

set -euo pipefail

DOCKERHUB_USERNAME="${DOCKERHUB_USERNAME:-faboborgeslima}"
IMAGE_NAME="${IMAGE_NAME:-blog}"
IMAGE="${DOCKERHUB_USERNAME}/${IMAGE_NAME}"

TAG="${1:-latest}"

echo "==> Building ${IMAGE}:${TAG} (platform linux/amd64)"

docker build \
  --platform linux/amd64 \
  --tag "${IMAGE}:${TAG}" \
  --tag "${IMAGE}:latest" \
  .

echo "==> Pushing ${IMAGE}:${TAG}"
docker push "${IMAGE}:${TAG}"

if [[ "${TAG}" != "latest" ]]; then
  echo "==> Pushing ${IMAGE}:latest"
  docker push "${IMAGE}:latest"
fi

echo "==> Done: ${IMAGE}:${TAG}"
