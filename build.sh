#!/usr/bin/env bash

# Build and push
podman build --platform linux/386,linux/amd64,linux/arm64/v8 --manifest fauli1221/funbox .

# publish image
podman manifest push fauli1221/funbox docker.io/fauli1221/funbox

# Update local image
podman pull fauli1221/funbox:latest
