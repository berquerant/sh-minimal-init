#!/bin/bash

set -e

usage() {
    local -r name="${0##*/}"
    cat <<EOS >&2
${name} -- run ephemeral pod to execute adhoc command

Usage:
  ${name} IMAGE [CMD...]

Env:
  DRY:
    if true, dryrun

  POD:
    pod name
    default: ephemeral-pod

Example:
  ${name} busybox nslookup google.com
EOS
}

case "$1" in
    "-h" | "--help")
        usage
        exit
        ;;
    "")
        echo >&2 "image(arg0) is required"
        exit 1
        ;;
esac

readonly image="$1"
shift

run() {
    set -x
    exec kubectl run "${POD:-ephemeral-pod}" \
        --image="$image" \
        --command=true \
        --leave-stdin-open=true \
        --restart=Never \
        --grace-period=10 \
        --pod-running-timeout=10s \
        "$@"
}

if [[ "$DRY" = "true" ]] ; then
    run --dry-run=client -o yaml -- "$@"
else
    run --rm -it -- "$@"
fi
