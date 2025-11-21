# Maintenance

Maintenance is essential for keeping the server running reliably. Several tasks should be performed regularly, some of them facilitated by scripts in the `jobs` directory and automated via [cronjobs](#cronjobs).

## Jobs

### Overview

Predefined jobs are available in the `jobs` directory. Some require [ENV](https://wiki.archlinux.org/title/Environment_variables) variables to be configured in `jobs/.env`.

| Script                         | Action                        | ENV                                         |
|--------------------------------|-------------------------------|---------------------------------------------|
| `jobs/backup`                  | Create backup                 | `$SOURCE_FOLDER`, `$BACKUP_FOLDER`, `$USER` |
| `jobs/reboot`                  | Initiate reboot               |                                             |
| `jobs/check_public_ip`         | Inform about public IP change | `$DNS_PROVIDER`                             |
| `jobs/on_startup  `            | Inform about server start     | `$DRIVE_PATH`                               |
| `jobs/notify`                  | Send out notification         | `$TELEGRAM_CHAT_ID`, `$TELEGRAM_BOT_TOKEN`  |
| `jobs/check_container_updates` | Check for container updates   |                                             |

### Backup

Backs up the `/fjellheimen` directory to `$BACKUP_FOLDER` with [borg](https://www.borgbackup.org/). Notifications are sent before and after backup creation. *Recommended frequency: at least weekly.*

### Reboot

Sends notification and shuts down the server. *Recommended to run: after `backup`.*

### Check public IP

Verifies if the server's public IP has changed and notifies if so. *Recommended frequency: daily.*

### Startup

After server has successfully booted, notifies all running Docker containers and mounted drives specified by `$DRIVE_PATH`.

### Notify

::: warning Telegram Bot
To use this feature, you need to [create a Telegram bot](https://core.telegram.org/bots) and obtain its token. The process is simple, with plenty of online guides available.
:::

This script is a notification dispatcher that is called from other scripts (and is generally callable). Currently, it sends a Telegram message to a designated `$TELEGRAM_CHAT_ID` but it can be adjusted to use another notification provider.

## Cronjobs

To schedule jobs efficiently, use [cron](https://en.wikipedia.org/wiki/Cron) (and a [syntax helper](https://cron.help/)). It's best to setup jobs using `crontab -e` and execute them as a user rather than as root (avoiding permission issues). However, you can still use `sudo` within the scripts if needed. The crontab might contain:

::: tip Ansible setup
If the machine is set up with the provided Ansible playbooks, these cronjobs should already be set up.
:::


```
# On startup
@reboot /fjellheimen/jobs/on_startup
# Every day, 0:00 AM
0 0 * * * /fjellheimen/jobs/check_public_ip
# Fridays, 4:00 AM
0 4 * * FRI /fjellheimen/jobs/backup
# Saturdays, 4:00 AM
0 4 * * SAT /fjellheimen/jobs/check_container_updates
# Sundays, 4:00 AM
0 4 * * SUN /fjellheimen/jobs/reboot

```

## Updates

### System updates

Regularly update the OS for stability and security. Manual review and application of updates is recommended to avoid system issues.

### Docker image updates

Keeping Docker images updated is important. While manual updates are an option, a semi-automated solution, [dockcheck](https://github.com/mag37/dockcheck), is included by this setup. Critical or experimental images should be updated manually to avoid potential issues. Read more about [Updating Docker containers](https://fjelloverflow.dev/posts/update-docker-containers/) for deeper insights in the topic.
