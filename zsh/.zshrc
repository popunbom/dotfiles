#!/bin/zsh

source /etc/zshrc

autoload -Uz compinit && compinit

(( $+commands[sheldon] )) && eval "$(sheldon source)"

zsh-defer source "${ZDOTDIR}/scripts/bindkey.zsh"
zsh-defer source "${ZDOTDIR}/scripts/functions.zsh"
zsh-defer source "${ZDOTDIR}/scripts/fpaths.zsh"
zsh-defer source "${ZDOTDIR}/scripts/hooks.zsh"
zsh-defer source "${ZDOTDIR}/scripts/iterm2/shell_integration.zsh"
zsh-defer source "${ZDOTDIR}/scripts/prezto/completion.init.zsh"
