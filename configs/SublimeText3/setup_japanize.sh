#!/bin/bash

ST3_PKGS_ROOT="${HOME}/Library/Application Support/Sublime Text 3/Packages"

PATH_JAPANIZE="${ST3_PKGS_ROOT}/Japanize"

if [ ! -e "$ST3_PKGS_ROOT" ]; then
	echo "${ST3_PKGS_ROOT}: not exists ! aborted ..."
else
	# Create 'Default' directory if not exists
	if [ ! -e "${ST3_PKGS_ROOT}/Default" ]; then
		mkdir -v "${ST3_PKGS_ROOT}/Default"
	fi

	OLD_IFS=$IFS; IFS=$'\n'
	for jp_file in $(ls "${PATH_JAPANIZE}" | grep '\.jp$'); do
		# Backup original file with .orig suffix
		if [ -e "${ST3_PKGS_ROOT}/Default/${jp_file%.jp}" ]; then
				mv -v "${ST3_PKGS_ROOT}/Default/${jp_file%.jp}" "${ST3_PKGS_ROOT}/Default/${jp_file/.jp/.orig}"
		fi
		# Copy *.jp file to Default/
		cp -vf "${PATH_JAPANIZE}/${jp_file}" "${ST3_PKGS_ROOT}/Default/${jp_file%.jp}"
	done 
	IFS=$OLD_IFS

	# Copy 'Main.sublime-menu' to User/
	cp -vf "${PATH_JAPANIZE}/Main.sublime-menu" "${ST3_PKGS_ROOT}/User/"

	fi
