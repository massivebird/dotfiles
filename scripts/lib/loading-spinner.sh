#!/usr/bin/env bash

## loading-spinner.sh
# Generates loading spinner animation
# for most recent background process
#
# ARGUMENTS :
# $1: Loading message
# $2: Done message
# $3: Error message (requires $4)
# $4: Error file (if file is non-empty,
# then print error message)

# Formatted strings
NC="$(tput sgr 0)"
SPIN_OHNO="[$(tput setaf 1)!$NC]"
SPIN_OK="[$(tput setaf 34)-$NC]"

loading-spinner () {
# Assign positional args to variables
MSG_LOADING="$1"
MSG_DONE="$2"
MSG_ERROR="$3"
ERRORFILE="$4"
# Fetch PID of most recent background process
pid=$!
# Spinner animation frames
SPIN="-\|/"
# Makes cursor invisible
tput civis
# Index var for the loop
i=0
# Animation loop
while kill -0 $pid 2>/dev/null; do
	i=$(( (i+1) %4  ))
	printf "\r[$GRAY${SPIN:$i:1}$NC] $MSG_LOADING"
	sleep .1
done
# Final status message
if [ $(wc -c <<< "$ERRORFILE") -ne 0 ] && [ -n "$MSG_ERROR" ] && [ -n "$ERRORFILE" ]; then
	printf "\r$SPIN_OHNO $MSG_ERROR      \n"
else
	printf "\r$SPIN_OK $MSG_DONE       \n"
fi
# Makes cursor visible
tput cnorm
}
