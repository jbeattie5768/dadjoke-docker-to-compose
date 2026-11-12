Docker Compose allows you to define everything in one file. 

```shell title:"Runthe app"
cd 02-compose                 # docker compose needs to know the project
docker compose up -d --build  # start
curl localhost                # get the dad-joke

docker compose down           # stop
```

That is all that is needed. 

```Shell title:"Run Docker Compose"
## To run it from the project dir
cd 02-compose 
docker compose up -d --build    # `-d` detach, `--build` build the fetcher image in ../app

docker compose ps               # projects contianers status
docker compose logs -f          # live logs from both contianers
docker compose logs -f fetcher  # just one container
docker compose down             # stop and remove containers + network 
docker compose down -v          # stop en remove the volume

## To run it from another dir
# The docker compose commands need to know which project is intended
docker compose -f 02-compose/compose.yaml up -d --build

docker ps --filter name=dadjoke
docker logs -f dadjoke-web-1 
docker logs -f dadjoke-fetcher-1 

# This also works as we named the project in compose.yaml
docker compose -p dadjoke ps 

docker compose -p dadjoke logs -f 
docker compose -p dadjoke down

# Lastly, because we named the project, we can point it at the file
docker compose -f ~/dadjoke-docker-to-compose/02-compose/compose.yaml logs -f
```
