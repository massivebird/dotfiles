#!/usr/bin/env bash

export NEWT_COLORS='
root=,black
window=,black
checkbox=,black
actcheckbox=brightblue,blue
border=white,black
textbox=white,black
button=black,black
'

CHOICE=$(whiptail --checklist "Choose your packages!" 18 80 10 \
	"UPAPT" "Update apt cache (recommended)" OFF \
	"INBASICS" "Basics (git, tree, rename, ...)" OFF \
	"INZSH" "ZSH" OFF \
	"INZSHPLUG" "ZSH Plugins" OFF \
	"INVIM" "Neovim" OFF \
	"INJS" "JavaScript (npm, nodejs)" OFF \
	"INRS" "Rust" OFF \
	"INPY" "Python" OFF \
	"INCLJ" "Clojure" OFF \
	"INFUN" "Fun times! (cmatrix, nethack)" OFF 3>&1 1>&2 2>&3)

if [ -z "$CHOICE"  ]; then
	echo "No option was chosen (user hit Cancel)"
else
	echo "The user chose $CHOICE"
fi
