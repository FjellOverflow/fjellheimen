<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

# Bookmarks
The *Bookmarks* stack, including `bookmarks-readeck` and `bookmarks-linkding`
organizes links as bookmarks, collections and read-later articles.

| Service | URL | Purpose | Project |
|---------|-----|-------- |---------|
| readeck | [readeck.fjellhei.men](https://readeck.fjellhei.men/) | Read articles later | [readeck.org](https://readeck.org/en/) |
| linkding | [links.fjellhei.men](https://links.fjellhei.men/) | Aggregate links | [sissbruecker/linkding](https://github.com/sissbruecker/linkding) |

*"Readeck helps you collect, organize, highlight and export web content you want to revisit."*

*"Linkding is a self-hosted bookmark manager that is designed be to be minimal, fast, and easy to set up using Docker."*

## Browser Extensions
Both applications offer useful browser extensions for flawless integration into day-to-day web activities.

## docker-compose.yaml
```yaml-vue
{{ composeFiles['bookmarks'] }}
```