# 02-compose: Running the App with Docker Compose

Docker Compose describes the whole app in one file, [`compose.yaml`](compose.yaml). Compose reads it and handles the build, creation, start order and naming itself, instead of you running each `docker` command by hand in the right sequence.

## Run It

```shell title:"Run the app"
cd 02-compose                 # docker compose looks for compose.yaml in the current dir
docker compose up -d --build  # build the image, create and start everything
curl localhost                # get the dad joke
                              # or open http://localhost in a browser
docker compose down -v        # stop and remove containers, network and volume
```

That's all it takes, with no scripts and no names to remember.

## What `compose.yaml` Takes Care Of

Everything that was a separate step in [01-manual](../01-manual/README.md) is either declared once or handled automatically:

* **Build**: `build: ../app` builds the fetcher image as part of `up --build`.
* **Volume**: `html` is declared once and created as `dadjoke_html`. `down -v` removes it again.
* **Network**: not declared at all. Compose creates a default network, `dadjoke_default`, and attaches both services to it.
* **Start order**: `depends_on` starts `fetcher` before `web`.
* **Restart policy**: `restart: unless-stopped` brings a container back if it exits or Docker restarts, unless you stopped it yourself.
* **Naming**: the project is named `dadjoke` in the file, so every resource gets a predictable name: `dadjoke-fetcher-1`, `dadjoke-web-1`, `dadjoke_html`, `dadjoke_default`.

## Running It From Another Directory

Compose needs to know which project you mean. From the project dir it finds `compose.yaml` itself. From anywhere else you can point it at the file, or use the project name:

```shell title:"Run Docker Compose"
## From the project dir
cd 02-compose
docker compose up -d --build    # `-d` detach, `--build` build the fetcher image from ../app

## From the repo root, pointing at the file
docker compose -f 02-compose/compose.yaml up -d --build

## From anywhere, using the project name set in compose.yaml
docker compose -p dadjoke ps
```

## Logs

Because Compose knows which containers belong to the app, logs are simple too:

```shell title:"Simple logs"
## From the project dir
docker compose logs -f            # live logs from both containers
docker compose logs -f fetcher    # ...or just one service

## From the repo root
docker compose -f 02-compose/compose.yaml logs -f

## Or with plain docker, using the predictable container names
docker logs -f dadjoke-web-1
docker logs -f dadjoke-fetcher-1
```

Compare this with [01-manual](../01-manual/README.md), where the same app takes five `docker` commands to start and three to stop, all with names you have to keep track of yourself.

This app is tiny, and the gap only widens as an app grows. Each new service is a few more lines of YAML rather than another set of commands to sequence, name and clean up. That's why Compose is the practical way to run multi-container apps.
