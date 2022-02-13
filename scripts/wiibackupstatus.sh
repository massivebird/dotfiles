#!/bin/bash

# Output formatting
CYAN="$(tput setaf 45)"
GREEN="\033[32m"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
NC="$(tput sgr 0)"

WII="${CYAN}WII${NC}"
GCN="${MAGENTA}GCN${NC}"

# Paths to Wii and GCN directories
wiigames=/mnt/*/wiiback/wbfs
gcngames=/mnt/*/wiiback/Games

# Returns unexpected filename(s)
unexwii=$(ls $wiigames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
unexgcn=$(ls $gcngames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

if [ $(echo $unexwii | wc -w) -gt 0 ]; then
	echo -e "[$RED OHNO $NC] $WII: Unexpected filename(s) detected"
	echo -e $unexwii
else
	echo -e "[$GREEN  OK  $NC] $WII: Looking good!"
fi

if [ $(echo $unexgcn | wc -w) -gt 0 ]; then
	echo -e "\n[$RED OHNO $NC] $GCN: Unexpected filename(s) detected"
	echo $unexgcn
else
	echo -e "\n[$GREEN  OK  $NC] $GCN: Looking fresh!"
fi
