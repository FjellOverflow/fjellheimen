#!/bin/bash

set -euo pipefail

JOBS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$JOBS_DIR/.env"

JOB=$(basename -- "$0")
START=$SECONDS
REASON=""
MOUNTS=()

fail() {
    REASON=$1
    exit 1
}

mount_tmp() {
    MNT=$(mktemp -d)
    MOUNTS+=("$MNT")
    sudo mount "$@" "$MNT"
}

push() {
    local url_var="${JOB^^}_PUSH_URL"
    [ -n "${!url_var:-}" ] || return 0
    curl -fsS -m 10 --retry 3 -o /dev/null -G \
         --data-urlencode "status=$1" \
         --data-urlencode "msg=$2" \
         "${!url_var}" || true
}

on_exit() {
    local code=$?
    set +e

    for mnt in "${MOUNTS[@]}"; do
        mountpoint -q "$mnt" && sudo umount "$mnt"
        rmdir "$mnt"
    done

    local secs=$(( SECONDS - START )) took
    if (( secs >= 60 )); then
        took="$(( secs / 60 ))m$(( secs % 60 ))s"
    else
        took="${secs}s"
    fi

    if [ "$code" -eq 0 ]; then
        "$JOBS_DIR/notify" "$JOB finished in $took."
        push up "finished in $took"
    else
        local msg="$JOB FAILED${REASON:+: $REASON} (exit $code) after $took."
        "$JOBS_DIR/notify" "$msg"
        push down "$msg"
    fi

    exit "$code"
}
trap on_exit EXIT
