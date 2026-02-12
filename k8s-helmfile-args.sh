#!/bin/bash

set -e
set -o pipefail

usage() {
    local -r name="${0##*/}"
    cat <<EOS >&2
${name} -- construct helm arguments from helmfile

Usage:
  ${name} RELEASE_NAME [STATE]

Example:
  helm show values \$(${name} datadog)
  helm show chart \$(${name} sentry /path/to/helmfile.yaml)
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

readonly name="$1"
readonly state="${2:-helmfile.yaml}"
if [[ -z "$name" ]] ; then
    echo >&2 "name(arg0) is required"
    exit 1
fi

select_release() {
    yq ".releases[] | select(.name == \"${name}\")" "$state"
}

readonly chart="$(select_release | yq -r .chart)"
readonly version="$(select_release | yq -r .version)"

reponame="$(echo "$chart" | cut -d / -f 1)"
chartname="$(echo "$chart" | cut -d / -f 2)"

select_repository() {
    yq ".repositories[] | select(.name == \"${reponame}\")" "$state"
}

readonly url="$(select_repository | yq -r .url)"

# https://helmfile.readthedocs.io/en/latest/#oci-registries
if select_repository | yq -r .oci | grep -q "true" ; then
    echo "oci://${url}/${chartname} --version ${version}"
else
    echo "--repo ${url} ${chartname} --version ${version}"
fi
