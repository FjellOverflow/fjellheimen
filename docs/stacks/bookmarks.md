# Bookmarks
The *Bookmarks* stack, including `bookmarks-readeck` and `bookmarks-slash`
organizes links as bookmarks, shortcuts, collections and read-later articles.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| readeck | [readeck.fjellhei.men](https://readeck.fjellhei.men/) | Read articles later | [readeck.org](https://readeck.org/en/) |
| slash | [links.fjellhei.men](https://links.fjellhei.men/) | Aggregate links | [yourselfhosted/slash](https://github.com/yourselfhosted/slash) |

*"Readeck helps you collect, organize, highlight and export web content you want to revisit."*

*"Slash is an open source, self-hosted links shortener and sharing platform."*

## Browser Extensions
Both applications offer useful browser extensions for flawless integration into day-to-day web activities.

## docker-compose.yaml
```yaml
---
name: bookmarks

services:

  readeck:
    image: codeberg.org/readeck/readeck:latest
    container_name: bookmarks-readeck
    volumes:
      - /homeserver/bookmarks/data/readeck:/readeck
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    environment:
      - READECK_USE_X_FORWARDED=true
    healthcheck:
      test: ["CMD", "/bin/readeck", "healthcheck", "-config", "config.toml"]
      interval: 30s
      timeout: 2s
      retries: 3
    restart: unless-stopped

  slash:
    image: yourselfhosted/slash:latest
    container_name: bookmarks-slash
    volumes:
      - /homeserver/bookmarks/data/slash:/var/opt/slash
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: wget -nv -t1 --spider http://localhost:5231 || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

networks:
  proxy-network:
    external: true
```