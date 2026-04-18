#!/usr/bin/with-contenv bash

set -euo pipefail

if ! command -v sshd &>/dev/null; then
    apt-get update -qq
    apt-get install -y --no-install-recommends openssh-server
fi

mkdir -p /config/ssh

for type in rsa ecdsa ed25519; do
    if [ ! -f "/config/ssh/ssh_host_${type}_key" ]; then
        ssh-keygen -t "${type}" -f "/config/ssh/ssh_host_${type}_key" -N "" -q
    fi
done

if [ ! -f /config/ssh/sshd_config ]; then
    cat > /config/ssh/sshd_config <<EOF
Port 22
HostKey /config/ssh/ssh_host_rsa_key
HostKey /config/ssh/ssh_host_ecdsa_key
HostKey /config/ssh/ssh_host_ed25519_key
AuthorizedKeysFile .ssh/authorized_keys
EOF
fi

mkdir -p /run/sshd
