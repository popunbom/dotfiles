#!/usr/bin/env zsh

# Init zplug
source ${ZDOTDIR}/init_zplug.zsh

# ALIAS: which
alias which='whence -p'
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# enhancd
source ~/.zplug/repos/b4b4r07/enhancd/init.sh
# iTerm2
[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# Load zsh scripts
source ${ZDOTDIR}/patch_prompt.zsh
source ${ZDOTDIR}/bindkey.zsh
source ${ZDOTDIR}/completions.zsh

# Load common scripts
source ${DOTFILES_DIR}/common/common.bash
source ${DOTFILES_DIR}/common/aliases.bash
source ${DOTFILES_DIR}/common/tex.bash
source ${DOTFILES_DIR}/common/file_encrypt.bash
source ${DOTFILES_DIR}/common/utils.bash

autoload -U compinit
compinit
