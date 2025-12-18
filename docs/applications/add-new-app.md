# Adding applications

To add a new service or group of services to the home server setup, we most likely want to follow the steps outlined in the following.

## For a single application

We create the following files and directories:

```
└── stacks/
    ├── ...
    └── myApplication/
        ├── .env
        └── compose.yaml

└── data/
    ├── ...
    └── myApplication/
```

- `data/myApplication`: Directory mapped as a [volume](https://docs.docker.com/storage/volumes/) to persist container data
- `stacks/myApplication/.env`: Contains [environment variables](https://docs.docker.com/compose/environment-variables/set-environment-variables/). Refer to [Set up ENV](/applications/set-up-env) for details

The `compose.yaml` may resemble:

```yaml
name: myApplication

services:
  myNewApp:
    image: ghcr.io/FjellOverflow/myApplication:latest
    container_name: myApplication
    volumes:
      - /fjellheimen/data/myApplication:/config
      - /xdrive/Media:/media
    networks:
      - proxy-network
    env_file:
      - /fjellheimen/stacks/.env
      - /fjellheimen/stacks/myApplication/.env
    environment:
      - MY_BOOLEAN_FLAG=true
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```

Note:
- `name: myApplication` assigns the application to the stack `myApplication`, consisting of only that one application
- Different ENVs are loaded and additional ENV variables can be defined
- The service is part of the [Proxy network](#proxy-network)

## For an entire stack

We create the following structure:

```
└── stacks/
    ├── ...
    └── myStack/
        ├── .env
        └── compose.yaml

└── data/
    ├── ...
    └── myStack/
        ├── application1/
        └── application2/
```

- `data/myStack`: Contains directories for all stack applications to persist their data
- `stacks/myStack/.env` contains stack-wide ENV variables. See [Set up ENV](/applications/set-up-env) more information

The `compose.yaml` may resemble:

```yaml
name: myStack

services:
  application1:
    image: ghcr.io/FjellOverflow/application1:latest
    container_name: myStack-application1
    volumes:
      - /fjellheimen/data/myStack/application1:/config
    networks:
      - proxy-network
    env_file:
      - /fjellheimen/stacks/.env
      - /fjellheimen/stacks/myStack/.env
    restart: unless-stopped

  application1:
    image: ghcr.io/FjellOverflow/application2:latest
    container_name: myStack-application2
    volumes:
      - /fjellheimen/data/myStack/application2:/data
    networks:
      - proxy-network
    env_file:
      - /fjellheimen/stacks/.env
      - /fjellheimen/stacks/myStack/.env
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```

Note:
- `name: myStack`: ensures all containers belong to the same stack
- Container names are prefixed with `myStack-` to make clear they belong to `myStack`

## .gitignores

[.gitignore](https://git-scm.com/docs/gitignore) files are essential to exclude large and sensitive data from version control. The root `.gitignore` excludes all `.env` files and the content of the `data` dir by default. To manually include certain failes, add them to the `.gitignore`:

```
# ignore all ENV
*.env

# but include a specific one
!stacks/myStack/.env
```

## Healthchecks

Docker [health checks](https://docs.docker.com/reference/dockerfile/#healthcheck) are valuable for monitoring container health. While some images include built-in health checks, they can also be added manually. To monitor the service's reachability on port `8888`, a `curl` or `wget` request (assuming the tools are included in the Docker image) can be incorporated into a `healtcheck` within the `compose.yaml` file.

```yaml
healthcheck:
      test: curl --fail http://localhost:8888 || exit 1
          # wget -nv -t1 --spider http://localhost:8888 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
```

## Proxy network

[Networking](https://docs.docker.com/network/) within Docker containers can be complex. Typically, we aim for services to be isolated from each other and the host network. However, to enable access to a service via the web through a reverse proxy, the container must be part of the `proxy-network`. For further information, refer to the section on [Reverse Proxy](/stacks/core#reverse-proxy).

```yaml
networks:
  - proxy-network
```
