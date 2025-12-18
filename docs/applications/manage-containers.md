# Manage containers

Containers are generally managed using standard Docker commands, so refer to the [Docker docs](https://docs.docker.com/) for further guidance. When available, the containers and stacks, including their ENV can be nicely managed with [Dockge](/stacks/core#dockge)

## Create containers

All services are defined in `stacks/myApplication/compose.yaml`. To create a service use `cd stacks/myApplication && docker compose up -d`.

## Starting and stopping

Stop a running container with `docker stop myApplication` and restart it with `docker stop myApplication`. Note that to stop an entire stack without deleting its containers, each container must be stopped individually.

## Removal

Remove a stopped container with `docker rm myApplication` after stopping it. Remove an entire stack with `cd stacks/myApplication && docker compose down`.

## Updates

Docker images can be updated in different ways, depending on personal taste. For a deeper dive into automated options, check out [this blog post](https://fjelloverflow.dev/posts/update-docker-containers/). They can also be manually updated:

- Stop the running container with `docker stop myApplication`
- Back up data in `data/myApplication`
- Review the changelog of the new application version
- Set the new image tag in`stacks/myApplication/compose.yaml` or pull the new image with `docker pull`
- Remove the old container with `docker rm myApplication`
- Start the new container with `docker compose up -d`
