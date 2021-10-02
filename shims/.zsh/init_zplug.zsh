#!/usr/bin/env zsh

source "${HOME}/.zplug/init.zsh"

# Prezto
zplug "sorin-ionescu/prezto"
# enhancd
zplug "b4b4r07/enhancd", use:init.sh
ENHANCD_FILTER=fzf:fzy:peco
# zsh-autoenv
zplug "Tarrasch/zsh-autoenv"

zplug load  
# zplug load --verbose
