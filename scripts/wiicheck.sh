#!/usr/bin/env bash

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

# Name of backup directory so I can change it later
BACKUPNAME="WIIBACK"

# Paths to Wii and GCN directories based on optional argument
if [ ! -d "/mnt/d/$BACKUPNAME" ]; then
	echo -e "$STATUS_OHNO No valid directories found. Sorry!"
	exit 1
elif [ -z "$1" ]; then
	echo -e "$STATUS_OK Backup directory initialized"
	WIIDIR="/mnt/*/$BACKUPNAME/wbfs"
	GCNDIR="/mnt/*/$BACKUPNAME/games"
elif [ -d "/mnt/$1/wbfs" ] && [ -d "/mnt/$1/games" ]; then
	echo -e "$STATUS_OK Drive ${1^^} successfully initialized"
	WIIDIR="/mnt/$1/wbfs"
	GCNDIR="/mnt/$1/games"
else
	echo -e "$STATUS_WARN Drive ${1^^} is not your Wii drive! Defaulting to" /mnt/*/$BACKUPNAME "\b."
	WIIDIR="/mnt/*/$BACKUPNAME/wbfs"
	GCNDIR="/mnt/*/$BACKUPNAME/games"
fi

# Number of games per system
WIIGAMES=$(ls -l $WIIDIR | grep '^d' | wc -l)
GCNGAMES=$(ls -l $GCNDIR | grep '^d' | wc -l)

# Calculates total size of all games
TOTAL_SIZE=$(du -chs $WIIDIR $GCNDIR | tail -n 1 | grep -oE '(^\w.+)[GM]')

# Locates unexpected filename(s)
UNEXWII=$(find $WIIDIR -empty)$(ls $WIIDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
UNEXGCN=$(find $GCNDIR -empty)$(ls $GCNDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

# Main output
if [ -n "$UNEXWII" ]; then
	echo -e "$STATUS_OHNO $WII: Unexpected filename(s) detected"
	echo "$UNEXWII"
else
	echo -e "$STATUS_OK $WII: Looking good!"
	WIIGSTATUS=1
fi

if [ -n "$UNEXGCN" ]; then
	echo -e "$STATUS_OHNO $GCN: Unexpected filename(s) detected"
	echo "$UNEXGCN"
else
	echo -e "$STATUS_OK $GCN: Looking fresh!"
	GCNSTATUS=1
fi

# Outputs total games if both Wii can GCN are ok
if [ $WIIGSTATUS -eq 1 ] && [ $GCNSTATUS -eq 1 ]; then
	echo "$STATUS_COOL $(( $WIIGAMES + $GCNGAMES )) games in $TOTAL_SIZE! Cool!"
fi
exit 0 
