# Maintenance
Maintenance is essential for server reliability. Several tasks should be performed regularly, some of them facilitated by scripts in the `jobs` directory and automated via [cronjobs](#cronjobs).

## Jobs
### Overview
Predefined jobs are available in the `jobs` directory. Some require [ENV](https://wiki.archlinux.org/title/Environment_variables) variables to be configured in `jobs/.env`.

| Script                 | Action                        | ENV                                        |
|------------------------|-------------------------------|--------------------------------------------|
| `jobs/backup`          | Create compressed backup      | `$BACKUP_FOLDER `                          |
| `jobs/reboot`          | Initiate reboot               |                                            |
| `jobs/check_public_ip` | Inform about public IP change | `$DNS_PROVIDER`                            |
| `jobs/on_startup  `    | Inform about server start     | `$DRIVE_PATH`                              |
| `jobs/notify`          | Send out notification         | `$TELEGRAM_CHAT_ID`, `$TELEGRAM_BOT_TOKEN` |

### Backup
Copies and compresses the `/homeserver` directory, saving it to `$BACKUP_FOLDER`. Notifications are sent before and after backup creation. *Recommended frequency: at least weekly.*

### Reboot
Sends notification and shuts down the server. *Recommended to run: after `backup`.*

### Check public IP
Verifies if the server's public IP has changed and notifies if so. *Recommended frequency: daily.*

### Startup
Notifies upon server startup regarding running Docker containers and mounted drives specified by `$DRIVE_PATH`.

### Notify
::: warning Telegram Bot
To enable this feature, you need to [create a Telegram bot](https://core.telegram.org/bots) and obtain its token. The process is straightforward, with numerous online guides available.
:::

This script serves as a notification dispatcher that is called from other scripts (and is generally callable). Currently, it dispatches a Telegram message to a designated `$TELEGRAM_CHAT_ID` but can be adjusted to use another notification provider.

## Cronjobs
To schedule jobs efficiently, use [cron](https://en.wikipedia.org/wiki/Cron) with its [intuitive syntax](https://cron.help/). It's best to schedule jobs using `crontab -e` and execute them as a user rather than as root (avoiding permission issues). However, you can still use `sudo` within the scripts if needed. The crontab might contain:

```
# On startup
@reboot /homeserver/jobs/on_startup
# Every day, 0:00 AM
0 0 * * * /homeserver/jobs/check_public_ip
# Fridays, 4:00 AM
0 4 * * FRI /homeserver/jobs/backup
# Saturdays, 4:00 AM
0 4 * * SUN /homeserver/jobs/reboot
```

## Updates
### System updates
Regularly update the host OS for stability and security. Manual review and application of updates is recommended to avoid system issues. On Debian:
```bash
sudo apt update

# use this to review the new versions
apt list --upgradable
sudo apt upgrade -y
```

### Docker image updates
Keeping Docker images updated is crucial. While manual updates are an option, an automated solution like [Watchtower](/stacks/other#watchtower) is more convenient. Critical or experimental images should be updated manually to avoid potential issues.
