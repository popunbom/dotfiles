#!/bin/bash

OLD_IFS=$IFS
IFS=$'\n'

SCRIPT_DIR="$(cd "$(dirname $0)"; pwd)"
PATH_DOTFILES="${SCRIPT_DIR}"
PATH_FILE_LISTS="${SCRIPT_DIR}/symlinks.list"
PATH_SYMLINK_FROM="${SCRIPT_DIR}"
PATH_SYMLINK_TO="${HOME}"



if [[ ! -e $PATH_FILE_LISTS ]]; then
	echo "File not found! -- ${PATH_FILE_LISTS}"
	touch ${PATH_FILE_LISTS}
	echo "Please add filename to \"${PATH_FILE_LISTS}\""
else

cat << EOF
=============================================================

██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

=============================================================
============= DOTFILES ENVIRONMENT INSTALLER ================
=============================================================

PLEASE CHECK DIRECTORY PATH
  ".dotfiles" directory (symlink from) :  ${PATH_SYMLINK_FROM}
        \$HOME directory (symlink to)   :  ${PATH_SYMLINK_TO}

EOF

	echo -n "IS IT CORRECT [y/n] ?  "
	read answer
	while [[ "$answer" != "y" && "$answer" != "n" ]]; do
		echo -n "Please input 'y' or 'n': "
		read answer
	done

	# <-- Main Routine
	if [[ "$answer" == "y" ]]; then
		while read BASENAME_DOTFILE; do
			echo $BASENAME_DOTFILE

			# Set symlink
			SYMLINK_FROM="${PATH_SYMLINK_FROM}/${BASENAME_DOTFILE}"
			echo "SYMLINK_FROM: ${SYMLINK_FROM}"
			SYMLINK_TO="${PATH_SYMLINK_TO}/.${BASENAME_DOTFILE}"
			echo "SYMLINK_TO  : ${SYMLINK_TO}"

			# Check "SYMLINK_FROM" existance
			if [[ ! -e $SYMLINK_FROM ]]; then
				echo "${SYMLINK_FROM}: file not found! -- skipped"

			else
				# Check "SYMLINK_TO" existance
				if [[ -e $SYMLINK_TO ]]; then
					echo -ne "${SYMLINK_TO}: already exists! \n  Do you want to overwrite [y/n] ? "

					read answer
					while [[ "$answer" != "y" && "$answer" != "n" ]]; do
						echo -n "Please input 'y' or 'n': "
						read answer
					done

					if [[ "$answer" == "y" ]]; then
						echo "${SYMLINK_TO}: delete and create symlink"
						# Delete & Create symlink
						rm -rf $SYMLINK_TO
						ln -s ${SYMLINK_FROM} ${SYMLINK_TO}
					elif [[ "$answer" == "n" ]]; then
						echo "${SYMLINK_TO}: not changed."
					fi

				else
					echo "${SYMLINK_TO}: create symlink"	
					# Create symlink
					ln -s ${SYMLINK_FROM} ${SYMLINK_TO}
				fi

			fi

		done < $PATH_FILE_LISTS

	elif [[ "$answer" == "n" ]]; then
		echo "SCRIPT FINISHED WITHOUT ANY FILE CHANGE"
	fi
	# --> Main Routine
fi


IFS=$OLD_IFS
