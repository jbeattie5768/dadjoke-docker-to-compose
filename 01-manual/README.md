# 01-manual: Running the App by Hand

Here every part of the app (image build, network, volume, two containers) is its own `docker` command. They're wrapped in two scripts so they can be repeated, but the scripts only hide the problem. You're still responsible for the order, the names and the cleanup.

## Run It

```shell title:"Run the app"
cd 01-manual    # scripts assume they're run from here
./up.sh         # build + create network/volume + start both containers
curl localhost  # get the dad joke
                # or open http://localhost in a browser
./down.sh       # stop and remove everything
```

That's five commands to start, three to stop, and no record of any of it beyond these scripts and this README.

## What `up.sh` Does

```shell title:"What up.sh does"
docker build -t dadjoke-fetcher:1.0.0 ../app  # 1. build the fetcher image
docker network create dadjoke-net             # 2. create a network for the app
docker volume create dadjoke-html             # 3. create a volume to share the HTML between containers

docker run -d --name dadjoke-fetcher \
--network dadjoke-net \
-v dadjoke-html:/html \
dadjoke-fetcher:1.0.0                         # 4. start the fetcher

docker run -d --name dadjoke-web \
--network dadjoke-net -p 80:80 \
-v dadjoke-html:/usr/share/nginx/html:ro \
nginx:1.31.8                                  # 5. start nginx, serving the shared volume
```

## What `down.sh` Does

```shell title:"What down.sh does"
docker rm -f dadjoke-fetcher dadjoke-web      # remove both containers
docker network rm dadjoke-net                 # remove the network
docker volume rm dadjoke-html                 # remove the volume
```

## The Catch

* **Names have to match.** `dadjoke-net`, `dadjoke-html`, `dadjoke-fetcher` and `dadjoke-web` appear in both scripts. Rename or mistype one and a script fails or leaves resources behind. Nothing checks this for you.
* **Order matters.** The image, network and volume must exist before the containers that use them.
* **It isn't safely re-runnable.** `up.sh` stops at the first error (`set -e`), but anything it already created stays. Run it again and it fails on `docker network create` because the network already exists, so you have to run `down.sh` first.
* **No recovery.** There's no restart policy, so a container that exits stays down until you notice.

Compare this with [02-compose](../02-compose/README.md), where the same app is one declarative file and two commands.
