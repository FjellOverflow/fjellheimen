#!/usr/bin/with-contenv bash
set -euo pipefail

if ! gpg --list-secret-keys | grep -q "sec"; then
    gpg --import /config/.gnupg-host/pubring.kbx 2>/dev/null || true
    gpg --import /config/.gnupg-host/trustdb.gpg 2>/dev/null || true
    find /config/.gnupg-host/private-keys-v1.d -name "*.key" -exec gpg --import {} \; 2>/dev/null || true
fi
