# Core
The *Core* stack comprises essential containers for server infrastructure, including `core-npm`, `core-tailscale` and `core-npm`.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| NPM | [proxy.fjellhei.men](https://proxy.fjellhei.men/) | Reverse proxy | [nginxproxymanager.com](https://nginxproxymanager.com/) |
| Tailscale | / | Mesh VPN | [tailscale.com](https://tailscale.com/) |
| dnsmasq | / | DNS server | [dnsmasq.org](https://dnsmasq.org) |
| Portainer | [containers.fjellhei.men](https://containers.fjellhei.men/) | Container management UI | [portainer.io](https://www.portainer.io/) |

## Nginx Proxy Manager
*"Nginx Proxy Manager is a tool that lets you expose your private web services on your network with free SSL, Docker, and multiple users."*

::: warning Custom domain
To utilize NPM as a reverse proxy with SSL, it is recommended to obtain a custom domain. FreeDNS providers that offer free domains are also a viable option.
:::

At the core of the home server is Nginx Proxy Manager (NPM), functioning as a reverse proxy routing requests to various applications. Most applications are isolated within the docker network `proxy-network` but remain accessible through NPM. NPM exposes ports `80`/`443` (HTTP/S), handling all requests to `*.fjellhei.men` and directing them to the appropriate containers.

For guides and detailed instructions on setting up and configuring the reverse proxy based on your existing network, refer to the [documentation](https://nginxproxymanager.com/guide/#quick-setup).

## Tailscale
*"Tailscale is a zero config VPN that works on any platform, service, or runtime."*

To remotely access the home server without exposing it to the internet, Tailscale utilizes the WireGuard protocol, creating a secure network called "Tailnet" for connected devices. This allows seamless access to server apps from anywhere, using different IP addresses.

Consult the [documentation](https://tailscale.com/kb/1017/install) for instructions on how to set up and use Tailscale.

## dnsmasq
*"dnsmasq is a lightweight, easy to configure DNS forwarder, designed to provide DNS (and optionally DHCP and TFTP) services to a small-scale network."*

The home servers domain is pointed towards its private IP address to access the server under that domain. However, when remote and connected to tailscale, this private IP does not resolve. To circumwent that problem while still using the same domain, a running dnsmasq instance can added to tailscale as additional DNS server. In dnsmasq, the IP that the domain points to can be overwritten by its tailscale IP. Thus, when not connected to tailscale (and in the home network), the domain will resolve to the local IP of the server and when connected to tailscale a device querying the domain will instead get the servers tailscale IP as answer!

Consult the [documentation](https://tailscale.com/kb/1114/pi-hole) for details of this approach.

## Portainer
*"Portainer is a lightweight service delivery platform for containerized applications that can be used to manage Docker, Swarm, Kubernetes and ACI environments."*

SSH access to the server is restricted to devices with authorized keys, making server management challenging from unauthorized ones. Portainer fills this gap by offering a web-based UI for Docker container administration accessible from any device's browser.

## docker-compose.yaml
```yaml
---
name: core

services:

  proxy:
    image: jc21/nginx-proxy-manager:latest
    container_name: core-npm
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - /homeserver/core/data/npm/data:/data
      - /homeserver/core/data/npm/letsencrypt:/etc/letsencrypt
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    healthcheck:
      test: ["CMD", "/bin/check-health"]
      interval: 10s
      timeout: 3s
    restart: unless-stopped

  portainer:
    image: portainer/portainer:latest
    container_name: core-portainer
    volumes:
      - /homeserver/core/data/portainer/data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - proxy-network
    env_file:
      - /homeserver/.env
    privileged: true
    restart: unless-stopped

  tailscale:
    image: tailscale/tailscale:latest
    container_name: core-tailscale
    cap_add:
      - NET_ADMIN
      - NET_RAW
    volumes:
      - /homeserver/core/data/tailscale/config:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    network_mode: host
    env_file:
      - /homeserver/.env
      - /homeserver/core/tailscale.env
    environment:
      - TS_AUTH_ONCE=true
      - TS_HOSTNAME=fjellheimen
      - TS_STATE_DIR=/var/lib/tailscale
    healthcheck:
      test: tailscale ping fjellheimen || exit 1
      interval: 1m
      start_period: 20s
      timeout: 10s
      retries: 3
    restart: unless-stopped

  dnsmasq:
    image: dockurr/dnsmasq:latest
    container_name: core-dnsmasq
    volumes:
      - /homeserver/core/data/dnsmasq/:/etc/dnsmasq.d/
    network_mode: host
    cap_add:
      - NET_ADMIN
    restart: unless-stopped

networks:
  proxy-network:
    name: proxy-network

```