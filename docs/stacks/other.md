# Miscellaneous applications
This section covers various standalone applications not included in other stacks.

## Vaultwarden
*"Vaultwarden is a self-hosted server compatible with Bitwarden clients, written in Rust and with various features."*

|                 |                                                                       |
|-----------------|-----------------------------------------------------------------------|
| URL             | [passwords.fjellhei.men](https://passwords.fjellhei.men/)             |
| ENV             | /                                                                     |
| Volumes         | `/data`                                                               |
| Project website | [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden) |

::: details Docker compose
```yaml
---
name: other

services:

  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    volumes:
      - /homeserver/vaultwarden/data:/data
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    restart: unless-stopped

networks:
  proxy-network:
    external: true

```
:::

## Mealie
*"Mealie is a web app that lets you manage your recipes, import them from the web, and share them with your family."*

|                 |                                                   |
|-----------------|---------------------------------------------------|
| URL             | [meals.fjellhei.men](https://meals.fjellhei.men/) |
| ENV             | `ALLOW_SIGNUP` = `true`                          |
| Volumes         | `/app/data/`                                      |
| Project website | [mealie.io](https://mealie.io/)                   |

::: details Docker compose
```yaml
---
name: other

services:

  mealie:
    image: ghcr.io/mealie-recipes/mealie:latest
    container_name: mealie
    volumes:
      - /homeserver/mealie/data/config:/app/data/
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    environment:
      - ALLOW_SIGNUP=true
      - MAX_WORKERS=1
      - WEB_CONCURRENCY=1
    restart: unless-stopped

networks:
  proxy-network:
    external: true

```
:::

## Plex
*"Plex is an app that lets you organize, stream, and share your personal media and discover new content from various sources."*

|                 |                                             |
|-----------------|---------------------------------------------|
| URL             | [tv.fjellhei.men](https://tv.fjellhei.men/) |
| ENV             | /                                           |
| Volumes         | `/config`, `/movies`, `/tv`, `/music`       |
| Project website | [plex.tv](https://www.plex.tv/)             |

::: warning Network mode
Running Plex with ```network_mode: host``` appears to increase the chance that remote streaming works out of the box.
:::

::: details Docker compose
```yaml
---
name: other

services:

  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    volumes:
      - /homeserver/plex/data/config:/config
      - /xdrive/Media/Movies:/movies
      - /xdrive/Media/TV:/tv
      - /xdrive/Media/Music:/music
    network_mode: host
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:32400/web || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped
```
:::

## Syncthing
*"Syncthing is a software that syncs files between two or more devices in real time, securely and privately."*

|                 |                                                 |
|-----------------|-------------------------------------------------|
| URL             | [sync.fjellhei.men](https://sync.fjellhei.men/) |
| ENV             | /                                               |
| Volumes         | `/config`, `/data`                              |
| Project website | [syncthing.net](https://syncthing.net/)         |

::: details Docker compose
```yaml
---
name: other

services:

  syncthing:
    image: lscr.io/linuxserver/syncthing:latest
    container_name: syncthing
    volumes:
      - /homeserver/syncthing/data/config:/config
      - /xdrive/Syncthing:/data
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:8384 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```
:::

## Watchtower
*"Watchtower is a container-based solution that lets you update your containerized app by pushing a new image to the Docker Hub or your own registry."*

|                 |                                                                 |
|-----------------|-----------------------------------------------------------------|
| URL             | /                                                               |
| ENV             | <ul><li><code>WATCHTOWER_NOTIFICATION_URL</code> = <code>&lt;shoutrrr URL&gt;</code></li><li><code>WATCHTOWER_CLEANUP</code> = <code>true</code></li><li><code>WATCHTOWER_INCLUDE_STOPPED</code> = <code>true</code></li><li><code>WATCHTOWER_NOTIFICATIONS</code> = <code>shoutrrr</code></li><li><code>WATCHTOWER_SCHEDULE</code> = <code>0 0 4 * * SAT</code> </li></ul>                                                         |
| Volumes         | /                                                               |
| Project website | [containrrr.dev/watchtower](https://containrrr.dev/watchtower/) |


::: warning Notifications
To receive automatic notifications from Watchtower after Docker image updates, set `WATCHTOWER_NOTIFICATIONS` to `shoutrrr` and `WATCHTOWER_NOTIFICATION_URL` to a valid shoutrrr URL, such as one provided for [Telegram](https://containrrr.dev/shoutrrr/v0.8/services/telegram/).
:::

::: details Docker compose
```yaml
---
name: other

services:

  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
      - /homeserver/watchtower/.env
    environment:
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_INCLUDE_STOPPED=true
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      - WATCHTOWER_SCHEDULE=0 0 4 * * SAT
    restart: unless-stopped

networks:
  proxy-network:
    external: true

```
:::
