#!/bin/bash

OLD_IFS=$IFS
IFS=$'\n'

SCRIPT_DIR="$(cd "$(dirname $0)"; pwd)"
PATH_DOTFILES="${SCRIPT_DIR}/shims"
PATH_SYMLINK_FROM="${PATH_DOTFILES}"
PATH_SYMLINK_TO="${HOME}"



cat << EOF
=============================================================

██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

=============================================================
=================== DOTFILES  INSTALLER =====================
=============================================================

EOF

# <-- Main Routine
for BASENAME_DOTFILE in $(ls -a1 ${PATH_DOTFILES} | grep -Ev "^\.+$"); do
	echo $BASENAME_DOTFILE

	# Set symlink
	SYMLINK_FROM="${PATH_SYMLINK_FROM}/${BASENAME_DOTFILE}"
	echo "SYMLINK_FROM: ${SYMLINK_FROM}"
	SYMLINK_TO="${PATH_SYMLINK_TO}/.${BASENAME_DOTFILE}"
	echo "SYMLINK_TO  : ${SYMLINK_TO}"

	# Check "SYMLINK_FROM" existance
	if [[ -e $SYMLINK_FROM ]]; then
		# Check "SYMLINK_TO" existance
		if [[ -e $SYMLINK_TO || -h $SYMLINK_TO ]]; then
			rm -rf $SYMLINK_TO
		fi
		ln -s ${SYMLINK_FROM} ${SYMLINK_TO}
	fi
done
# --> Main Routine

IFS=$OLD_IFS

