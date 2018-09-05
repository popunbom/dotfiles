#!/bin/bash

OLD_IFS=$IFS
IFS=$'\n'

SCRIPT_DIR="$(cd "$(dirname $0)"; pwd)"
PATH_DOTFILES="${SCRIPT_DIR}"

PATH_SYMLINK_FROM="${SCRIPT_DIR}"
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

# Main Routine
if [[ "$answer" == "y" ]]; then
	# List up dotfiles of this directory
	for DOT_FILE in $(ls -a1 | grep -vE '^\.+$|^[^.]|DS_Store|git'); do
		
		# Set symlink
		SYMLINK_FROM="${PATH_SYMLINK_FROM}/${DOT_FILE}"
		SYMLINK_TO="${PATH_SYMLINK_TO}/${DOT_FILE}"
		
		# Check file existance
		if [ -e $SYMLINK_TO ]; then
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
	done

elif [[ "$answer" == "n" ]]; then
	echo "SCRIPT FINISHED WITHOUT ANY FILE CHANGE"
fi


IFS=$OLD_IFS
