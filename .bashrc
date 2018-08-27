# bash PS1 Settings
export PS1="\[\033[38;5;13m\][\[$(tput sgr0)\]\[\033[38;5;6m\]\l\[$(tput sgr0)\]\[\033[38;5;13m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[\033[38;5;7m\]@\[$(tput sgr0)\]\[\033[38;5;10m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;7m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n \[$(tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# $PATH PRIORITY SETTINGS
#  1. nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
#	 2. golang
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOROOT="/usr/local/opt/go/libexec"
export GOPATH="${HOME}/.golang"

# 3. Google Drive
export GOOGLE_DRIVE_ROOT="${HOME}/Google Drive"

# pyenv init 
eval "$(pyenv init -)"

# export MPLBACKEND="module://itermplot"

# ALIAS: ls
alias ls='ls -G'
alias lsG='CLICOLOR_FORCE=1 ls'


# ALIAS: grep
alias grep='grep --color'

# ALIAS: rsync (2.6.9 -> 3.1)
alias rsync='rsync3.1'

# ALIAS: man -> .pdf -> open Skim.App
# REF: https://sourceforge.net/p/skim-app/wiki/Tips_and_Tricks/
# alias manp='man -t \!* | ps2pdf - /tmp/man_\!$.pdf && open -a Skim /tmp/man_\!$.pdf'
function manp () {
	if [ $# -lt 1 ]; then
		echo "manp: invalid arguments !"
		echo "usage: manp [man-name]"
	else
		man -t $1 | ps2pdf - /tmp/man_$1.pdf && open -a Skim /tmp/man_$1.pdf
	fi
}

function mkTexDoc () {
	DIR_NAME="${GOOGLE_DRIVE_ROOT}/情報学部/NewTexReport"
	PATH_RESOURCE="${GOOGLE_DRIVE_ROOT}/情報学部/.tex_resource"

	if [[ -e $DIR_NAME ]]; then
		echo "${DIR_NAME}: already exists !"
		subl "${DIR_NAME}" 
	else
		mkdir -v -p "$DIR_NAME/img"
		cp -v "${PATH_RESOURCE}/Preamble.tex" "${PATH_RESOURCE}/Source.tex" "$DIR_NAME/" 
		subl "${DIR_NAME}"
	fi
}

function mkSemiReport() {
	DIR_ROOT="${GOOGLE_DRIVE_ROOT}/情報学部/研究/Semi_Report"
	PATH_RESOURCE="${GOOGLE_DRIVE_ROOT}/情報学部/.tex_resource"

	NUM_OF_REPORT=$(find . -maxdepth 1 -type d | grep '.*#.*' | sed -E 's%\./\#%%g' | sort -r | head -1)
	NUM_OF_REPORT=$(expr ${NUM_OF_REPORT} + 1)

	DIR_PATH="${DIR_ROOT}/#${NUM_OF_REPORT}"

	echo "${DIR_PATH}"

	if [[ -e ${DIR_PATH} ]]; then
		echo "${DIR_PATH}: already exists !"
	else
		mkdir -v -p "${DIR_PATH}/img"
		cp -v "${PATH_RESOURCE}/Preamble.tex" "${PATH_RESOURCE}/SemiReport.tex" "${DIR_PATH}/" 
		subl "${DIR_PATH}"
	fi
}

function pdfFontEmbed() {
	if [ $# -lt 1 ]; then
		echo "pdfFontEmbed: invalid arguments !"
		echo "usage: pdfFontEmbed [pdf-file]"
	else
		OUT_NAME=$(echo $1 | sed -e 's#\.pdf#_embed.pdf#g')
		echo "$1  -->  Font Embed  -->  ${OUT_NAME}"
		gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite -sOutputFile="${OUT_NAME}" "$1"
		pdffonts "${OUT_NAME}"
	fi


}
# less with Syntax-Highlight
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

# Customize for Skim.app
function SkimEnableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 15.0
	echo "Skim: Enabled Auto-Saving (Interval = 15.0 sec)"
}

function SkimDisableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 0.0
	echo "Skim: Disabled Auto-Saving"
}
