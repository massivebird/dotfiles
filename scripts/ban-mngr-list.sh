#!/usr/bin/env bash

## BAN-MNGR-LIST.SH
# A tool for formatting a "blocklist" CSV
# into a "to-ban" CSV from CommanderRoot's
# Twitch Tools
# https://twitch-tools.rootonline.de/
# Arguments:
#	$1: pathname to blocklist CSV

# Argument check
if [ -n "$1" ]; then
	FILE="$1";
else
	echo "ban-mngr-list.sh: missing operand"
	exit 1
fi

cat "$FILE" | tr -d $'\r' | cut -d',' -f1
