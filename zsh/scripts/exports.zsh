#!/bin/zsh

# Editor
export EDITOR="vim"
export VISUAL="vim"
export GUI_EDITOR="code"

# fzf
export FZF_CTRL_R_OPTS="--height 100% --prompt='[History]> '"

# ghq
export GHQ_ROOT="${HOME}/.ghq"

# k9s
export K9S_EDITOR='env LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 vim'

# Golang
export GOPATH="${HOME}/.golang"
export GOBIN="${GOPATH}/bin"

# Python
export PYTHONUNBUFFERED=1
export PIPENV_VENV_IN_PROJECT="true"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=106"
