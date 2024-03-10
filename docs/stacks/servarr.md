# Servarr

The *Servarr* stack includes containers `arr-overseerr`, `arr-radarr`, `arr-prowlarr` and `arr-sonarr`, facilitating media requesting, automated downloading, and management.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| overseerr | [requests.fjellhei.men](https://requests.fjellhei.men/) | Media requests | [linuxserver/overseerr](https://docs.linuxserver.io/images/docker-overseerr/) |
| sonarr | [sonarr.fjellhei.men](https://sonarr.fjellhei.men/) | TV series management | [linuxserver/sonarr](https://docs.linuxserver.io/images/docker-sonarr/) |
| radarr | [radarr.fjellhei.men](https://radarr.fjellhei.men/) | Movie management | [linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr/) |
| prowlarr | [prowlarr.fjellhei.men](https://prowlarr.fjellhei.men/) | Indexer management | [linuxserver/prowlarr](https://docs.linuxserver.io/images/docker-prowlarr/) |

*"Overseerr is a request management and media discovery tool built to work with your existing Plex ecosystem."*

*"Sonarr is a software that helps you find, download and organize TV series from various sources."*

*"Radarr is a software that helps you find and download movies from various sources and formats."*

*"Prowlarr is a tool that lets you manage your torrent trackers and usenet indexers for various PVR apps such as LazyLibrarian, Lidarr, Mylar3, Radarr, Readarr, and Sonarr."*

## Configuration
Starting the application containers is straightforward. The primary task involves configuring the applications to seamlessly interact with each other. They are intended to operate together as follows:

1. Media (e.g., a specific movie) is requested on Overseerr.
2. The request is forwarded to Radarr (or Sonarr for TV shows).
3. Radarr contacts Prowlarr-managed indexers for missing media.
4. Radarr, upon finding the media, initiates a download on qBittorrent.
5. After downloading, Radarr renames and copies the appropriate files into the library.

[TRaSH guides](https://trash-guides.info/) give good guidance on completing the described setup.

## docker-compose.yml
```yml
version: "3"

name: arr

services:

  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    container_name: arr-sonarr
    volumes:
      - /homeserver/arr/data/sonarr/config:/config
      - /xdrive/Media/TV:/tv
      - /xdrive/Media/Downloads:/downloads
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:8989 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: arr-radarr
    volumes:
      - /homeserver/arr/data/radarr/config:/config
      - /xdrive/Media/Movies:/movies
      - /xdrive/Media/Downloads:/downloads
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:7878 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    container_name: arr-prowlarr
    volumes:
      - /homeserver/arr/data/prowlarr/config:/config
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:9696 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

  overseerr:
    image: lscr.io/linuxserver/overseerr:latest
    container_name: arr-overseerr
    volumes:
      - /homeserver/arr/data/overseerr/config:/config
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: curl --fail http://localhost:5055 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```