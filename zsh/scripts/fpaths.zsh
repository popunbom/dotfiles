#!/bin/zsh

fpath=( "${ZDOTDIR}/completion" "${fpath[@]}" )
if (( $+commands[brew] )); then
  fpath=( "$(brew --prefix)/share/zsh-completions" "${fpath[@]}" )
  fpath=( "$(brew --prefix)/share/zsh/site-functions" "${fpath[@]}" )
fi
