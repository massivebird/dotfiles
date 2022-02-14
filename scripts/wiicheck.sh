#!/bin/bash

## WIICHECK
# This script validates the file system structure for an external
# storage device to be used by the Wii Homebrew application USB Loader GX.

## OPTIONAL ARGUMENTS
# $1: single character drive letter of the Wii external storage device

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
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

echo # print newline

# Paths to Wii and GCN directories based on optional argument
if [ $(echo $1 | wc -w) -eq 0 ]; then
	wiigames=/mnt/*/wiiback/wbfs
	gcngames=/mnt/*/wiiback/games
elif [ -d "/mnt/$1/wbfs" ] && [ -d "/mnt/$1/games" ]; then
	echo -e "$STATUS_OK Drive ${1^^} successfully initialized"
	wiigames=/mnt/$1/wbfs
	gcngames=/mnt/$1/games
else
	echo -e "$STATUS_WARN Drive ${1^^} is not your Wii drive! Defaulting to" /mnt/*/wiiback "\b."
	wiigames=/mnt/*/wiiback/wbfs
	gcngames=/mnt/*/wiiback/games
fi

# Returns unexpected filename(s)
unexwii=$(ls $wiigames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
unexgcn=$(ls $gcngames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

if [ $(echo $unexwii | wc -w) -gt 0 ]; then
	echo -e "$STATUS_OHNO $WII: Unexpected filename(s) detected"
	echo -e $unexwii
else
	echo -e "$STATUS_OK $WII: Looking good!"
fi

if [ $(echo $unexgcn | wc -w) -gt 0 ]; then
	echo -e "$STATUS_OHNO $GCN: Unexpected filename(s) detected"
	echo $unexgcn
else
	echo -e "$STATUS_OK $GCN: Looking fresh!"
fi

echo # print newline
