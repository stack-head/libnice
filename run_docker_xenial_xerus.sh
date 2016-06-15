#!/bin/sh

# Run the Docker container containing a working version of tyco-mesh and all of
# it's build and runtime dependencies.
docker run -it --rm \
    --name build_libnice_from_source \
    devtown/build_libnice_from_source \
    /bin/bash
