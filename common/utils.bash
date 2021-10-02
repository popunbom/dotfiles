#!/bin/bash

function mov2gif {
	BINARY="/usr/local/bin/ffmpeg"
	if type ${BINARY} > /dev/null 2>&1; then
		if [[ $# != 1 || $1 == '--help' || $1 == '-h' ]]; then
			cat <<- EOS
			usage: mov2gif mov-file 
				- Convert .mov to GIF animation (fps = 15)
			EOS
		else
			if [[ -e $1 ]]; then
				${BINARY} -i "$1" -vf scale=1280:-1 -r 15 "${1/mov/gif}"
			else
				echo "Error! -- file not found: $1"
			fi
		fi
	else
		echo "Error! -- 'ffmpeg' not found"
	fi
}

function sandbox {
	ROOT_DIR="$HOME/Documents/sandbox"
	cd $ROOT_DIR/$(find $ROOT_DIR -maxdepth 1 -type d | grep -v "^${ROOT_DIR}$" | sed -e "s%${ROOT_DIR}/%%g" | fzf)
}
