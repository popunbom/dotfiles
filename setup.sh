#!/bin/bash

SCRIPT_DIR="${HOME}/.dotfiles/"

# List up dotfiles of this directory
for DOT_FILE_SOURCE in $(find ${SCRIPT_DIR} -maxdepth 1 -name '\.*'); do
	DOT_FILE_SOURCE=$( echo $DOT_FILE_SOURCE | sed -e 's/\/\//\//g' )
	# echo "DOT_FILE_SOURCE = ${DOT_FILE_SOURCE}"
	
	# Path Replace to $HOME
	DOT_FILE="$(basename ${DOT_FILE_SOURCE})"
	DOT_FILE_TARGET="${HOME}/${DOT_FILE}"
	# echo "DOT_FILE_TARGET = ${DOT_FILE_TARGET}"; echo ""
	
	# Make symbolic link if not already exists
	if [ -e $DOT_FILE_TARGET ]; then
		echo -n "$DOT_FILE_TARGET: already exists! Do you want to overwrite [y/n] ? "
		read answer
		while [[ "$answer" != "y" && "$answer" != "n" ]]; do
			echo -n "Please input 'y' or 'n': "
			read answer
		done
		if [[ "$answer" == "y" ]]; then
			echo "$DOT_FILE: create symlink"
			rm -rf $DOT_FILE_TARGET
			ln -s ${DOT_FILE_SOURCE} ${DOT_FILE_TARGET}
		elif [[ "$answer" == "n" ]]; then
			echo "$DOT_FILE_TARGET: not changed."
		fi
	else
		echo "$DOT_FILE: create symlink"	
		rm -rf $DOT_FILE_TARGET
		ln -s ${DOT_FILE_SOURCE} ${DOT_FILE_TARGET}
	fi
done
