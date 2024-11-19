---
layout: home

hero:
  name: "Fjellheimen"
  text: "Home server"
  tagline: Documentation hub for Docker-based home server setup
  image:
    src: /favicon.svg
    alt: Fjellheimen logo
  actions:
    - theme: brand
      text: Get started
      link: /introduction/getting-started
    - theme: alt
      text: View on Github
      link: https://github.com/FjellOverflow/fjellheimen

features:
  - title: "IaC via docker-compose"
    icon: <svg style="width:65%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
          <path fill="#7fc5d9" d="M21.81 10.25c-.06-.04-.56-.43-1.64-.43c-.28 0-.56.03-.84.08c-.21-1.4-1.38-2.11-1.43-2.14l-.29-.17l-.18.27c-.24.36-.43.77-.51 1.19c-.2.8-.08 1.56.33 2.21c-.49.28-1.29.35-1.46.35H2.62c-.34 0-.62.28-.62.63c0 1.15.18 2.3.58 3.38c.45 1.19 1.13 2.07 2 2.61c.98.6 2.59.94 4.42.94c.79 0 1.61-.07 2.42-.22c1.12-.2 2.2-.59 3.19-1.16A8.3 8.3 0 0 0 16.78 16c1.05-1.17 1.67-2.5 2.12-3.65h.19c1.14 0 1.85-.46 2.24-.85c.26-.24.45-.53.59-.87l.08-.24zm-17.96.99h1.76c.08 0 .16-.07.16-.16V9.5c0-.08-.07-.16-.16-.16H3.85c-.09 0-.16.07-.16.16v1.58c.01.09.07.16.16.16m2.43 0h1.76c.08 0 .16-.07.16-.16V9.5c0-.08-.07-.16-.16-.16H6.28c-.09 0-.16.07-.16.16v1.58c.01.09.07.16.16.16m2.47 0h1.75c.1 0 .17-.07.17-.16V9.5c0-.08-.06-.16-.17-.16H8.75c-.08 0-.15.07-.15.16v1.58c0 .09.06.16.15.16m2.44 0h1.77c.08 0 .15-.07.15-.16V9.5c0-.08-.06-.16-.15-.16h-1.77c-.08 0-.15.07-.15.16v1.58c0 .09.07.16.15.16M6.28 9h1.76c.08 0 .16-.09.16-.18V7.25c0-.09-.07-.16-.16-.16H6.28c-.09 0-.16.06-.16.16v1.57c.01.09.07.18.16.18m2.47 0h1.75c.1 0 .17-.09.17-.18V7.25c0-.09-.06-.16-.17-.16H8.75c-.08 0-.15.06-.15.16v1.57c0 .09.06.18.15.18m2.44 0h1.77c.08 0 .15-.09.15-.18V7.25c0-.09-.07-.16-.15-.16h-1.77c-.08 0-.15.06-.15.16v1.57c0 .09.07.18.15.18m0-2.28h1.77c.08 0 .15-.07.15-.16V5c0-.1-.07-.17-.15-.17h-1.77c-.08 0-.15.06-.15.17v1.56c0 .08.07.16.15.16m2.46 4.52h1.76c.09 0 .16-.07.16-.16V9.5c0-.08-.07-.16-.16-.16h-1.76c-.08 0-.15.07-.15.16v1.58c0 .09.07.16.15.16" />
        </svg>
    details: "Effortlessly spin up, restart, and stop containerized apps. Swift configuration, easy reproduction."
    link: /usage/add-new-app
  - title: "Streamlined multimedia setup"
    icon: <svg style="width:65%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path fill="#7fc5d9" d="M9 13V5c0-1.1.9-2 2-2h9c1.1 0 2 .9 2 2v6h-3.43l-1.28-1.74a.14.14 0 0 0-.24 0L15.06 12c-.06.06-.18.07-.24 0l-1.43-1.75a.152.152 0 0 0-.23 0l-2.11 2.66c-.08.09-.01.24.11.24h6.34V15H11c-1.11 0-2-.89-2-2m-3 9v-1H4v1H2V2h2v1h2V2h2.39C7.54 2.74 7 3.8 7 5v8c0 2.21 1.79 4 4 4h4.7c-1.03.83-1.7 2.08-1.7 3.5c0 .53.11 1.03.28 1.5zM4 7h2V5H4zm0 4h2V9H4zm0 4h2v-2H4zm2 4v-2H4v2zm17-6v2h-2v5.5a2.5 2.5 0 0 1-5 0a2.5 2.5 0 0 1 3.5-2.29V13z" />
          </svg>
    details: "Request, manage, organize, and enjoy Movies, TV, Music, Books, and more."
    link: /stacks/servarr
  - title: Dashboards
    icon:  <svg style="width:65%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <path fill="#7fc5d9" d="M13 9V3h8v6zM3 13V3h8v10zm10 8V11h8v10zM3 21v-6h8v6z" />
            </svg>
    details: "Application shortcuts, bookmarks, statistics, and server metrics conveniently centralized."
    link: /stacks/dashboard
  - title: Batteries included
    icon: <svg style="width:65%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path fill="#7fc5d9" d="M16.67 4H15V2H9v2H7.33A1.33 1.33 0 0 0 6 5.33v15.33C6 21.4 6.6 22 7.33 22h9.33c.74 0 1.34-.6 1.34-1.33V5.33C18 4.6 17.4 4 16.67 4M11 20v-5.5H9L13 7v5.5h2" />
          </svg>
    details: "Reverse proxy, container management via web interface, and secure remote access through mesh VPN."
    link: /stacks/core
---

