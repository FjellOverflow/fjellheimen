# Manage containers
Containers are generally managed using standard Docker commands and the supplementary wrapper, `fjell`, as described in [Shell Aliasese](/host/shell-aliases#docker-wrapper).

## Creation
All services are defined in `myApplication/docker-compose.yml`. To start single containers, use `fjell up myApplication`; for entire stacks, use `fjell up myStack`. This command creates any missing containers and starts them.

## Starting and stopping
Initiate container startup or shutdown with `fjell start` and `fjell stop`, respectively. Note that to stop an entire stack without deleting its containers, each container must be stopped individually. Using `fjell down myStack` will stop and remove the containers.

## Removal
Remove containers simply with `fjell rm myApplication` after stopping them. Entire stacks can be removed using `fjell down myStack`.

## Updates
Docker images are kept up to date with [Watchtower](/stacks/other#watchtower), an automated solution that periodically checks for newer images and updates containers. Containers excluded from automatic updates should be manually updated:

- Stop the running container with `fjell stop myApplication`
- Back up data in `myApplication/data`
- Review the changelog of the new application version
- Set the new image tag in`myApplication/docker-compose.yml` or pull the new image with `docker pull`
- Remove the old container with `fjell rm myApplication`
- Start the new container with `fjell up myAppliction`
