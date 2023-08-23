# Homeserver

Set up and configurations of my home server.

## Project structure

- `compose` contains docker-compose files for various services.
- `data` contains the data for the services.
- `environment` contains `.env` files for the services.

A service `myService` is defined in its docker-compose file `compose/myservice.yml`:

```yml
version: '3'
services:
    myservice:
        image: my/service:latest
        volumes:
            - ./data/myservice:/data
        env_file:
            - ./environment/myservice.env
```

It usually has a directory `data/myservice` that is mapped as a docker volume and an environment file `environment/myservice.env` that is given into the container.

## Docker Compose files

A full-fledged docker compose file can look like this:

```yml
version: '3'

name: homeserver

services:

    myservice:
        image: my/service:latest
        container_name: myservice
        volumes:
            - ./data/myservice/config:/config
            - /some/other/directory/media:/media
        networks:
            - proxy-network
        env_file:
            - ./environment/general.env
            - ./environment/myservice.env
        healthcheck:
            test: curl --fail http://localhost:8080 || exit 1
            interval: 1m
            start_period: 20s
            timeout: 10s
            retries: 3

networks:
    proxy-network:
        external: true
```
- `name: homeserver` is set, as the services, even if defined in different docker compose files, should belong to the same stack. Depending on how, when and from where the container is first started, compose might assign them to different stacks. `name: homeserver` overrides that behaviour and assigns all services to the `homeserver` stack

- `container_name: myservice`: for a more independent service, the container name will be `myservice`; for containers that belong or are intended to be run together, they will be named `purpose-service1`, `purpose-service2` and so on.

- While some services do not make use of any volumes, many need at least one volume to store their data or configuration, which will be stored in `data/myservice/config` and hence the volume mapping `./data/myservice/config:/config`. Some might have additional volumes, for instance some media directory `/some/other/directory/media:/media`. The idea is that all data that is needed for the home server setup to run is stored in `data`, while other data, for instance a directory with media, does not strictly belong to the home server setup, but are an independent data source.

- Many, if not almost all containers are explicitly set to belong to the externally defined `proxy-network`. This is due to the reverse-proxy setup of the home server and is explained in detail in section TODO.

- Almost all containers receive environment variables via the `general.env` file. This sets, amongst others the appropriate timezone `TZ` and `UID` and `GID` for containers to be run as the user (and not `root`), which is universal for most containers. Containers that need specific `ENV` variables set (such as passwords, API-keys, ...), get, in addition, the file `environment/myservice.env` as input.

- A `healthcheck` is set up with most containers as well; it monitors that the container is well (that the application running inside the container is responding to requests). Thus containers will show `Up 2 hours (healthy)` as status.

## FAQ

### Why is the `environment` folder empty (except for `general.env`)?
Locally, this folder is not empy, but contains the `.env` variables for the various services. That means *usernames*, *passwords*, *urls*, *API-keys* and more. This means it needs to be adjusted per-case basis, is private and does not belong into a git repository.

### Why is the `data` folder (basically) empty?
It is not empy, but contains the empty skeleton of my local directory structure. All of the directories `data/myservice` are mapped as docker volumes to some containers, which means they need to exists, for the container to run. They are (mostly) empty, as they contain the data of the running services, which does not belong (and does not fit) into a git repository.

(An exception is `data/homepage`), as it contains the (not private) configuration for the home server dashboard.