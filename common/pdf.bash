#!/bin/bash


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


function pdfFontEmbed() {
	if [ $# -lt 1 ]; then
		echo "pdfFontEmbed: invalid arguments !"
		echo "usage: pdfFontEmbed [pdf-file]"
	else
		OUT_NAME=$(echo -n $1 | sed -e 's#\.pdf#_embed.pdf#g')
		echo "$1  -->  Font Embed  -->  ${OUT_NAME}"
		/usr/local/bin/gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite -sOutputFile=\"${OUT_NAME}\" \"$1\"
		pdffonts "${OUT_NAME}"
	fi
}

# Customize for Skim.app
function SkimEnableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 15.0
	echo "Skim: Enabled Auto-Saving (Interval = 15.0 sec)"
}

function SkimDisableAutoSave(){
	defaults write -app Skim SKAutosaveInterval -float 0.0
	echo "Skim: Disabled Auto-Saving"
}
