#!/bin/bash

#########
#  ENV  #
#########
# Prompt
export PS1="\[\033[38;5;33m\]\u\[$(tput sgr0)\]\[$(tput bold)\]@\[$(tput sgr0)\]\[\033[38;5;38m\]\H\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;148m\]\w\[$(tput sgr0)\]\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;251m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
# common exports
source ${DOTFILES_DIR}/common/exports.bash
####################
#  Invoke .bashrc  #
####################
source ${DOTDIR}/.bashrc
