import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "Fjellheimen Docs",
  description: "Docker-based home server setup",
  head: [
    ['link', { rel: 'icon', href: '/favicon.svg' },],

    ['meta', { property: 'og:url', content: "https://docs.fjellhei.men" }],
    ['meta', { property: 'og:type', content: "website" }],
    ['meta', { property: 'og:title', content: "Fjellheimen" }],
    ['meta', { property: 'og:description', content: "Docker-based home server setup" }],
    ['meta', { property: 'og:image', content: "https://docs.fjellhei.men/preview.png" }],
    ['meta', { name: 'twitter:card', content: "summary_large_image" }],
    ['meta', { property: 'twitter:domain', content: "docs.fjellhei.men" }],
    ['meta', { property: 'twitter:url', content: "https://docs.fjellhei.men" }],
    ['meta', { name: 'twitter:title', content: "Fjellheimen" }],
    ['meta', { name: 'twitter:description', content: "Docker-based home server setup" }],
    ['meta', { name: 'twitter:image', content: "https://docs.fjellhei.men/preview.png" }],
  ],
  lastUpdated: true,
  themeConfig: {
    editLink: {
      pattern: 'https://github.com/FjellOverflow/fjellheimen/edit/main/docs/:path',
      text: 'Edit this page on GitHub'
    },
    nav: [
      { text: 'Home', link: '/' },
      { text: 'About', link: '/about' },
    ],

    sidebar: [
      {
        text: 'Introduction',
        collapsed: false,
        items: [
          { text: 'Getting started', link: '/introduction/getting-started' },
          { text: 'Overview', link: '/introduction/overview' },
          { text: 'Resources', link: '/introduction/resources' },
        ]
      },
      {
        text: 'Host machine',
        collapsed: false,
        items: [
          { text: 'Overview', link: '/host/overview' },
          { text: 'Setting up host', link: '/host/setting-up-host' },
          { text: 'Maintenance', link: '/host/maintenance'},
        ]
      },
      {
        text: 'Usage',
        collapsed: false,
        items: [
          { text: 'Overview', link: '/usage/overview' },
          { text: 'Adding applications', link: '/usage/add-new-app' },
          { text: 'Set up ENV', link: '/usage/set-up-env' },
          { text: 'Manage containers', link: '/usage/manage-containers' },
        ]
      },
      {
        text: 'Stacks',
        collapsed: false,
        items: [
          { text: 'Overview', link: '/stacks/overview' },
          { text: 'Core', link: '/stacks/core' },
          { text: 'Dashboard', link: '/stacks/dashboard' },
          { text: 'Immich', link: '/stacks/immich' },
          { text: 'Servarr', link: '/stacks/servarr' },
          { text: 'Torrents', link: '/stacks/torrents' },
          { text: 'Other', link: '/stacks/other'}
        ]
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/FjellOverflow/fjellheimen' }
    ],

    search: {
      provider: 'local'
    }
  },
  markdown: {
     theme: { light: 'github-light', dark: 'nord' } 
  },
})
