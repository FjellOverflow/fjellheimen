import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "Fjellheimen",
  description: "Home server documentation",
  head: [
    ['link', { rel: 'icon', href: '/favicon.svg' }],
  ],
  lastUpdated: true,
  themeConfig: {
    editLink: {
      pattern: 'https://github.com/FjellOverflow/homeserver/edit/main/docs/:path',
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
          { text: 'Shell aliases', link: '/host/shell-aliases'},
          { text: 'Maintenance', link: '/host/maintenance'},
          { text: 'Cronjobs', link: '/host/cronjobs' }
        ]
      },
      {
        text: 'Usage',
        collapsed: false,
        items: [
          { text: 'Overview', link: '/usage/overview' },
          { text: 'Set up ENV', link: '/usage/set-up-env' },
          { text: 'Manage containers', link: '/usage/manage-containers' },
          { text: 'Add new app', link: '/usage/add-new-app' },
        ]
      },
      {
        text: 'Stacks',
        collapsed: false,
        items: [
          { text: 'Overview', link: '/stacks/overview' },
          { text: 'Core', link: '/stacks/core' },
          { text: 'Dashboard', link: '/stacks/dashboard' },
          { text: 'Servarr', link: '/stacks/servarr' },
          { text: 'Torrents', link: '/stacks/torrents' },
          { text: 'Other', link: '/stacks/other'}
        ]
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/FjellOverflow/homeserver' }
    ],

    search: {
      provider: 'local'
    }
  }
})
