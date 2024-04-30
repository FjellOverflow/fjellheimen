# Setting up environment
For the setup to be easily configured, environment (or ENV) variables are supplied from various `.env` files to the different services. We will assume the home server setup being located at `/homeserver` and note that we will then find `.env` files on various levels.

```
/homeserver
│ 
├── someStack
│   ├── data
│   │   ├── application1
│   │   └── application2
│   ├── docker-compose.yaml
│   ├── .gitignore
│   ├── .env
│   ├── application1.env
│   └── application2.env
│ 
├── .env
├── .gitignore
│ 
├── jobs
│   ├── someJob
│   ├── ...
│   └── .env
│ 
└── someApplication
    ├── data
    ├── docker-compose.yaml
    ├── .env
    └── .gitignore

```

## Different ENV levels
For some application there is up to 4 different levels of environment variables loaded after one another: [Global ENV](#global-env), [Stack ENV](#stack-env), [Local ENV](#local-env) and variables directly defined in the `docker-compose.yaml` file. As they are loaded after one another, variables from higher levels can be overridden on lower levels.

### Global ENV
The global ENV is located in `/homeserver/.env` and is by default loaded in every `docker-compose.yaml` (with exceptions). Hence it should contain universal variables that are shared across all applications. Example variables are User- and Group-ID or timezone.

```
PUID=1000
PGID=1000
TZ=Europe/Tallinn
```

### Stack ENV
The stack ENV only applies to stacks of multiple applications and is located in `/homeserver/myStack/.env`. It contains variables that are shared by the applications that are part of the stack.

### Local ENV
The local ENV contains variables specific to `myApplication` and mostly sensitive data like credentials. If the application is part of some stack the local ENV is in `/homeserver/myStack/myApplication.env`, if it is a standalone application it is in `/homeserver/myApplication/.env`. All non-sensitive ENV variables that configure the application should go into `docker-compose.yaml` to make sure they are tracked by version control.

## ENV in docker-compose
As stacks and applications are defined in `docker-compose.yaml` files, this is where the different ENV levels are loaded. The relevant section of a standalone will firstly load global ENV, then load local ENV and define additional ENV vars.
```yaml
...
    env_file:
      - /homeserver/.env
      - /homeserver/myApplication/.env
    environment:
      - HOSTNAME=fjellheimen
...
```
The same section of some application in stack may look like this, loading additionally the stack ENV:
```yaml
...
    env_file:
      - /homeserver/.env
      - /homeserver/myStack/.env
      - /homeserver/myStack/myApplication.env
    environment:
      - HOSTNAME=fjellheimen
...
```

## Git and ENV
As ENV variables commonly contain sensitive information, it is best practice to keep them out of version control. Hence there are `.gitignore` files scattered across the setup that exclude `.env` files from being tracked. The pattern is
- `/homeserver/.gitignore` excludes `/homeserver/.env`
- `/homeserver/myApplication/.gitignore` excludes `/homeserver/myApplication/.env`
- `/homeserver/myStack/.gitignore` excludes `/homeserver/myStack/*.env`
- `/homeserver/jobs/.gitignore` excludes `/homeserver/jobs/.env`

All ENV variables that should be tracked by Git (e.g. boolean flags) should instead be set in `docker-compose.yaml`'s `environment` section.