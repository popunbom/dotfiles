#!/bin/zsh

# Enable Vi-Edit mode
bindkey -v

bindkey -M viins '^Q' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^L' clear-screen
bindkey -M viins '^U' kill-whole-line

bindkey -M viins "^[[3~" delete-char
