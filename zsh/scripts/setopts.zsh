#!/bin/zsh

# Enable history of change directory (cd)
setopt AUTO_PUSHD
# Enable command Auto-Fixing
setopt CORRECT
# Disable 'no match founds'
setopt NONOMATCH
# Enable completion dotfiles
setopt GLOBDOTS
# Disable '>' redirection to existing file
setopt NO_CLOBBER

# [History] Avoid recording commands starts with space
setopt HIST_IGNORE_SPACE
# [History] Share history between sessions
setopt SHARE_HISTORY
# [History] No duplicated entry
setopt HIST_SAVE_NO_DUPS
# [History] Append to history immediately
