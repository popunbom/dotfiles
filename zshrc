#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#



# Source Prezto.
if [[ -s  "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Enable: zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Enable: History of Directory
setopt auto_pushd
# Enable: Command Auto-Fixing
setopt correct
# Disable: 'no matches found'
setopt nonomatch

# Customize: zsh-autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"


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

# Prezto のテーマ 'paradox' 使用時に上に1行
# 空白が発生するのを防ぐため、PROMPT 環境変数
# を上書きする
PROMPT='${(e)$(prompt_paradox_build_prompt)}
 ${editor_info[keymap]} '


# Import from .bashrc
source ${HOME}/.bashrc


# ALIAS: Ghostscript
# zsh の gs='git stash'と干渉するため
alias gs='/usr/local/bin/gs'

# ALIAS: color-ls
alias ls-old='/bin/ls -aG'
alias ls='colorls -a'
