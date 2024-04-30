# Overview
The home server's different stacks reside in their respective directories, each housing `docker-compose.yaml`, ENV files, and configuration files. They are categorized as

- [Core](/stacks/core), the most essential applications:
    - **Nginx Proxy Manager**, a reverse proxy
    - **Tailscale**, a mesh VPN
    - **Portainer**, container management UI
- [Dashboard](/stacks/dashboard), providing application shortcuts and server metrics with:
    - **Homepage**, main dashboard
    - **Glances**, server metrics
- [Servarr](/stacks/servarr)
    - **Overseerr**, media requests
    - **Radarr**, movie management
    - **Sonarr**, TV series management
    - **Prowlarr**, indexer management
- [Torrents](/stacks/torrents)
    - **qBittorrent**, torrent downloads
    - **gluetun**, VPN connection
- [Other](/stacks/other)
    - **Vaultwarden**, password manager
    - **Mealie**, recipe management
    - **Plex**, movie & TV library
    - **Syncthing**, file syncing
    - **Watchtower**, Docker image updater
