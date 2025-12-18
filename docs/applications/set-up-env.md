# Setting up environment

For the setup to be easily configured, environment (ENV) variables are defined in various `.env` files for the different services. Assuming the home server setup being located at `/homeserver`, we can find `.env` files on various levels:

```
/homeserver
│  
├── stacks
│   ├── .env # global ENV
│   │
│   ├── stack1
│   │   ├── compose.yaml
│   │   └── .env # stack1 env
│   │   
│   └── stack2
│       ├── compose.yaml
│       └── .env # stack2 env
│ 
└── jobs
    ├── someJob
    ├── ...
    └── .env # jobs-specific ENV
```

## Different ENV levels

For some application there is up to 3 different levels of environment variables loaded after one another: [Global ENV](#global-env), [Stack ENV](#stack-env), and variables directly defined in the `compose.yaml` file. As they are loaded after one another, variables from higher levels can be overridden on lower levels.

### Global ENV

The global ENV is located in `/homeserver/stacks/.env` and is by default loaded in every `compose.yaml` (with exceptions). Hence it should contain universal variables that are shared across all applications. Example variables are User- and Group-ID or timezone.

```
PUID=1000
PGID=1000
TZ=Europe/Oslo
```

### Stack ENV

The stack ENV only applies to stacks of multiple applications and is located in `/homeserver/stacks/myStack/.env`. It contains variables that are shared by the applications that are part of the stack.

## ENV in compose.yaml

As stacks and applications are defined in `compose.yaml` files, this is where the different ENV levels are loaded. The relevant section of a stack will firstly load global ENV, then load local ENV and define additional ENV vars.

```yaml
...
    env_file:
      - /homeserver/stacks/.env
      - /homeserver/stacks/myStack/.env
    environment:
      - HOSTNAME=fjellheimen
...
```

## Git and ENV

As ENV variables commonly contain sensitive information, it is best practice to keep them out of version control. Hence the root `.gitignore` excludes all `.env` files from being tracked. All ENV variables that should be tracked by Git (e.g. boolean flags) should instead be set in `compose.yaml`'s `environment` section.