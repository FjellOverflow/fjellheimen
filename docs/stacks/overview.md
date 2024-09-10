# Overview
The home server's different stacks reside in their respective directories, each housing `docker-compose.yaml`, ENV files, and configuration files. They are categorized as

- [Core](/stacks/core), the most essential applications:
    - **Nginx Proxy Manager**, a reverse proxy
    - **Portainer**, container management UI
    - **Tailscale**, a mesh VPN
- [Dashboard](/stacks/dashboard), providing application shortcuts and server metrics with:
    - **Glances**, server metrics
    - **Homepage**, main dashboard
- [Servarr](/stacks/servarr)
    - **Overseerr**, media requests
    - **Prowlarr**, indexer management
    - **Radarr**, movie management
    - **Sonarr**, TV series management
- [Torrents](/stacks/torrents)
    - **gluetun**, VPN connection
    - **qBittorrent**, torrent downloads
- [Other](/stacks/other)
    - **Audiobookshelf**, audiobooks and podcasts library
    - **Immich**, photo management
    - **Linkding**, bookmarks
    - **Mealie**, recipe management
    - **Plex**, movie & TV library
    - **Syncthing**, file syncing
    - **Vaultwarden**, password manager
    - **Watchtower**, Docker image updater
