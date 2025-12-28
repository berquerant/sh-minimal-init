export SH_MINIMAL_INIT_ROOT="$(readlink "${HOME}/sh-minimal-init")"
. "${SH_MINIMAL_INIT_ROOT}/common.sh"
ulimit -n 65535
# EDITOR_EMACS: emacs for editor command
export EDITOR="${EDITOR_EMACS:-emacs}"

#
# emacs
#
export EMACSD="${HOME}/.emacs.d"

#
# history
#
export HISTSIZE=10000
export HISTFILE=~/.history_zsh # avoid the tragedy that zsh loads histories
export SAVEHIST=1000000
export LESSHISTFILE=- # no histories for less

#
# aliases
#
alias e='${EDITOR_EMACS:-emacs}'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias watch='watch -cd'
alias less='less -R'
alias history='history -t "%F %T"'
alias l='ls -la'
alias t='cat'
alias y='echo'
alias v='vim'
alias f='less'
alias fn='less -N'
if which gdate >/dev/null 2>&1 ; then
    alias date='gdate'
fi
if which gsed >/dev/null 2>&1 ; then
    alias sed='gsed'
fi
if [ "$(uname)" = "Darwin" ] ; then
    alias pc='pbcopy'
    alias pp='pbpaste'
    alias ldd='otool -L'
fi

#
# git
#
export GIT_EDITOR="${EDITOR_EMACS:-emacs}"
alias g='git'
alias a='g a'
alias b='g b'
alias c='g c'
alias cb='c -b'
alias cc='c -'
alias d='g d'
alias ds='g ds'
alias m='g cm'
alias mm='m -m'
alias s='g s'
alias gg='g g'
groot() {
    cd "$(git root)"
}

#
# time
#
export DATETIME_FORMAT="%Y-%m-%d %H:%M:%S"
# print datetime as human readable format
# datetime [TIMESTAMP]
datetime() {
    if [ $# -eq 0 ]
    then
        date "+$DATETIME_FORMAT"
    else
        date -d "@$1" "+$DATETIME_FORMAT"
    fi
}

# print timestamp
# timestamp [DATETIME]
timestamp() {
    if [ $# -eq 0 ]
    then
        date +%s
    else
        date -d "$1" +%s
    fi
}

# print datetime sequence
# dateseq START_DATETIME N UNIT
dateseq() {
    local -r num="${1:-3}"
    local -r start="${2:-$(datetime)}"
    local unit="day"
    if [ $# -ge 3 ]
    then
        unit="$3"
    fi
    seq 0 $(expr "$num" - 1) | while read -r n ; do date -d "${start} ${n} ${unit}" "+${DATETIME_FORMAT}" ; done
}

#
# kubernetes
#
alias k='kubectl'
alias kk='kubectl kustomize'
alias kr='kubectl get --raw'
alias kv='kubectl -v=8'

#
# subversion
#
alias svnlog='${SH_MINIMAL_INIT_ROOT}/svnlog.sh'
alias svndiff='svn diff --diff-cmd ${SH_MINIMAL_INIT_ROOT}/svndiff.sh'
