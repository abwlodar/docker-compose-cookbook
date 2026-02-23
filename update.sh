#!/bin/bash

set -e

for dir in */; do
    [ ! -f "$dir/docker-compose.yml" ] && continue
    echo "--- $dir ---"
    cd "$dir"
    docker compose pull
    docker compose up -d
    cd ..
done

echo "done"
