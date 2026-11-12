#!/bin/zsh

unsetopt GLOBAL_RCS

# path_helper
[[ -x /usr/libexec/path_helper ]] && eval "$(/usr/libexec/path_helper -s)"

# Homebrew
[[ -e "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
[[ -e "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
# MacPorts
[[ -d /opt/local/sbin ]] && export PATH="/opt/local/sbin${PATH+:${PATH}}"
[[ -d /opt/local/bin ]] && export PATH="/opt/local/bin${PATH+:${PATH}}"

# Local binary (e.g. mise)
[[ -d ${HOME}/.local/bin ]] && export PATH="${HOME}/.local/bin${PATH+:${PATH}}"

# jdx/mise
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
  eval "$(mise activate --shims)"
fi

# Rancher Desktop
[[ -d ${HOME}/.rd ]] && export PATH="${HOME}/.rd/bin${PATH+:${PATH}}"

# opencode
export PATH="${HOME}/.opencode/bin${PATH+:${PATH}}"
