#!/bin/zsh

alias reload='source ${HOME}/.zshrc'

if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi

bindkey -e # emacs
bindkey -r '^T' # disable C-T
setopt print_eight_bit # display Japanese file name
setopt no_beep
unsetopt BEEP
setopt ignore_eof # C-d does not exit zsh
setopt interactive_comments # after '#' is also a comment in command line
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_no_store # ignore 'history' command
setopt hist_verify
setopt hist_expand
setopt hist_reduce_blanks
setopt extended_history
setopt inc_append_history
setopt no_tify
setopt share_history
# completion
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
setopt correct
zstyle ':completion:*' menu select

# additional zshrc
if [ -f "${HOME}/.zshrc2" ] ; then
    source "${HOME}/.zshrc2"
fi
