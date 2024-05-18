<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Servarr
The *Servarr* stack includes containers `arr-overseerr`, `arr-radarr`, `arr-prowlarr` and `arr-sonarr`, facilitating media requesting, automated downloading, and management.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| overseerr | [requests.fjellhei.men](https://requests.fjellhei.men/) | Media requests | [linuxserver/overseerr](https://docs.linuxserver.io/images/docker-overseerr/) |
| sonarr | [sonarr.fjellhei.men](https://sonarr.fjellhei.men/) | TV series management | [linuxserver/sonarr](https://docs.linuxserver.io/images/docker-sonarr/) |
| radarr | [radarr.fjellhei.men](https://radarr.fjellhei.men/) | Movie management | [linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr/) |
| prowlarr | [prowlarr.fjellhei.men](https://prowlarr.fjellhei.men/) | Indexer management | [linuxserver/prowlarr](https://docs.linuxserver.io/images/docker-prowlarr/) |
| bazarr | [subtitles.fjellhei.men](https://subtitles.fjellhei.men/) | Subtitle management | [linuxserver/bazarr](https://docs.linuxserver.io/images/docker-bazarr/) |

*"Overseerr is a request management and media discovery tool built to work with your existing Plex ecosystem."*

*"Sonarr is a software that helps you find, download and organize TV series from various sources."*

*"Radarr is a software that helps you find and download movies from various sources and formats."*

*"Prowlarr is a tool that lets you manage your torrent trackers and usenet indexers for various PVR apps such as LazyLibrarian, Lidarr, Mylar3, Radarr, Readarr, and Sonarr."*

*"Bazarr is a companion application to Sonarr and Radarr that manages and downloads subtitles based on your requirements."*

## Configuration
Starting the application containers is straightforward. The primary task involves configuring the applications to seamlessly interact with each other. They are intended to operate together as follows:

1. Media (e.g., a specific movie) is requested on Overseerr.
2. The request is forwarded to Radarr (or Sonarr for TV shows).
3. Radarr contacts Prowlarr-managed indexers for missing media.
4. Radarr, upon finding the media, initiates a download on qBittorrent.
5. After downloading, Radarr renames and copies the appropriate files into the library.
6. Bazarr will, according to a language profile, search and add missing subtitles.

[TRaSH guides](https://trash-guides.info/) give good guidance on completing the described setup.

## docker-compose.yaml
```yaml-vue
{{ composeFiles['arr'] }}
```