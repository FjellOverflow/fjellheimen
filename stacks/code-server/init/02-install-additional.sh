#!/usr/bin/with-contenv bash

set -euo pipefail

PKGS=(zsh tmux)
MISSING=()

for pkg in "${PKGS[@]}"; do
    command -v "$pkg" &>/dev/null || MISSING=("${MISSING[@]}" "$pkg")
done

if [ ${#MISSING[@]} -gt 0 ]; then
    apt-get update -qq
    apt-get install -y --no-install-recommends "${MISSING[@]}"
fi

usermod -s /usr/bin/zsh abc
