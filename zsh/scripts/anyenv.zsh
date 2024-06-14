#!/bin/zsh

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
(( $+commands[pyenv] )) && eval "$(pyenv init -)"

# nodenv
export NODE_PATH="$(npm root -g)"
(( $+commands[nodenv] )) && eval "$(nodenv init -)"
