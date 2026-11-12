#!/bin/bash
set -e  # exit straight away if any command fails
docker build -t dadjoke-fetcher:1.0.0 ../app
docker network create dadjoke-net
docker volume create dadjoke-html
docker run -d --name dadjoke-fetcher --network dadjoke-net -v dadjoke-html:/html dadjoke-fetcher:1.0.0
docker run -d --name dadjoke-web --network dadjoke-net -p 80:80 -v dadjoke-html:/usr/share/nginx/html:ro nginx:1.31.8
