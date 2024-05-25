<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

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
```yaml-vue
{{ composeFiles['vaultwarden'] }}
```
:::

## Immich
*"Self-hosted photo and video management solution."*

|                 |                                                                              |
|-----------------|------------------------------------------------------------------------------|
| URL             | [photos.fjellhei.men](https://photos.fjellhei.men/)                          |
| ENV             | /                                                                            |
| Volumes         | `/usr/src/app/upload`, `usr/src/app/external:ro`, `/var/lib/postgresql/data` |
| Project website | [immich.app](https://immich.app/)                                            |

::: details Docker compose
```yaml-vue
{{ composeFiles['immich'] }}
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
```yaml-vue
{{ composeFiles['mealie'] }}
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
```yaml-vue
{{ composeFiles['plex'] }}
```
:::

## Audiobookshelf
*"Audiobookshelf is an open-source project that lets you stream and download audiobooks and podcasts from your own server."*

|                 |                                                             |
|-----------------|-------------------------------------------------------------|
| URL             | [audiobooks.fjellhei.men](https://audiobooks.fjellhei.men/) |
| ENV             | /                                                           |
| Volumes         | `/config`, `/metadata`, `/audiobooks`                       |
| Project website | [audiobookshelf.org](https://www.audiobookshelf.org/)       |

::: details Docker compose
```yaml-vue
{{ composeFiles['audiobookshelf'] }}
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
```yaml-vue
{{ composeFiles['syncthing'] }}
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
```yaml-vue
{{ composeFiles['watchtower'] }}
```
:::
