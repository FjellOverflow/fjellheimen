#!/usr/bin/with-contenv bash
set -euo pipefail

exec /usr/sbin/sshd -D -e -f /config/ssh/sshd_config
