#!/bin/bash

# load ENV
CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $CURRENT_DIR/.env

NOTIFY=$CURRENT_DIR/notify.sh

SOURCE_FOLDER="/homeserver"
BACKUP_FOLDER="/home/user/Backups"
BACKUP_NAME="homeserver_backup_$(date +%Y%m%d%H%M).tar.gz"

$NOTIFY "Backup started." "Backing up $SOURCE_FOLDER to $BACKUP_FOLDER/$BACKUP_NAME."

rsync -az --delete "$SOURCE_FOLDER" "$BACKUP_FOLDER"

tar -czf "$BACKUP_FOLDER/$BACKUP_NAME" -C "$BACKUP_FOLDER" "$(basename "$SOURCE_FOLDER")"

rm -rf "$BACKUP_FOLDER/$(basename "$SOURCE_FOLDER")"

$NOTIFY "Backup finished." "Created $BACKUP_FOLDER/$BACKUP_NAME."