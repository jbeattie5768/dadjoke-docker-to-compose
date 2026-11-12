
![Architecture](docs/images/architecture.png)

||Manual|Compose|
|---|---|---|
|Start|5 commands, in the right order|`docker compose up -d --build`|
|Stop and clean up|3 commands, and you must remember every name|`docker compose down -v`|
|Network|create it yourself|automatic|
|Naming|your own convention|`dadjoke-<service>-1`, consistent|
|Config lives in|shell history or a script|one declarative file in Git|
|Restart on reboot|not handled|`restart: unless-stopped`|

