# Homeserver

Skeleton and configuration of a personal homeserver.

## Features
This setup comes packed with
- Applications for multimedia streaming, managing and downloading and more
- Server dashboards, Proxy management and push notifications
- Monitoring and managing docker containers and server metrics
- Tailscale for VPN access from remote
- Syncthing for cloud-like backups
- Maintenance scripts

## Structure

### Services
Each service or group of services `someService` has their own subdirectory which contains its docker run configuration in `someService/docker-compose.yml`, its environment variables in `someService/.env` and a `someService/data` folder containing all the services persistent files. The docker configuration will typically load the server-wide environment variables from `.env` and the service specific variables from `someService/.env` and further map one or more docker volumes into `someService/data`. For groups of services there may be a more finegraned distinction with `serviceGroup/service1.env`, `serviceGroup/service2.env`, ... and `serviceGroup/data/service1`, `serviceGroup/data/service2`, ...

### Jobs
Maintenance or other recurring tasks are defined by shell scripts in the `jobs` directory. They do things like rebooting the server, checking public IP changes or backing up the server. In `jobs/.env` sensitive configurations are defined and every job (should) load those environment variables prior to execution. To execute those jobs automatically at defined intervals, they can be added as cronjobs with `crontab -e` (avoid `sudo crontab -e`, it messes up file permissions).

```bash
# when server starts
@reboot /homeserver/jobs/on_startup

# every day 0:00 AM
0 0 * * * /homeserver/jobs/check_public_ip

# Friday 4:00 AM: backup server
0 4 * * FRI /homeserver/jobs/backup
```

### Server-wide ENV
`.env` in the root directory contains ENV vars that are usually valid across all containers, such as **PUID**/**PGID** or timezone.

### Aliases
`.aliases` in the root directory contains useful aliases for server administration. To use the, the file should be sourced in `.bashrc`/ `.zshrc`/ ...

```bash
[ -f /homeserver/.aliases ] && source /homeserver/.aliases
```
## .gitignores
Plenty of `.gitignores` and `.gitkeeps` are scattered across the repository. They ensure that

- `.env` files are kept out of git (as they contains sensitive data)
- data or configs, persisted by docker containers are kept out of git (sensitive/too big/irrelevant/...)
- certain empty folders are tracked by git, providing a skeleton to set up the server

Generally it should be made sure at all times that no credentials keys, public IPs or other sensitive data are being leaked by git.

## Setup
After cloning the repository it should be made sure the (physical) server (aka OS) is fully setup. For Ubuntu the script `.setup_ubuntu` can be used (at own risk) to install missing dependencies (eg. docker, ssh, samba, ...) and to do common setup tasks (enable firewall, disable ssh password auth, ...). Otherwise, consult the script to see what steps might be advisable or necessary and apply them manually before running this particular server setup.

Before starting up any docker containers, it should be made sure that all the directories that are mapped a docker volumes exist and that all missing `.env` files are created and filled with the necessary variables.

## Caveats
- the entire setup assumes that it is located/mounted under `/homeserver`. If not, the path must be adjusted across all configuration files.
- all files `server/data/homepage/config/*.yml` are tracked, as they contain the servers dashboard configuration (and all sensitive data is loaded from ENV)