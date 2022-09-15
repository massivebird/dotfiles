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
WII_IS_GOOD=0
GCN_IS_GOOD=0

# name of backup directory so I can change it later
DIR_BACKUP="/mnt/d/wiiback"

assign-directories () {
# if user passed $1...
if [ -n "$1" ]; then
	# ... and it contains the correct directories...
	if [ -d "$1/wbfs" ] && [ -d "$1/games" ]; then
		# ... then assign directory vars
		printf "$STATUS_OK $(grep -Eo '\/[^\/]*$' <<< $1) successfully initialized\n"
		DIR_WII="$1/wbfs"
		DIR_GCN="$1/games"
		return
	fi
	# $1 exists but doesn't pass the vibe checks, so
	# exit the script
	printf "$STATUS_OHNO $(grep -Eo '\/[^\/]*$' <<< $1) is an invalid path. Sorry!\n"
	exit 1
fi
# when $1 does not exist
# and $DIR_BACKUP is valid...
if [ -d "$DIR_BACKUP/games" ] && [ -d "$DIR_BACKUP/wbfs" ]; then
	# ... assign directory vars
	printf "$STATUS_OK Backup directory initialized\n"
	DIR_WII="$DIR_BACKUP/wbfs"
	DIR_GCN="$DIR_BACKUP/games"
	return
fi
# $1 does not exist and $DIR_BACKUP is uncool, so
# exit the script
printf "$STATUS_OHNO Backup directory not found! Sorry."
exit 1
} 

assign-directories $@

# number of games per system
GAMES_WII=$(ls -l $DIR_WII | grep '^d' | wc -l)
GAMES_GCN=$(ls -l $DIR_GCN | grep '^d' | wc -l)

# calculates total size of all games
SIZE_TOTAL=$(du -chs $DIR_WII $DIR_GCN | tail -n 1 | grep -oE '(^\w.+)[GM]')

# locates unexpected filename(s)
BAD_WII=$(find $DIR_WII -empty)$(ls $DIR_WII/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
BAD_GCN=$(find $DIR_GCN -empty)$(ls $DIR_GCN/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

# main output
if [ -n "$BAD_WII" ]; then
	printf "$STATUS_OHNO $WII: Unexpected filename(s) detected\n"
	printf "$BAD_WII\n"
else
	printf "$STATUS_OK $WII: Looking good!\n"
	WII_IS_GOOD=1
fi

if [ -n "$BAD_GCN" ]; then
	printf "$STATUS_OHNO $GCN: Unexpected filename(s) detected\n"
	printf "$BAD_GCN\n"
else
	printf "$STATUS_OK $GCN: Looking fresh!\n"
	GCN_IS_GOOD=1
fi

# outputs total games if both Wii can GCN are ok
if [ $WII_IS_GOOD -eq 1 ] && [ $GCN_IS_GOOD -eq 1 ]; then
	printf "$STATUS_COOL $(( $GAMES_WII + $GAMES_GCN )) games in $SIZE_TOTAL! Cool!\n"
fi
exit 0 
