#!/bin/zsh

# Homebrew
[[ -d /usr/local/sbin ]] && export PATH="/usr/local/sbin${PATH+:${PATH}}"
[[ -d /usr/local/bin ]] && export PATH="/usr/local/bin${PATH+:${PATH}}"
# MacPorts
[[ -d /opt/local/sbin ]] && export PATH="/opt/local/sbin${PATH+:${PATH}}"
[[ -d /opt/local/bin ]] && export PATH="/opt/local/bin${PATH+:${PATH}}"

# Local binary (e.g. mise)
[[ -d ${HOME}/.local/bin ]] && export PATH="${HOME}/.local/bin${PATH+:${PATH}}"

# Rancher Desktop
[[ -d ${HOME}/.rd ]] && export PATH="${HOME}/.rd/bin${PATH+:${PATH}}"
