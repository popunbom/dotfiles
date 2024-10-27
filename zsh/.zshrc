#!/bin/zsh

source /etc/zshrc

autoload -Uz compinit && compinit

source "${ZDOTDIR}/scripts/aliases.zsh"
source "${ZDOTDIR}/scripts/bindkey.zsh"
source "${ZDOTDIR}/scripts/exports.zsh"
source "${ZDOTDIR}/scripts/fpaths.zsh"
source "${ZDOTDIR}/scripts/hooks.zsh"
source "${ZDOTDIR}/scripts/iterm2/shell_integration.zsh"
source "${ZDOTDIR}/scripts/prezto/completion.init.zsh"
source "${ZDOTDIR}/scripts/setopts.zsh"

eval "$(sheldon source)"

zsh-defer (( $+commands[mise] )) && eval "$(mise activate zsh)"
zsh-defer source "${ZDOTDIR}/scripts/functions.zsh"
