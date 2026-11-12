#!/bin/bash
docker rm -f dadjoke-fetcher dadjoke-web
docker network rm dadjoke-net
docker volume rm dadjoke-html
