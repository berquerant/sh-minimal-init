#!/bin/bash

set -e

d="$(cd "$(dirname "$0")" || exit 1; pwd)"
. "${d}/common.sh"

message() {
    cecho green "$1"
}

is_dry=false
if [ -n "$DRY" ] ; then
    is_dry=true
fi

exec_or_dry() {
    run_or_dry "$1" "${is_dry}"
}

is_rm=false
if [ -n "$1" ] ; then
    is_rm=true
fi

if "$is_rm" ; then
    message "Remove symbolic links on the home direcory"
else
    message "Make symbolic links on the home directory"
fi

exec_query "Are you sure?" "Bye!"

if "$is_rm" ; then
    exec_or_dry "rm -f ${HOME}/sh-minimal-init"
else
    exec_or_dry "ln -snvf ${d} ${HOME}/sh-minimal-init"
fi

dotfiles=(
    .bashrc
    .zshrc
    .subversion
)

if "$is_rm" ; then
    message "Remove dotfiles on the home direcory"
else
    message "Install dotfiles on the home directory"
fi

for df in "${dotfiles[@]}" ; do
    if "$is_rm" ; then
        exec_or_dry "rm -f ${HOME}/${df}"
    else
        exec_or_dry "ln -snvf ${d}/${df} ${HOME}/"
    fi
done

if "$is_rm" ; then
    message "Dotfiles removed!"
else
    message "Dotfiles installed!"
fi
