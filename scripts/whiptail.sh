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
	"UPAPT" "Update apt cache (recommended)" ON \
	"INBASICS" "Basics (git, tree, rename, ...)" OFF \
	"INZSHSHELL" "ZSH" OFF \
	"INZSHPLUG" "ZSH Plugins" OFF \
	"INVIM" "Neovim" OFF \
	"INJS" "JavaScript (npm, nodejs)" OFF \
	"INRS" "Rust" OFF \
	"INPY" "Python" OFF \
	"INCLJ" "Clojure" OFF \
	"INFUN" "Fun times! (cmatrix, nethack)" OFF 3>&1 1>&2 2>&3)

if [[ "$CHOICE" == *"UPAPT"* ]]; then
	echo "Update apt cache"
fi
if [[ "$CHOICE" == *"INBASICS"* ]]; then
	echo "Install basics package"
fi
if [[ "$CHOICE" == *"INZSHSHELL"* ]]; then
	echo "Install ZSH shell"
fi
if [[ "$CHOICE" == *"INZSHPLUG"* ]]; then
	echo "Install ZSH plugins"
fi
if [[ "$CHOICE" == *"INVIM"* ]]; then
	echo "Install neovim"
fi
if [[ "$CHOICE" == *"INJS"* ]]; then
	echo "Install JavaScript"
fi
if [[ "$CHOICE" == *"INRS"* ]]; then
	echo "Install Rust"
fi
if [[ "$CHOICE" == *"INPY"* ]]; then
	echo "Install Python"
fi
if [[ "$CHOICE" == *"INCLJ"* ]]; then
	echo "Install clojure"
fi
if [[ "$CHOICE" == *"INFUN"* ]]; then
	echo "Install FUN STUFF"
fi
