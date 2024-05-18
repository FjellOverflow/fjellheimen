<script setup>
import { data as composeFiles } from '../docker.data.js'
</script>

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
```yaml-vue
{{ composeFiles['bookmarks'] }}
```