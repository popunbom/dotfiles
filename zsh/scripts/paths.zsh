#!/bin/zsh

export PATH="/usr/local/bin:/usr/local/sbin:${PATH+:${PATH}}"

[[ -d ${HOME}/.rd ]] && export PATH="${HOME}/.rd/bin${PATH+:${PATH}}"
[[ -d ${HOME}/.golang ]] && export PATH="${HOME}/.golang/bin${PATH+:${PATH}}"
