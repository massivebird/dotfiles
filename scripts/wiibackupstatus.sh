#!/bin/bash

# Color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
NC="$(tput sgr 0)"

# Colored Wii and GCN strings
WII="${CYAN}WII${NC}"
GCN="${MAGENTA}GCN${NC}"

echo # print newline

# Paths to Wii and GCN directories based on optional argument
if [ $(echo $1 | wc -w) -eq 0 ]; then
	wiigames=/mnt/*/wiiback/wbfs
	gcngames=/mnt/*/wiiback/games
elif [ -d "/mnt/$1/wbfs" ] && [ -d "/mnt/$1/games" ]; then
	wiigames=/mnt/$1/wbfs
	gcngames=/mnt/$1/games
else
	echo -e "[$YELLOW WARN $NC] Drive ${1^^} is not your Wii drive! Defaulting to" /mnt/*/wiiback "\b."
	wiigames=/mnt/*/wiiback/wbfs
	gcngames=/mnt/*/wiiback/games
fi

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
	echo -e "[$RED OHNO $NC] $GCN: Unexpected filename(s) detected"
	echo $unexgcn
else
	echo -e "[$GREEN  OK  $NC] $GCN: Looking fresh!"
fi

echo # print newline
