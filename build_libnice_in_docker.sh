#!/bin/sh

# Build the container
docker build \
    --file ./build_libnice.Dockerfile \
    -t devtown/build_libnice_from_source .
