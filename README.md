# sh-minimal-init

My minimal configuration of bash, zsh, git.

- Modifies built-in settings.
- No third-party packages installed.

## Scope

- bash
- zsh
- git
- subversion
- tmux
- kubernetes

## Usage

``` shell
make
make gitconfig
```

## Settings

### envvar: `EDITOR_EMACS`

Emacs command for `EDITOR`; default is `emacs`.

### file: `${HOME}/.zshrc2`

Additional zshrc; optional.
