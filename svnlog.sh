#!/bin/bash

set -e -o pipefail

svn log "$@" |\
    # find the revision line and first line of the commit message
    grep -E "^r[0-9]+" -A 2 |\
    # ignore empty lines
    grep -v -E '^$' |\
    # ignore delimiter lines
    grep -v -E '^--$' |\
    # combine the revision line and the message
    awk '/lines?$/ {
printf "%s | ", $0
getline
print
next
}'
