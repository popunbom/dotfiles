#!/usr/local/bin/zsh

SCRIPT_DIR=$(cd "$(dirname $0)" && pwd)

# echo "${SCRIPT_DIR}/.zprezto/runcoms/^README.md(.N)"
# setopt EXTENDED_GLOB

for rcfile in "${SCRIPT_DIR}"/.zprezto/runcoms/^README.md(.N); do
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

