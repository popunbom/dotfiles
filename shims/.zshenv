#!/usr/bin/env zsh

export DOTFILES_DIR="${HOME}/.dotfiles"

# Set ZDOTDIR and invoke to ${ZDOTDIR}/.zshenv
export ZDOTDIR="${HOME}/.zsh"
source ${ZDOTDIR}/.zshenv
