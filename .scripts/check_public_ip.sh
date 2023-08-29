#!/usr/bin/env bash

# load ENV
CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $CURRENT_DIR/.env

FILENAME=$CURRENT_DIR/.last_public_ip
NOTIFY=$CURRENT_DIR/notify.sh

LAST_IP="/"
CURRENT_IP=$(wget -O - -q https://checkip.amazonaws.com)

if [ -f "$FILENAME" ]; then
    LAST_IP=$(cat "$FILENAME")
else
    touch $FILENAME
fi

if [ ! "$LAST_IP" == "$CURRENT_IP" ]; then
    echo $CURRENT_IP > $FILENAME
    $NOTIFY "IP change detected." "Old IP: $LAST_IP
New IP: $CURRENT_IP"
fi