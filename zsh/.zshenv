#!/bin/zsh

unsetopt GLOBAL_RCS

source "${ZDOTDIR}/scripts/paths.zsh"
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  source <(mise env)
fi

source "${ZDOTDIR}/scripts/aliases.zsh"
source "${ZDOTDIR}/scripts/exports.zsh"
source "${ZDOTDIR}/scripts/setopts.zsh"
