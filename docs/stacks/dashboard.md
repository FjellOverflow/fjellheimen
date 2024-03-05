# Dashboard
The *Dashboard* stack, which includes the `dashboard-homepage`, `dashboard-homepage-remote`, and `dashboard-glances` containers, offers dashboards displaying application shortcuts and server metrics.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| homepage | [fjellhei.men](https://fjellhei.men/) | Main dashboard | [gethomepage.dev](https://gethomepage.dev/latest/) |
| homepage | [remote.fjellhei.men](https://remote.fjellhei.men/) | Remote dashboard | [gethomepage.dev](https://gethomepage.dev/latest/) |
| glances | [metrics.fjellhei.men](https://metrics.fjellhei.men/) | Server metrics | [nicolargo/glances](https://nicolargo.github.io/glances/) |

*"Homepage is a static, fast, secure and proxied application dashboard with integrations for over 100 services and widgets."*

*"Glances is a tool that lets you monitor your system's CPU, memory, load, process list, network interface, disk I/O, IRQ, sensors and more."*

## Two homepage instances
As explained in the [Core](/stacks/core)  section, the home server is accessible both locally and remotely, with application URLs varying based on the access point. Consequently, two instances of homepage are necessary, each featuring different shortcuts. This is achieved by deploying nearly identical containers with distinct environments.

## Configuration
The content, layout, and appearance of homepage are configured using various YAML files. These files are tracked by Git, with all sensitive data outsourced into environment variables. Since both instances of homepage are configured identically apart from URLs, they share the same configuration files.

## ENV
Homepage features numerous shortcuts to various home server applications, necessitating a significant number of environment variables to define the corresponding URLs. These variables are located within tracked configuration files. It's important to note that certain variables apply to both instances of homepage, while others are specific to either the main or remote instance.

## docker-compose.yml
```yml
version: '3'

name: dashboard

services:
  homepage:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: dashboard-homepage
    volumes:
      - /homeserver/dashboard/data/homepage/config:/app/config
      - /homeserver/dashboard/data/homepage/assets:/app/public/assets
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /xdrive:/xdrive
      - /homeserver:/homeserver
    networks:
      - proxy-network
    env_file:
      - /homeserver/dashboard/.env
      - /homeserver/dashboard/homepage.env
    environment:
      - TZ=Europe/Tallinn
    restart: unless-stopped

  homepage-remote:
    image: ghcr.io/gethomepage/homepage:latest
    container_name: dashboard-homepage-remote
    volumes:
      - /homeserver/dashboard/data/homepage/config:/app/config
      - /homeserver/dashboard/data/homepage/assets:/app/public/assets
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /xdrive:/xdrive
      - /homeserver:/homeserver
    networks:
      - proxy-network
    env_file:
      - /homeserver/dashboard/.env
      - /homeserver/dashboard/homepage-remote.env
    environment:
      - TZ=Europe/Tallinn
    restart: unless-stopped

  glances:
    image: nicolargo/glances:latest
    container_name: dashboard-glances
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    environment:
      - GLANCES_OPT=-w
    privileged: true
    pid: host
    healthcheck:
      test: curl --fail -s http://localhost:61208 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

networks:
  proxy-network:
    name: proxy-network
```