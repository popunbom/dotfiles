#!/bin/bash

export GOOGLE_DRIVE_ROOT="/Volumes/GoogleDrive/マイドライブ"

function mkTexDoc () {
	DIR_NAME="${GOOGLE_DRIVE_ROOT}/情報学部/NewTexReport"
	PATH_RESOURCE="${GOOGLE_DRIVE_ROOT}/情報学部/.tex_resource"

	if [[ -e $DIR_NAME ]]; then
		echo "${DIR_NAME}: already exists !"
		${GUI_EDITOR} "${DIR_NAME}" 
	else
		mkdir -v -p "$DIR_NAME/img"
		cp -v "${PATH_RESOURCE}/Preamble.tex" "${PATH_RESOURCE}/Source.tex" "$DIR_NAME/" 
		${GUI_EDITOR} "${DIR_NAME}"
	fi
}

function mkSemiReport() {
	DIR_ROOT="${GOOGLE_DRIVE_ROOT}/情報学部/研究/Semi_Report"
	PATH_RESOURCE="${GOOGLE_DRIVE_ROOT}/情報学部/.tex_resource"

	NUM_OF_REPORT=$(find ${DIR_ROOT} -maxdepth 1 -type d | grep -E '.*/#[0-9]+$' | sed -E 's%'"${DIR_ROOT}"'/#%%g' | sort -r | head -1)
	# echo "NUM_OF_REPORT = ${NUM_OF_REPORT}"
	NUM_OF_REPORT=$(expr ${NUM_OF_REPORT} + 1)

	DIR_PATH="${DIR_ROOT}/#${NUM_OF_REPORT}"

	if [[ -e ${DIR_PATH} ]]; then
		echo "${DIR_PATH}: already exists !"
		${GUI_EDITOR} "${DIR_NAME}"
	else
		mkdir -v -p "${DIR_PATH}/img"
		cp -v "${PATH_RESOURCE}/Preamble.tex" "${PATH_RESOURCE}/SemiReport.tex" "${DIR_PATH}/" 
		${GUI_EDITOR} "${DIR_PATH}"
	fi
}
