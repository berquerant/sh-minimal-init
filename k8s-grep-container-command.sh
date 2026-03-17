#!/bin/bash

set -e
set -o pipefail

usage() {
    local -r name="${0##*/}"
    cat <<EOS >&2
${name} -- grep container commands

Usage:
  ${name} [KEYWORD]
EOS
}

case "$1" in
    "-h" | "--help")
        usage
        exit
        ;;
esac

extract() {
    yq '
.metadata.name as $name
| .kind as $kind
| (.metadata.namespace // "") as $namespace
| ..
| .containers?
| select(. != null)[]
| .name as $cname
| [$kind, $namespace, $name, $cname, (.command + .args)]
| select((. | length) == 5)
| {"kind": .[0], "namespace": .[1], "name": .[2], "container": .[3], "command": .[4]}'
}

readonly keyword="$1"

if [[ -z "$keyword" ]] ; then
    extract
    exit
fi

readonly __expr="select((.command | join(\" \") | test(\"${keyword}\")))"
extract | yq "$__expr"
