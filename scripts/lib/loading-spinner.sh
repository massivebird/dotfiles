#!/usr/bin/env bash

## loading-spinner.sh
# based on https://unix.stackexchange.com/a/225183,
# generates loading spinner animation for
# most recent background process

# ARGUMENTS :
# $1: loading message
# $2: successful process message
# optional $3: error message (requires $4)
#          $4: error file (if non-empty, print $3)

. ~/.config/scripts/lib/str-main.sh

# formatted strings
SPIN_OHNO="[$RED!$NC]"
SPIN_OK="[$GREEN-$NC]"

# prevent keyboard input
stty -echo

# runs on interrupt
function on_interrupt() {
   tput cnorm
   exit 2
}

loading-spinner () {
   # init interrupt trap
   trap "on_interrupt" SIGINT
	# assign positional args to variables
	MSG_LOADING="$1"
	MSG_DONE="$2"
	MSG_ERROR="$3"
	ERRORFILE="$4"
	# fetch PID of most recent background process
	pid=$!
	# spinner animation frames
	SPIN="-\|/"
	# makes cursor invisible
	tput civis
	# index var for the loop
	i=0
	# animation loop
	while kill -0 $pid 2>/dev/null; do
		i=$(( (i+1) %4  ))
		printf "\r[$GRAY${SPIN:$i:1}$NC] $MSG_LOADING"
		sleep .1
	done
	# final status message
	if [ -s "$ERRORFILE" ] && [ -n "$MSG_ERROR" ] && [ -n "$ERRORFILE" ]; then
		printf "\r$SPIN_OHNO $MSG_ERROR      \n"
	else
		printf "\r$SPIN_OK $MSG_DONE       \n"
	fi
	# makes cursor visible
	tput cnorm
}
