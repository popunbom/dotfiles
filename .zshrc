#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# zplug
# export ZPLUG_HOME=/usr/local/opt/zplug
# source $ZPLUG_HOME/init.zsh
# zplug: Pugins
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-autosuggestions", defer:2


# Source Prezto.
if [[ -s  "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
	source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Enable: zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Enable: History of Directory
setopt auto_pushd
# Enable: Command Auto-Fixing
setopt correct
# Disable: 'no matches found'
setopt nonomatch

# Customize: zsh-autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"


# Enable Vi-Edit Mode in ZLE(zsh-line-edit)
# REF: https://qiita.com/b4b4r07/items/8db0257d2e6f6b19ecb9
bindkey -v

# vi-cmd-mode を抜けるキーバインドを Ctrl-Q に変更
# REF: https://superuser.com/questions/351499/how-to-switch-comfortably-to-vi-command-mode-on-the-zsh-command-line
bindkey -M viins '^Q' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^L' clear-screen
bindkey -M viins '^U' kill-whole-line



# Prezto のテーマ 'paradox' 使用時に上に1行
# 空白が発生するのを防ぐため、PROMPT 環境変数
# を上書きする
PROMPT='${(e)$(prompt_paradox_build_prompt)}
 ${editor_info[keymap]} '


#############################
#### Import from .bashrc ####
#############################

# PATH PRIORITY SETTINGS
#  1. nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
#  2. golang
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# ENV SETTINGS
export GOROOT="/usr/local/opt/go/libexec"
export GOPATH="${HOME}/.golang"

# 3. Google Drive
export GOOGLE_DRIVE_ROOT="${HOME}/Google Drive"

# pyenv init 
eval "$(pyenv init -)"

# Alias: ls
alias ls-old='/bin/ls -aG'
alias ls='colorls'

# ALIAS: rsync (2.6.9 -> 3.1)
alias rsync='rsync3.1'

# ALIAS: Ghostscript
# Fix Conflict zsh alias( gs='git stash' )
alias gs='/usr/local/bin/gs'

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

	NUM_OF_REPORT=$(find ${DIR_ROOT} -maxdepth 1 -type d | grep -E '.*/#[0-9]+$' | sed -E 's%'"${DIR_ROOT}"'/#%%g' | sort -r | head -1)
	# echo "NUM_OF_REPORT = ${NUM_OF_REPORT}"
	NUM_OF_REPORT=$(expr ${NUM_OF_REPORT} + 1)

	DIR_PATH="${DIR_ROOT}/#${NUM_OF_REPORT}"

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
# less with Syntax-Highlight, Line-Number
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS -N'

# Customize for Skim.app
function SkimEnableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 15.0
	echo "Skim: Enabled Auto-Saving (Interval = 15.0 sec)"
}

function SkimDisableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 0.0
	echo "Skim: Disabled Auto-Saving"
}


# File Encrypt & Decrypt 
function myFileEncrypt {
	if [ $# -ne 1 ] ;then
		echo "usage: myFileEncrypt [file-to-encrypt]"
	else
		openssl aes-256-cbc -e -in "$1" -out "$1.encrypted"
	fi
}

function myFileDecrypt {
	if [ $# -ne 1 ] ;then
		echo "usage: myFileDecrypt [file-to-decrypt]"
	else
		openssl aes-256-cbc -d -in "$1" -out "${1/.encrypted/}"
	fi
}
