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

# Colored strings
WII="${CYAN}WII${NC}"
GCN="${MAGENTA}GCN${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

# Status check for after regex evaluations
WIIGSTATUS=0
GCNSTATUS=0

echo # Output newline

# Paths to Wii and GCN directories based on optional argument
if [ ! -d "/mnt/d/wiiback" ]; then
	echo -e "$STATUS_OHNO No valid directories found. Sorry!"
	echo
	exit
elif [ $(echo $1 | wc -w) -eq 0 ]; then
	echo -e "$STATUS_OK Backup directory initialized"
	WIIDIR=/mnt/*/wiiback/wbfs
	GCNDIR=/mnt/*/wiiback/games
elif [ -d "/mnt/$1/wbfs" ] && [ -d "/mnt/$1/games" ]; then
	echo -e "$STATUS_OK Drive ${1^^} successfully initialized"
	WIIDIR=/mnt/$1/wbfs
	GCNDIR=/mnt/$1/games
else
	echo -e "$STATUS_WARN Drive ${1^^} is not your Wii drive! Defaulting to" /mnt/*/wiiback "\b."
	WIIDIR=/mnt/*/wiiback/wbfs
	GCNDIR=/mnt/*/wiiback/games
fi

# Number of games per system
WIIGAMES=$(ls -l $WIIDIR | grep '^d' | wc -l)
GCNGAMES=$(ls -l $GCNDIR | grep '^d' | wc -l)

# Locates unexpected filename(s)
unexwii=$(find $WIIDIR -empty)$(ls $WIIDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
unexgcn=$(find $GCNDIR -empty)$(ls $GCNDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

# Main output
if [ $(echo $unexwii | wc -w) -gt 0 ]; then
	echo -e "$STATUS_OHNO $WII: Unexpected filename(s) detected"
	echo "$unexwii"
else
	echo -e "$STATUS_OK $WII: Looking good!"
	WIIGSTATUS=1
fi

if [ $(echo $unexgcn | wc -w) -gt 0 ]; then
	echo -e "$STATUS_OHNO $GCN: Unexpected filename(s) detected"
	echo "$unexgcn"
else
	echo -e "$STATUS_OK $GCN: Looking fresh!"
	GCNSTATUS=1
fi

# Outputs total games if both Wii can GCN are ok
if [ $WIIGSTATUS -eq 1 ] && [ $GCNSTATUS -eq 1 ]; then
	echo "$STATUS_COOL $(( $WIIGAMES + $GCNGAMES )) games! Cool! "
fi

echo # Output newline
