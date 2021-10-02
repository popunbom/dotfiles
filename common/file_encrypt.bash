#!/bin/bash

# File Encrypt & Decrypt 
function myFileEncrypt {
	function show_usage () {
		cat <<- EOS

		usage: myFileEncrypt file-to-encrypt [-o out-file-name]
			- Encrypt file by openssl. 
			- Encrypted file applies suffix '.encrypted' unless '-o' option.

		EOS
	}

	if [[ $# == 0 || $1 == '--help' || $1 == '-h' ]]; then
		show_usage
	else
		USE_CUSTOM_NAME=0
		IN_FILE=$1
		OUT_FILE=""
		shift
		# Parse arguments
		for OPT in "$@"; do
			case $OPT in
				'-o' )
					USE_CUSTOM_NAME=1
					;;
				* )
					if [[ $USE_CUSTOM_NAME == 0 ]]; then
						echo "invalid arguments !: set filename without '-o' option"
						show_usage
						return -1
					else
						OUT_FILE=$1
					fi
					;;
			esac
			shift
		done

		if [[ $USE_CUSTOM_NAME == 0 ]]; then
			OUT_FILE="${IN_FILE}.encrypted"
		else
			if [[ -z $OUT_FILE ]]; then
				echo "invalid arguments !: '-o' option requires 'out-file-name'"
				show_usage
				return -1
			fi
		fi

		echo "Encrypt:  \"${IN_FILE}\"  -->  \"${OUT_FILE}\""
		openssl aes-256-cbc -e -in "${IN_FILE}" -out "${OUT_FILE}"
	fi

}

function myFileDecrypt {
	function show_usage () {
		cat <<- EOS

		usage: myFileDecrypt encrypted-file [-o out-file-path]
			- Decrypt file by openssl. 
			- Decrypted file outputs to stdout unless '-o' option.

		EOS
	}

if [[ $# == 0 || $1 == '--help' || $1 == '-h' ]]; then
	show_usage
else
	IN_FILE=$1
	OUT_TO="stdout"
	shift
	# Parse arguments
	for OPT in "$@"; do

		if [[ -n $OUT_FILE ]]; then
			echo "invalid arguments !"
			show_usage
			return -1
		fi

		case $OPT in
			'-o' )
				OUT_TO="file"
				;;
			* )
				if [[ $OUT_TO != "file" ]]; then
					echo "invalid arguments !"
					show_usage
				else
					OUT_FILE=$1
				fi
				;;
		esac
		shift
	done

	if [[ $OUT_TO == "file" && -z $OUT_FILE ]]; then
		echo "invalid arguments !: '-o' option requires 'out-file-name'"
		return -1
	fi

	if [[ "$OUT_TO" == "stdout" ]]; then
		openssl aes-256-cbc -d -in "${IN_FILE}"
	elif [[ "$OUT_TO" == "file" ]]; then
		echo "Decrypted: ${IN_FILE}  -->  ${IN_FILE/.encrypted/}"
		openssl aes-256-cbc -d -in "${IN_FILE}" -out "${IN_FILE/.encrypted/}"
	fi

fi
}
