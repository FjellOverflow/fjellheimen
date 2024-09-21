<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Immich
The *Immich* stack is centered the immich photo management server and its depedants with a slideshow webapp as addition.

| Service | URL | Purpose | Project |
|--------------|-----|-------- |---------|
| immich       | [photos.fjellhei.men](https://photos.fjellhei.men/) | Image management | [immich.app](https://immich.app/) |
| immich-kiosk | [kiosk.fjellhei.men](https://kiosk.fjellhei.men/) | Image gallery | [damongolding/immich-kiosk](https://github.com/damongolding/immich-kiosk) |

*"Immich is a self-hosted photo and video management solution."*

*"Immich-kiosk is a web slideshow for Immich."*

## docker-compose.yaml
```yaml-vue
{{ composeFiles['immich'] }}
```