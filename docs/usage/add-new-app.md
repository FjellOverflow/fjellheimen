# Adding applications

When incorporating a new service or group of services with Docker images into the home server setup, follow the outlined process:

## Single application
Begin by creating the following files and directories:

```
└── myApplication
    ├── data
    ├── .env
    ├── .gitignore
    └── docker-compose.yaml

```

- `data`: Directory mapped as a [volume](https://docs.docker.com/storage/volumes/) to persist container data
- `.env`: Contains [environment variables](https://docs.docker.com/compose/environment-variables/set-environment-variables/). Refer to [Set up ENV](/usage/set-up-env) for details
- `.gitignore`: Used to exclude persisted `data` and sensitive `.env` from version control.

The `docker-compose.yaml` may resemble:

```yaml
name: other

services:
  myNewApp:
    image: ghcr.io/FjellOverflow/myApplication:latest
    container_name: myApplication
    volumes:
      - /homeserver/myApplication/data:/config
      - /xdrive/Media:/media
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
      - /homeserver/myApplication/.env
    environment:
      - MY_BOOLEAN_FLAG=true
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```

Note:
- `name: other` assigns the application to the generic stack `other`
- Different ENVs are loaded and additional ENV variables can be defined
- The service is part of the [Proxy network](#proxy-network)

## Entire stack
Adding a stack follows a similar process:
Create the following structure:

```
└── someStack
    ├── data
    │   ├── application1
    │   └── application2
    ├── docker-compose.yaml
    ├── .gitignore
    ├── .env
    ├── application1.env
    └── application2.env
```

- `data`: Contains directories for all stack applications to persist their data
- `.env` contains stack-wide ENV variables, while `application1.env`: Holds stack-wide ENV variables. Specific ENVs for each application can be placed in `<application name>.env`. See [Set up ENV](/usage/set-up-env) more information

The `docker-compose.yaml` may resemble:

```yaml
name: myStack

services:
  application1:
    image: ghcr.io/FjellOverflow/application1:latest
    container_name: myStack-application1
    volumes:
      - /homeserver/myStack/application1/data:/config
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
      - /homeserver/myStack/.env
      - /homeserver/myStack/application1.env
    restart: unless-stopped

  application1:
    image: ghcr.io/FjellOverflow/application2:latest
    container_name: myStack-application2
    volumes:
      - /homeserver/myStack/application2/data:/data
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
      - /homeserver/myStack/.env
      - /homeserver/myStack/application2.env
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```

Note:
- `name: myStack`: ensures all containers belong to the same stack
- Container names are prefixed with `myStack-` to make clear they belong to `myStack`
- General stack ENV and individual ENVs are loaded

## .gitignores

[.gitignore](https://git-scm.com/docs/gitignore) files are essential to exclude large and sensitive data from version control. Each application or stack has its own `.gitignore` in its dedicated directory, typically containing the following:

```
# ignore all ENV
*.env

# ignore all data
data/*

# track specific file in data
!data/myApplication/someConfig.json
```

## Healthchecks
Docker [health checks](https://docs.docker.com/reference/dockerfile/#healthcheck) are valuable for monitoring container health. While some images include built-in health checks, they can also be added manually. To monitor the service's reachability on port `8888`, a `curl` or `wget` request (assuming the tools are included in the Docker image) can be incorporated into a `healtcheck` within the `docker-compose.yaml` file.

```yaml
healthcheck:
      test: curl --fail http://localhost:8888 || exit 1
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