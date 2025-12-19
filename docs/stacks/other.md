# Miscellaneous applications

This section covers various standalone applications not included in other stacks.

## Audiobookshelf

*"Audiobookshelf is an open-source project that lets you stream and download audiobooks and podcasts from your own server."*

|                 |                                                             |
|-----------------|-------------------------------------------------------------|
| URL             | [audiobooks.fjellhei.men](https://audiobooks.fjellhei.men/) |
| Volumes         | `/config`, `/metadata`, `/audiobooks`, `/podcasts`          |
| Project website | [audiobookshelf.org](https://www.audiobookshelf.org/)       |


::: details Docker compose
<<< @/../stacks/audiobookshelf/compose.yaml
:::

## Forgejo

*"Forgejo is a self-hosted lightweight software forge. Easy to install and low maintenance, it just does the job."*

|                 |                                                 |
|-----------------|-------------------------------------------------|
| URL             | [code.fjellhei.men](https://code.fjellhei.men/) |
| Volumes         | `/data`                                         |
| Project website | [forgejo.org](https://forgejo.org/)             |

::: details Docker compose
<<< @/../stacks/forgejo/compose.yaml
:::

::: warning ssh port
To use ssh for git operations, open a port in your firewall (eg. `2222`), map it to `22` in the container and set `SSH_PORT` setting to `2222` when setting up the Forgejo instance. This enables users to connect to Forgejos built-in ssh server via git, while not interfering with the default ssh port on the machine.
:::

## Gramps Web

*"Gramps Web is a modern, feature-packed, free & open source web app for browsing and collaboratively editing genealogical databases."*

|                 |                                                                           |
|-----------------|---------------------------------------------------------------------------|
| URL             | [gramps.fjellhei.men](https://inventory.fjellhei.men/)                    |
| Volumes         | `/app/users`, `/app/indexdir`, `/app/thumbnail_cache`, `/app/cache`, `/app/secret`, `/app/media`,`/tmp`, `/root/.gramps/grampsdb` |
| Project website | [gramps-project/gramps-web](https://github.com/gramps-project/gramps-web) |

::: details Docker compose
<<< @/../stacks/gramps/compose.yaml
:::

## Homebox

*"HomeBox is a simple and fast web app for managing your home inventory, organization, and needs."*

|                 |                                                                     |
|-----------------|---------------------------------------------------------------------|
| URL             | [inventory.fjellhei.men](https://inventory.fjellhei.men/)           |
| Volumes         | `/data`                                                             |
| Project website | [sysadminsmedia/homebox](https://github.com/sysadminsmedia/homebox) |

::: details Docker compose
<<< @/../stacks/homebox/compose.yaml
:::

## iSponsorBlockTV

*"iSponsorBlockTV is a self-hosted application that connects to your YouTube TV app and automatically skips segments (like Sponsors or intros) in YouTube videos using the SponsorBlock ⁠ API."*

|                 |                                                                           |
|-----------------|---------------------------------------------------------------------------|
| Volumes         | `/app/data`                                                               |
| Project website | [dmunozv04/iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV) |

::: details Docker compose
<<< @/../stacks/isponsorblocktv/compose.yaml
:::

## Linkding

*"Linkding is a self-hosted bookmark manager that is designed be to be minimal, fast, and easy to set up using Docker."*

|                 |                                                                   |
|-----------------|-------------------------------------------------------------------|
| URL             | [links.fjellhei.men](https://links.fjellhei.men/)                 |
| Volumes         | `/etc/linkding/data`                                              |
| Project website | [sissbruecker/linkding](https://github.com/sissbruecker/linkding) |

::: details Docker compose
<<< @/../stacks/linkding/compose.yaml
:::

## Obsidian

*"Obsidian is a flexible and open app that lets you store, link, and publish your notes on any device."*

|                 |                                                                                |
|-----------------|--------------------------------------------------------------------------------|
| URL             | [notes.fjellhei.men](https://notes.fjellhei.men/)                              |
| Volumes         | `/config`, `/vaults`,                                                          |
| Project website | [linuxserver.io/obsidian](https://docs.linuxserver.io/images/docker-obsidian/) |

::: details Docker compose
<<< @/../stacks/obsidian/compose.yaml
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
<<< @/../stacks/plex/compose.yaml
:::

## Syncthing

*"Syncthing is a software that syncs files between two or more devices in real time, securely and privately."*

|                 |                                                 |
|-----------------|-------------------------------------------------|
| URL             | [sync.fjellhei.men](https://sync.fjellhei.men/) |
| Volumes         | `/config`, `/data`                              |
| Project website | [syncthing.net](https://syncthing.net/)         |

::: details Docker compose
<<< @/../stacks/syncthing/compose.yaml
:::

## Vaultwarden

*"Vaultwarden is a self-hosted server compatible with Bitwarden clients, written in Rust and with various features."*

|                 |                                                                       |
|-----------------|-----------------------------------------------------------------------|
| URL             | [passwords.fjellhei.men](https://passwords.fjellhei.men/)             |
| Volumes         | `/data`                                                               |
| Project website | [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden) |

::: details Docker compose
<<< @/../stacks/vaultwarden/compose.yaml
:::
