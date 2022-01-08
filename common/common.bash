#!/bin/bash

# Homebrew
if type "brew" > /dev/null 2>&1; then
  eval $(brew shellenv)
fi

# XXenv init 
# 遅い！zsh だと遅延評価で改善できるらしい
# anyenv を使う方針も検討する
for XXenv in "pyenv" "rbenv" "nodenv" "jenv"; do
	if type $XXenv 2>&1 >/dev/null ; then
		eval "$(${XXenv} init -)"
	fi
done

# Node
export NODE_PATH=$(npm root -g)
# Rust
source "$HOME/.cargo/env"
