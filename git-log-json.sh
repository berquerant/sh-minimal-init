#!/bin/bash

d="$(cd "$(dirname "$0")" || exit 1 ; pwd)"
python "${d}/git-log-json.py" "$@"
