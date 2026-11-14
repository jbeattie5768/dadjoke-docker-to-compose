# The docker compose commands need to know which project is intended
# This expects the project to be in the current dir
docker compose -f compose.ghcr.yaml up -d  # pull from ghcr.io, no build

# curl localhost:80  # port 80 is not required its the default

