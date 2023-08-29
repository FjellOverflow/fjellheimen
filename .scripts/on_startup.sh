#!/usr/bin/env bash

# load ENV
CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $CURRENT_DIR/.env

# wait until docker started containers
sleep 2m

NOTIFY=$CURRENT_DIR/notify.sh

RUNNING_CONTAINERS=$(docker ps --format "{{.Names}}")
MEDIADRIVE_MOUNTED="/mediadrive is not mounted."
HOMESERVER_MOUNTED="/homeserver is not mounted."

if findmnt "/mediadrive" > /dev/null; then
    MEDIADRIVE_MOUNTED="/mediadrive is mounted."
fi

if findmnt "/homeserver" > /dev/null; then
    HOMESERVER_MOUNTED="/homeserver is mounted."
fi

$NOTIFY "Server started successfully." "Running containers:
$RUNNING_CONTAINERS

$MEDIADRIVE_MOUNTED
$HOMESERVER_MOUNTED"

