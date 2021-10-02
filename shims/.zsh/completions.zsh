#!/usr/bin/env zsh

ZSH_COMP_DIR="${HOME}/.zsh/completion"
[[ ! -e ${ZSH_COMP_DIR} ]] && mkdir -p ${ZSH_COMP_DIR}

# docker, docker-compose, docker-machine
function linkDockerCompletion {
	if [[ $(uname) == "Darwin" ]]; then
		DOCKER_APP_DIR="/Applications/Docker.app"

		if [[ -e ${DOCKER_APP_DIR} ]]; then
			DOCKER_COMP_DIR="${DOCKER_APP_DIR}/Contents/Resources/etc"
			COMP_FILE_PREFIXES=("docker" "docker-compose" "docker-machine")

			for COMP_FILE_PREFIX in $COMP_FILE_PREFIXES; do
				COMP_FILE_SRC="${DOCKER_COMP_DIR}/${COMP_FILE_PREFIX}.zsh-completion"
				COMP_FILE_DST="${ZSH_COMP_DIR}/_${COMP_FILE_PREFIX}"
				echo "COMP_FILE_SRC: $COMP_FILE_SRC"
				echo "COMP_FILE_DST: $COMP_FILE_DST"
				if [[ -e ${COMP_FILE_SRC} && ! -e ${COMP_FILE_DST} ]]; then
					ln -s ${COMP_FILE_SRC} ${COMP_FILE_DST}
				fi
			done
		fi
	fi
}

# kubectl
if type "kubectl" > /dev/null 2>&1; then
	source <(kubectl completion zsh)
fi

# Add to fpath
fpath=(
  /usr/local/share/zsh-completions
  ${ZSH_COMP_DIR}
  $fpath
)
