<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Miscellaneous applications

This section covers various standalone applications not included in other stacks.

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

## Homebox

*"HomeBox is a simple and fast web app for managing your home inventory, organization, and needs."*

|                 |                                                                     |
|-----------------|---------------------------------------------------------------------|
| URL             | [inventory.fjellhei.men](https://inventory.fjellhei.men/)           |
| ENV             | /                                                                   |
| Volumes         | `/data`                                                             |
| Project website | [sysadminsmedia/homebox](https://github.com/sysadminsmedia/homebox) |

::: details Docker compose
```yaml-vue
{{ composeFiles['homebox'] }}
```
:::

## iSponsorBlockTV

*"iSponsorBlockTV is a self-hosted application that connects to your YouTube TV app and automatically skips segments (like Sponsors or intros) in YouTube videos using the SponsorBlock ⁠ API."*

|                 |                                                                           |
|-----------------|---------------------------------------------------------------------------|
| ENV             | /                                                                         |
| Volumes         | `/app/data`                                                               |
| Project website | [dmunozv04/iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV) |

::: details Docker compose
```yaml-vue
{{ composeFiles['isponsorblocktv'] }}
```
:::

## Linkding

*"Linkding is a self-hosted bookmark manager that is designed be to be minimal, fast, and easy to set up using Docker."*

|                 |                                                                   |
|-----------------|-------------------------------------------------------------------|
| URL             | [links.fjellhei.men](https://links.fjellhei.men/)                 |
| ENV             | /                                                                 |
| Volumes         | `/etc/linkding/data`                                              |
| Project website | [sissbruecker/linkding](https://github.com/sissbruecker/linkding) |

::: details Docker compose
```yaml-vue
{{ composeFiles['linkding'] }}
```
:::

## Mealie

*"Mealie is a web app that lets you manage your recipes, import them from the web, and share them with your family."*

|                 |                                                   |
|-----------------|---------------------------------------------------|
| URL             | [meals.fjellhei.men](https://meals.fjellhei.men/) |
| ENV             | `ALLOW_SIGNUP` = `true`                           |
| Volumes         | `/app/data/`                                      |
| Project website | [mealie.io](https://mealie.io/)                   |

::: details Docker compose
```yaml-vue
{{ composeFiles['mealie'] }}
```
:::

## NocoDB

*"Open Source Airtable Alternative"*

|                 |                                                         |
|-----------------|---------------------------------------------------------|
| URL             | [database.fjellhei.men](https://database.fjellhei.men/) |
| Volumes         | `/usr/app/data`                                         |
| Project website | [nocodb.com](https://nocodb.com/)                       |

::: details Docker compose
```yaml-vue
{{ composeFiles['nocodb'] }}
```
:::

## Obsidian

*"Obsidian is a flexible and open app that lets you store, link, and publish your notes on any device."*

|                 |                                                                                |
|-----------------|--------------------------------------------------------------------------------|
| URL             | [notes.fjellhei.men](https://notes.fjellhei.men/)                              |
| Volumes         | `/config`, `/vaults`,                                                          |
| Project website | [linuxserver.io/obsidian](https://docs.linuxserver.io/images/docker-obsidian/) |

::: details Docker compose
```yaml-vue
{{ composeFiles['obsidian'] }}
```
:::

## Plex

*"Plex is an app that lets you organize, stream, and share your personal media and discover new content from various sources."*

|                 |                                             |
|-----------------|---------------------------------------------|
| URL             | [tv.fjellhei.men](https://tv.fjellhei.men/) |
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

## Syncthing

*"Syncthing is a software that syncs files between two or more devices in real time, securely and privately."*

|                 |                                                 |
|-----------------|-------------------------------------------------|
| URL             | [sync.fjellhei.men](https://sync.fjellhei.men/) |
| Volumes         | `/config`, `/data`                              |
| Project website | [syncthing.net](https://syncthing.net/)         |

::: details Docker compose
```yaml-vue
{{ composeFiles['syncthing'] }}
```
:::

## Vaultwarden

*"Vaultwarden is a self-hosted server compatible with Bitwarden clients, written in Rust and with various features."*

|                 |                                                                       |
|-----------------|-----------------------------------------------------------------------|
| URL             | [passwords.fjellhei.men](https://passwords.fjellhei.men/)             |
| Volumes         | `/data`                                                               |
| Project website | [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden) |

::: details Docker compose
```yaml-vue
{{ composeFiles['vaultwarden'] }}
```
:::