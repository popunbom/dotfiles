#!/bin/bash

# XXenv init 
# 遅い！zsh だと遅延評価で改善できるらしい
# anyenv を使う方針も検討する
for XXenv in "pyenv" "rbenv" "nodenv" "jenv"; do
	if type $XXenv 2>&1 >/dev/null ; then
		[[ $XXenv == "pyenv" ]] && eval "$(pyenv init --path)"
		eval "$(${XXenv} init -)"
	fi
done

# Node
if type "npm" > /dev/null 2>&1; then
	export NODE_PATH=$(npm root -g)
fi

# Rust
[[ -e "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
