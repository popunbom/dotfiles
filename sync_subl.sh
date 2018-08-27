#!/bin/bash

BASE_DIR="$(cd "$(dirname $0)"; pwd)"

FILENAME_USER_PREF="Preferences.sublime-settings"
FILEPATH_SUBL_PREF="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"


PATH_SYMLINK_FROM="${BASE_DIR}/${FILENAME_USER_PREF}" 
PATH_SYMLINK_TO="${FILEPATH_SUBL_PREF}/${FILENAME_USER_PREF}" 

if [ -e $PATH_SYMLINK_FROM ]; then
	echo "${PATH_SYMLINK_FROM}: exists"
else
	echo "${PATH_SYMLINK_FROM}: not exists"
fi

if [ -e "$PATH_SYMLINK_TO" ]; then
	echo -n "${PATH_SYMLINK_TO}: already exists! Do you want to backup(.old) [y/n] ? "
	read answer
	while [[ "$answer" != "y" && "$answer" != "n" ]]; do
		echo -n "Please input 'y' or 'n': "
		read answer
	done
	if [[ "$answer" == "y" ]]; then
		mv -v "${PATH_SYMLINK_TO}" "${PATH_SYMLINK_TO}.bak"
	elif [[ "$answer" == "n" ]]; then
		rm -v "${PATH_SYMLINK_TO}"
	fi
	echo "create symlink"
	ln -vs "${PATH_SYMLINK_FROM}" "${PATH_SYMLINK_TO}"

else
	echo "${PATH_SYMLINK_TO}: not exists! create symlink"
	ln -vs "${PATH_SYMLINK_FROM}" "${PATH_SYMLINK_TO}"
fi


