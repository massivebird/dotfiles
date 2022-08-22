#!/usr/bin/env bash

## WIICHECK
# validates the file system structure for an external
# storage device to be used by the Wii Homebrew application "USB Loader GX"

## OPTIONAL ARGUMENTS
# $1: single character drive letter of the Wii external storage device

# color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
NC="$(tput sgr 0)"

# colored strings
WII="${CYAN}WII${NC}"
GCN="${MAGENTA}GCN${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

# status check for after regex evaluations
WIIGSTATUS=0
GCNSTATUS=0

# name of backup directory so I can change it later
BACKUPNAME="WIIBACK"

# paths to Wii and GCN directories based on optional argument
if [ ! -d "/mnt/d/$BACKUPNAME" ]; then
	printf "$STATUS_OHNO No valid directories found. Sorry!\n"
	exit 1
elif [ -z "$1" ]; then
	printf "$STATUS_OK Backup directory initialized\n"
	WIIDIR="/mnt/*/$BACKUPNAME/wbfs"
	GCNDIR="/mnt/*/$BACKUPNAME/games"
elif [ -d "/mnt/$1/wbfs" ] && [ -d "/mnt/$1/games" ]; then
	printf "$STATUS_OK Drive ${1^^} successfully initialized\n"
	WIIDIR="/mnt/$1/wbfs"
	GCNDIR="/mnt/$1/games"
else
	printf "$STATUS_WARN Drive ${1^^} is not your Wii drive! Defaulting to" /mnt/*/$BACKUPNAME "\b.\n"
	WIIDIR="/mnt/*/$BACKUPNAME/wbfs"
	GCNDIR="/mnt/*/$BACKUPNAME/games"
fi

# number of games per system
WIIGAMES=$(ls -l $WIIDIR | grep '^d' | wc -l)
GCNGAMES=$(ls -l $GCNDIR | grep '^d' | wc -l)

# calculates total size of all games
TOTAL_SIZE=$(du -chs $WIIDIR $GCNDIR | tail -n 1 | grep -oE '(^\w.+)[GM]')

# locates unexpected filename(s)
UNEXWII=$(find $WIIDIR -empty)$(ls $WIIDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
UNEXGCN=$(find $GCNDIR -empty)$(ls $GCNDIR/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

# main output
if [ -n "$UNEXWII" ]; then
	printf "$STATUS_OHNO $WII: Unexpected filename(s) detected\n"
	printf "$UNEXWII\n"
else
	printf "$STATUS_OK $WII: Looking good!\n"
	WIIGSTATUS=1
fi

if [ -n "$UNEXGCN" ]; then
	printf "$STATUS_OHNO $GCN: Unexpected filename(s) detected\n"
	printf "$UNEXGCN\n"
else
	printf "$STATUS_OK $GCN: Looking fresh!\n"
	GCNSTATUS=1
fi

# outputs total games if both Wii can GCN are ok
if [ $WIIGSTATUS -eq 1 ] && [ $GCNSTATUS -eq 1 ]; then
	printf "$STATUS_COOL $(( $WIIGAMES + $GCNGAMES )) games in $TOTAL_SIZE! Cool!\n"
fi
exit 0 
