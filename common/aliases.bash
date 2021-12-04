#!/bin/bash

# ALIAS: ls

if [[ $(man ls | head -5 | grep BSD) ]]; then
  LS_COLOR_OPT="-G"
else
  LS_COLOR_OPT="--color"
fi
if type "lsd" > /dev/null 2>&1; then
	alias ls-old="/bin/ls ${LS_COLOR_OPT} -a"
	alias l="lsd"
	alias ll="lsd -l"
	alias la="lsd -a"
	alias lla="lsd -la"
	alias lah="lsd -lah"
else
	alias l="/bin/ls ${LS_COLOR_OPT}"
	alias ll="/bin/ls ${LS_COLOR_OPT} -l"
	alias la="/bin/ls ${LS_COLOR_OPT} -a"
	alias lla="/bin/ls ${LS_COLOR_OPT} -la"
	alias lah="/bin/ls ${LS_COLOR_OPT} -lah"
fi

# ALIAS: vim
alias v='vim'

# ALIAS: git
alias g='git'

# ALIAS: tig
if type "tig" > /dev/null 2>&1; then
	alias t='tig --all'
fi

# ALIAS: ipython
alias ipy="ipython --profile=imgproc"

# ALIAS: ptpython, ptipython
alias ptp="ptpython"
alias pti="ptipython"

# ALIAS: Jupyter Notebook
alias jnb="jupyter notebook"

# ALIAS: docker
alias d='docker'
alias dc='docker compose'

# ALIAS: kubectl
alias kc='kubectl'

# ALIAS: ls | grep
alias lg='/bin/ls -a1 | grep'

# ALIAS: fzf-prev
alias fzf-prev="fzf --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi {}) 2> /dev/null | head -500"
alias fv='fzf-prev'

# ALIAS: ghq
if type "ghq" > /dev/null 2>&1; then
	alias gg='ghq get -p'
	if type "fzf" > /dev/null 2>&1; then
		alias gcd='cd $(ghq root)/$(ghq list | sort | fzf)'
		alias gls='ghq list | fzf'
	fi
fi

# ALIAS: .rc edit by VIM
alias bashrc="vim ~/.bashrc"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias gitconfig="vim ~/.gitconfig"

# ALIAS: .dotfiles Git Repository
alias dotfiles="cd ${HOME}/.dotfiles"

# ALIAS: pkill
alias pkill="pkill -9"

# ALIAS: jq | fzf
alias jqfzf="jq -C | fzf --ansi"

# ALIAS: pygmentize
if type "pygmentize" > /dev/null 2>&1; then
	alias pygmentize='pygmentize -O style=monokai'
fi

# ALIAS: PATH
alias PATH="echo $PATH | tr ':' '\n'"
