#!/bin/bash

__help() {
    cat <<EOS >&2
Usage: hurl OP [CURL_OPTS]
OP:
  s: http code only
  r: response headers
  v: verbose output
  j: as a json
  h: response headers as a json

Envs:
  DRY:
    dry run if set
EOS
}

main() {
    local op="$1"
    if [ -z "$1" ] ; then
        __help
        return 1
    fi

    shift
    local cmd='curl -s -o /dev/null'
    case "$op" in
        "s") cmd="${cmd} -w %{http_code}" ;;
        "r") cmd="${cmd} -D -" ;;
        "v") cmd="${cmd} -v" ;;
        "j") cmd="${cmd} -w %{json}" ;;
        "h") cmd="${cmd} -w %{header_json}" ;;
        *)
            __help
            return 1
            ;;
    esac
    cmd="${cmd} $*"
    if [ -n "$DRY" ] ; then
        echo "$cmd"
    else
        $cmd
    fi
}

main "$@"
