# Torrents

The *Torrents* stack, containing the `torrents-qBittorrent` and `torrents-gluetun` containers, manages downloads over a VPN connection.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| gluetun     | / | VPN connection | [qdm12/gluetun](https://github.com/qdm12/gluetun) |
| qBittorrent | [downloads.fjellhei.men](https://downloads.fjellhei.men/) | Download torrents | [linuxserver/qbittorrent](https://docs.linuxserver.io/images/docker-qbittorrent/) |

*"Gluetun is a lightweight and versatile VPN client that supports multiple providers, protocols, and features."*

*"qBittorrent is a cross-platform software that lets you download and share files via the BitTorrent protocol."*

## Networking

The gluetun container functions as a tunnel, directing all of qBittorrent's traffic through it, by configuring `network_mode: "service:gluetun"` on qBittorrent. The gluetun container itself routes traffic through an OpenVPN connection. Setting `depends_on: gluetun` on qBittorrent ensures the container starts and operates only when the gluetun container is running properly.

::: warning Access WEBUI
We can set port `9090` on qbittorrent for WEBUI access. However, since qbittorrent utilizes gluetun for its network, to access that port, we need to expose it on the gluetun container and then access the WEBUI from the gluetun container.
:::

## ENV

### qBittorrent

| Variable     | Value  | Note                            |
|--------------|--------|---------------------------------|
| `WEBUI_PORT` | `9090` | Access qBittorrent from browser |

### gluetun

To select/configure the VPN provider and necessary environment variables, please refer to the [documentation](https://github.com/qdm12/gluetun-wiki/tree/main/setup/providers).

| Variable               | Value        | Note                               |
|------------------------|--------------|------------------------------------|
| `VPN_TYPE`             | `openvpn`    | Set VPN type to OpenVPN            |
| `VPN_SERVICE_PROVIDER` | `<provider>` | The VPN provider                   |
| `OPENVPN_USER`         | `<username>` | VPN username                       |
| `OWNED_ONLY`           | `yes`        | Use only servers owned by provider |

## docker-compose.yaml

<<< @/../torrents/docker-compose.yaml