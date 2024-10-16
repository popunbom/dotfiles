#!/bin/zsh

# docker
function drun {
  DOCKER_IMAGE="$(docker images | fzf --header-lines=1 | awk -F' ' '{print $3}')";
  docker run --rm -v "$(pwd):/workspace" -w '/workspace' --entrypoint='' -it "${DOCKER_IMAGE}" $@
}

function dexec {
  CONTAINER_ID="$(docker ps | fzf --header-lines=1 | awk -F' ' '{print $1}')"
  docker exec -it "${CONTAINER_ID}" $@
}

function dkill {
  CONTAINER_ID="$(docker ps | fzf --header-lines=1 | awk -F' ' '{print $1}')"
  docker kill "${CONTAINER_ID}" $@
}

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
    return 0
  fi

  USE_CUSTOM_NAME=0
  IN_FILE=$1; shift
  OUT_FILE=""
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
          return 255
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
      return 255
    fi
  fi

  echo "Encrypt:  \"${IN_FILE}\"  -->  \"${OUT_FILE}\""
  openssl aes-256-cbc -e -in "${IN_FILE}" -out "${OUT_FILE}"
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
    return 0
  fi

	IN_FILE=$1
	OUT_TO="stdout"
	shift
	# Parse arguments
	for OPT in "$@"; do

		if [[ -n $OUT_FILE ]]; then
			echo "invalid arguments !"
			show_usage
			return 255
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
		return 255
	fi

	if [[ "$OUT_TO" == "stdout" ]]; then
		openssl aes-256-cbc -d -in "${IN_FILE}"
	elif [[ "$OUT_TO" == "file" ]]; then
		echo "Decrypted: ${IN_FILE}  -->  ${IN_FILE/.encrypted/}"
		openssl aes-256-cbc -d -in "${IN_FILE}" -out "${IN_FILE/.encrypted/}"
	fi
}

# Workspace
alias ws="workspace"
export WORKSPACE_DIR="${HOME}/Documents/workspaces"
workspace() {

    info() {
        printf "\033[34m%s\033[m\n" "$1"
    }
    error() {
        printf "\033[31m%s\033[m\n" "$1"
    }

    print_help() {
        cat <<-EOF
		usage: workspace [-h] {add [direectory]} ...

		Simply workspace manager
		- WORKSPACE_DIR: ${WORKSPACE_DIR}

		actions:
		  add [direectory]    Add workspace folder
		EOF
    }

    handle_chdir() {
        cd "${WORKSPACE_DIR}/$(
            find "${WORKSPACE_DIR}" -maxdepth 1 -type d |
                sed -e '1d' -e "s#^${WORKSPACE_DIR}/##g" |
                sort | fzf
        )"
    }

    handle_add() {
        DIR_NAME=$1
        if [[ -z ${DIR_NAME} ]]; then
            error "Invalid DIR_NAME: '${DIR_NAME}'"
            return 255
        fi
        DIR_PATH="${WORKSPACE_DIR}/${DIR_NAME}"
        if [[ -e ${DIR_PATH} ]]; then
            error "File exists: ${DIR_PATH}"
            return 255
        fi
        mkdir "${DIR_PATH}"
        if [[ $? == 0 ]]; then
            info "Add workspace: ${DIR_PATH}"
        fi
        cd "${DIR_PATH}"
    }

    ACTION="$1"
    shift 2>/dev/null
    ARGS=("$@")

    if [[ -z ${ACTION} ]]; then
        handle_chdir
    else
        case ${ACTION} in
        add)
            handle_add "${ARGS[@]}"
            ;;
        -h)
            print_help
            ;;
        *)
            error "Invalid action: '${ACTION}'"
            return 255
            ;;
        esac
    fi
}
