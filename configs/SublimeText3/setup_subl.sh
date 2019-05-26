#!/bin/bash

PATH_SUBL_PREF="${HOME}/Library/Application Support/Sublime Text 3/Packages"

BASE_DIR="$(cd "$(dirname $0)"; pwd)"

PATH_SYMLINK_FROM="${BASE_DIR}/User" 
PATH_SYMLINK_TO="${PATH_SUBL_PREF}/User" 

cat << EOF
=============================================================

██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

=============================================================
============= SUBLIME TEXT ENVIRONMENT INSTALLER ============
=============================================================

EOF

if [ ! -e $PATH_SYMLINK_FROM ]; then
	echo "${PATH_SYMLINK_FROM}: not exists ! aborted ..."
else
	if [ -e "$PATH_SYMLINK_TO" ]; then
		echo -ne "${PATH_SYMLINK_TO}: already exists! \n  Do you want to [y] backup(.old) or [n] delete  [y/n] ? "
		
		read answer
		while [[ "$answer" != "y" && "$answer" != "n" ]]; do
			echo -n "Please input 'y' or 'n': "
			read answer
		done

		if [[ "$answer" == "y" ]]; then
			mv -v "${PATH_SYMLINK_TO}" "${PATH_SYMLINK_TO}.old"
		elif [[ "$answer" == "n" ]]; then
			rm -vRf "${PATH_SYMLINK_TO}"
		fi
		echo "Create symlink"
		ln -vs "${PATH_SYMLINK_FROM}" "${PATH_SYMLINK_TO}"

	else
		echo "${PATH_SYMLINK_TO}: not exists!"
		echo "Create symlink"
		ln -vs "${PATH_SYMLINK_FROM}" "${PATH_SYMLINK_TO}"
	fi

fi
