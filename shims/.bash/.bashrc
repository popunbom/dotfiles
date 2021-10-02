#!/bin/bash

# Load: ~/.bashrc_orig
[[ -f "$HOME/.bashrc_orig" ]] && source $HOME/.bashrc_orig

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load common scripts
source ${DOTFILES_DIR}/common/common.bash
source ${DOTFILES_DIR}/common/aliases.bash
source ${DOTFILES_DIR}/common/tex.bash
source ${DOTFILES_DIR}/common/file_encrypt.bash
source ${DOTFILES_DIR}/common/utils.bash

source ~/.dotfiles/scripts/init.bash
