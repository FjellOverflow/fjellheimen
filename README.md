<h1 align="center">Fjellheimen</h1>

<p align="center">
  Docker-based home server setup
</p>

<div align="center">
  <img src="./preview.png" width="60%"/>
</div>

<p align="center">
  <a href="#repository">Repository</a> |
  <a href="#setup">Setup</a> |
  <a href="#stacks">Stacks</a> |
  <a href="#jobs">Jobs</a>
</p>

## Repository

| Directory | Content                                                                   |
| --------- | ------------------------------------------------------------------------- |
| `setup/`  | Ansible playbook that provisions the host                                 |
| `stacks/` | One directory per Docker Compose stack (`compose.yaml` + `.env`)          |
| `data/`   | Git-ignored application data                                              |
| `jobs/`   | Maintenance scripts, run on a cron schedule (backup, offsite, startup, …) |

## Setup

The host can be set up through the idempotent [Ansible](https://docs.ansible.com/) playbook (`setup/`), which runs the roles from [`FjellOverflow/ansible-fedora-setup`](https://github.com/FjellOverflow/ansible-fedora-setup) and some extra tasks, such as installing [Docker](https://docs.docker.com/), [Borg](https://borgbackup.readthedocs.io/), [Tailscale](https://tailscale.com/), configuring [UFW](https://help.ubuntu.com/community/UFW), cronjobs, a [Samba](https://www.samba.org/) share, passwordless sudo, SSH auth, and creating the `/fjellheimen` symlink. See [`setup/README.md`](setup/README.md) for usage.

## Stacks

Everything is served under `*.fjellhei.men`: with a single *wildcard DNS record* pointing at the public IP, [Traefik](https://traefik.io/) (the `reverse-proxy` stack) is the only entrypoint, and [VoidAuth](https://github.com/voidauth/voidauth) puts OIDC SSO in front of (almost) every service.

The `reverse-proxy` stack owns a bridge network (`subnet 172.20.0.0/16`); every other stack joins it with `external: true`. Traefik itself is pinned to the static IP `172.20.0.2` (load-bearing, see [_Adding a stack_](#adding-a-stack)).

A few services bypass the proxy entirely and use host networking, so they are reached directly on their own ports (opened in UFW) with no Traefik routing or SSO.

### Adding a stack

1. Create `stacks/<name>/compose.yaml` and join the reverse-proxy network as `external: true`
2. Create data dir before first container run (`data/<name>/`), otherwise Docker creates it root-owned and the container fails to write
3. Add the Traefik labels:
   ```yaml
   traefik.enable: "true"
   traefik.http.routers.<name>.rule: Host(`<name>.fjellhei.men`)
   traefik.http.routers.<name>.entrypoints: websecure
   traefik.http.routers.<name>.tls.certresolver: letsencrypt
   traefik.http.routers.<name>.middlewares: voidauth@docker
   traefik.http.services.<name>.loadbalancer.server.port: "<container-port>"
   ```
4. If the container calls a `*.fjellhei.men` URL itself (e.g. OIDC to `auth.`), add:
   ```yaml
   extra_hosts:
     - auth.fjellhei.men:172.20.0.2
   ```
   A container resolving `auth.fjellhei.men` normally would route out of the Docker network, so pinning the hostname to Traefik's internal IP keeps it on the reverse-proxy network.

### Volumes

| Mount          | Backup    | Content                                        |
| -------------- | --------- | ---------------------------------------------- |
| `/fjellheimen` | Automatic | Server state: `data/`, `stacks/`, `jobs/`      |
| `/xdrive`      | Manual    | Personal data: `Media/`, `Data/`, `Syncthing/` |

While both storages are mounted to various containers, they fulfill different purposes: `/fjellheimen` is the data specific to the server and its applications, `/xdrive` is external data, such as media or personal data, that may be consumed by the server, but also exists independent of it, were the server to disappear.

`/fjellheimen` is also exposed as a *read-only Samba share*, for direct file access without SSH.

### Environment

ENV is layered (later overrides earlier):

- global `stacks/.env` (`PUID`, `PGID`, `TZ`)
- per-stack `.env` (`stacks/<name>/.env`)
- `environment:` block in `stacks/<name>/compose.yaml`.

Secrets and host-specific values go in `.env` files (git-ignored, usually have a `.env.example` template). Non-sensitive values live in the compose `environment:` block.

### Authentication

All apps are protected by SSO auth, by having `traefik.http.routers.qbittorrent.middlewares: voidauth@docker` set as container label. Even when an app natively integrates OIDC as a login method, the user only ever needs to authenticate once, since VoidAuth acts as a Traefik forward-auth middleware.

#### Disable authentication

Some apps, notably those with native Android clients, cannot have SSO protection enabled, since mobile clients cannot authenticate themselves through a browser redirect. Removing SSO auth is as easy as removing the `voidauth@docker` from the proxy middlewares.

#### Bypass basic auth

Even while protected by SSO auth, some apps have built-in authentication that can't be disabled. Effectively useless in this setup, basic auth can be bypassed by automatically sending the credentials as a header with the proxy:

```yaml
labels:
  traefik.http.routers.qbittorrent.middlewares: voidauth@docker,qbittorrent-auth
  # where QBITTORRENT_BASIC_AUTH is set to "Basic <base64(user:password)>"
  traefik.http.middlewares.qbittorrent-auth.headers.customrequestheaders.Authorization: ${QBITTORRENT_BASIC_AUTH}
```

### Updates

Image versions are kept up-to-date by [Renovate](https://github.com/renovatebot/renovate) (`stacks/renovate`), which autodiscovers the repo and opens PRs bumping pinned image tags. Update rules live in the root `renovate.json` and all updates need to be reviewed and merged manually.

## Jobs

Common maintenance tasks have their own script in `jobs/`, some of which are automatically called on a cron schedule. They are configured with their own ENV (`jobs/.env`).

| Job              | When      | Does                                                             |
| ---------------- | --------- | ---------------------------------------------------------------- |
| `on_startup`     | `@reboot` | Waits for containers to settle, then sends a status notification |
| `offsite_backup` | Thu 04:00 | Backs up data to remote with `rsync`                             |
| `backup`         | Fri 04:00 | Backs up data locally with `borg`                                |
| `mirror`         | manual    | Mirrors data to local drive                                      |
| `notify`         | manual    | Sends notification                                               |
