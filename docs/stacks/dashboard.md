<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Dashboard
The *Dashboard* stack, which includes the `dashboard-homepage` and `dashboard-glances` containers, offers dashboards displaying application shortcuts and server metrics.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| homepage | [fjellhei.men](https://fjellhei.men/) | Main dashboard | [gethomepage.dev](https://gethomepage.dev/latest/) |
| glances | [metrics.fjellhei.men](https://metrics.fjellhei.men/) | Server metrics | [nicolargo/glances](https://nicolargo.github.io/glances/) |

*"Homepage is a static, fast, secure and proxied application dashboard with integrations for over 100 services and widgets."*

*"Glances is a tool that lets you monitor your system's CPU, memory, load, process list, network interface, disk I/O, IRQ, sensors and more."*

## Configuration
The content, layout, and appearance of homepage are configured using various YAML files. These files, located in `dashboard/data/homepage/config`, are tracked by Git, with all sensitive data outsourced into environment variables.

## ENV
Homepage features numerous shortcuts to various home server applications, necessitating a significant number of environment variables to define the corresponding URLs. These variables are located within tracked configuration files.

## docker-compose.yaml
```yaml-vue
{{ composeFiles['dashboard'] }}
```