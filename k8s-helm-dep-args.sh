#!/bin/bash

set -e
set -o pipefail

usage() {
    local -r name="${0##*/}"
    cat <<EOS >&2
${name} -- construct dependency arguments

Usage:
  ${name} CHART VERSION DEPNAME

Example:
  helm show values \$(${name} sentry/sentry 28.0.3 kafka)
EOS
}

case "$1" in
    "-h" | "--help")
        usage
        exit
        ;;
    "")
        usage
        exit 1
        ;;
esac

readonly chart="$1"
readonly version="$2"
readonly name="$3"
if [[ -z "$chart" ]] ; then
   echo >&2 "chart(arg0) is required"
   exit 1
fi
if [[ -z "$version" ]] ; then
    echo >&2 "version(arg1) is required"
    exit 1
fi
if [[ -z "$name" ]] ; then
    echo >&2 "name(arg2) is required"
    exit 1
fi

select_dep() {
    helm show chart "$chart" --version "$version" |\
        yq ".dependencies[] | select(.name == \"${name}\")"
}

depchart="$(select_dep | yq -r .name)"
deprepo="$(select_dep | yq -r .repository)"
depversion="$(select_dep | yq -r .version)"

if echo "$deprepo" | grep -q -E "^oci://" ; then
    echo "${deprepo}/${depchart} --version ${depversion}"
else
    echo "--repo ${deprepo} ${depchart} --version ${depversion}"
fi
