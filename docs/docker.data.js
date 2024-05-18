import fs from 'node:fs'

export default {
  watch: ['../*/docker-compose.yaml'],
  load(watchedFiles) {
    const stacks = {};

    for (const file of watchedFiles) {
        const pathParts = file.split('/');
        const stack = pathParts[pathParts.length - 2];
        stacks[stack] = fs.readFileSync(file, 'utf-8');
    }
    return stacks;
  }
}