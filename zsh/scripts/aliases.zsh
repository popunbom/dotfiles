#!/bin/zsh

# docker
alias d='docker'
alias dc='docker compose'

# git
alias g='git'
alias gg='ghq get'
alias gcd='cd $(ghq root)/$(ghq list | sort | fzf)'
alias gls='ghq list | fzf'

# k8s
alias kc='kubectl'
alias k9s='env LC_ALL=en_US.UTF-8 k9s'

# ls
export CLICOLOR=1
if (( $+commands[lsd] )); then
  alias l='lsd'
  alias ls='lsd'
  alias l1='lsd -1'
  alias ll='lsd -l'
  alias la='lsd -a'
  alias lla='lsd -la'
  alias llh='lsd -lh'
  alias llah='lsd -lah'
fi

# vim
alias v='vim'

# Python
alias py='ipython'
