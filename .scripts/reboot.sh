#!/usr/bin/env bash

# load ENV
CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $CURRENT_DIR/.env

NOTIFY=$CURRENT_DIR/notify.sh

RUNNING_CONTAINERS=$(docker ps --format "{{.Names}}")

$NOTIFY "Rebooting server." "Running containers:
$RUNNING_CONTAINERS"

systemctl reboot