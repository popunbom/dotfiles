#!/usr/bin/env zsh

# Enable Vi-Edit Mode in ZLE(zsh-line-edit)
# REF: https://qiita.com/b4b4r07/items/8db0257d2e6f6b19ecb9
bindkey -v

# vi-cmd-mode を抜けるキーバインドを Ctrl-Q に変更
# REF: https://superuser.com/questions/351499/how-to-switch-comfortably-to-vi-command-mode-on-the-zsh-command-line
bindkey -M viins '^Q' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^L' clear-screen
bindkey -M viins '^U' kill-whole-line
