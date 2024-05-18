<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Core
The *Core* stack comprises essential containers for server infrastructure, including `core-npm`, `core-tailscale`, `core-dnsmasq` and `core-portainer`.

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

Depending on if one tries to connect to the home server from the local network or from remotely with Tailscale, the home server will have a different IP address (local IP vs Tailscale IP). To reuse the same domain name for both cases, *dnsmasq* can be employed as a DNS server. It [can be added to Tailscale](https://tailscale.com/kb/1114/pi-hole#step-3-set-your-raspberry-pi-as-your-dns-server) and resolve the domain name to the Tailscale IP of the home server if, and only if, the workstation is connected to the Tailscale network, otherwise the domain name will resolve as usual.

## Portainer
*"Portainer is a lightweight service delivery platform for containerized applications that can be used to manage Docker, Swarm, Kubernetes and ACI environments."*

SSH access to the server is restricted to devices with authorized keys, making server management challenging from unauthorized ones. Portainer fills this gap by offering a web-based UI for Docker container administration accessible from any device's browser.

## docker-compose.yaml
```yaml-vue
{{ composeFiles['core'] }}
```