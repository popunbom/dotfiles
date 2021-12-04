#!/bin/bash

# Editor settings
export EDITOR=vim
export VISUAL=vim
export GUI_EDITOR="code"

# fzf
export FZF_CTRL_R_OPTS="--height 100% --prompt='[History]> '"
# ghq
export GHQ_ROOT="${HOME}/.ghq"
# XXenv
export PYENV_ROOT="$HOME/.pyenv"
# Golang
export GOPATH="${HOME}/.golang"
# Python
export PYTHONUNBUFFERED=1
export PIPENV_VENV_IN_PROJECT="true"

# PATH
_path=(
  $HOME/.pyenv/bin
  $HOME/.jenv/bin
	$GOPATH/bin
  /usr/local/sbin
)
_new_path=""
for __path in ${_path[@]}; do
  _new_path="${_new_path}:${__path}"
done
export PATH="${_new_path#:}:${PATH}"

