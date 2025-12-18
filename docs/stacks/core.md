# Core

The *Core* stack contains essential containers for server infrastructure: `core-npm` and `core-portainer`.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| NPM | [proxy.fjellhei.men](https://proxy.fjellhei.men/) | Reverse proxy | [nginxproxymanager.com](https://nginxproxymanager.com/) |
| Portainer | [containers.fjellhei.men](https://containers.fjellhei.men/) | Container management UI | [portainer.io](https://www.portainer.io/) |

## Nginx Proxy Manager

*"Nginx Proxy Manager is a tool that lets you expose your private web services on your network with free SSL, Docker, and multiple users."*

::: warning Custom domain
To use NPM as a reverse proxy with SSL, you should obtain a custom domain. FreeDNS providers that offer free domains are also a viable option.
:::

At the core of the home server is Nginx Proxy Manager (NPM), a reverse proxy that  routes requests to the applications. Most applications are isolated within the docker network `proxy-network` but remain accessible through NPM. NPM exposes ports `80`/`443` (HTTP/S), handles all requests to `*.fjellhei.men` and directs them to the appropriate container.

For guidance on setting up and configuring the reverse proxy based on your existing network, refer to the [documentation](https://nginxproxymanager.com/guide/#quick-setup).

## Portainer

*"Portainer is a lightweight service delivery platform for containerized applications that can be used to manage Docker, Swarm, Kubernetes and ACI environments."*

SSH access to the server is restricted to devices with authorized keys, making server management tricky without ssh. Portainer fills the gap, by offering a web-UI for Docker container administration accessible in the browser.

## docker-compose.yaml


<<< @/../stacks/core/compose.yaml