# Dashboard

The *Dashboard* stack includes the `dashboard-homepage` and `dashboard-glances` containers, for dashboards displaying application shortcuts and server metrics.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| glances | [metrics.fjellhei.men](https://metrics.fjellhei.men/) | Server metrics | [nicolargo/glances](https://nicolargo.github.io/glances/) |
| homepage | [fjellhei.men](https://fjellhei.men/) | Main dashboard | [gethomepage.dev](https://gethomepage.dev/latest/) |

*"Glances is a tool that lets you monitor your system's CPU, memory, load, process list, network interface, disk I/O, IRQ, sensors and more."*

*"Homepage is a static, fast, secure and proxied application dashboard with integrations for over 100 services and widgets."*


## Configuration

The content, layout, and appearance of homepage are configured using various YAML files; they are located in `dashboard/data/homepage/config` and are tracked by Git, with all sensitive data outsourced into environment variables.

## ENV

Homepage has shortcuts and widgets of various home server applications, needing a significant number of environment variables to define corresponding URLs or API keys. They are defined in `homepage.env` and are not tracked by git.

## docker-compose.yaml

<<< @/../vaultwarden/docker-compose.yaml