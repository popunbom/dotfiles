#!/bin/bash

export DOTFILES_DIR="${HOME}/.dotfiles"

# Set DOTDIR and invoke to ${DOTDIR}/.bash_profile
export DOTDIR="${HOME}/.bash"
source ${DOTDIR}/.bash_profile
