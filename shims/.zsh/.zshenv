#!/usr/bin/env zsh

# zmodload zsh/zprof && zprof

##########
# setopt #
##########
# Enable: History of Directory
setopt auto_pushd
# Enable: Command Auto-Fixing
setopt correct
# Disable: 'no matches found'
setopt nonomatch
# Enable: Completion dotfiles
setopt globdots
# Command with starts space character prevents from recording history 
setopt hist_ignore_space

# Load common
source ${DOTFILES_DIR}/common/exports.bash
