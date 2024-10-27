#!/bin/zsh

unsetopt GLOBAL_RCS

source "${ZDOTDIR}/scripts/paths.zsh"

(( $+commands[mise] )) && eval "$(mise activate zsh)"

source "${ZDOTDIR}/scripts/aliases.zsh"
source "${ZDOTDIR}/scripts/exports.zsh"
source "${ZDOTDIR}/scripts/setopts.zsh"
