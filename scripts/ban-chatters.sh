#!/usr/bin/env bash

## BAN-CHATTERS.SH
# tool for formatting a "blocklist" CSV
# into a "to-ban" CSV from CommanderRoot's
# Twitch Tools
# https://twitch-tools.rootonline.de/

# Arguments:
#	$1: pathname to blocklist CSV

# argument check
if [ -n "$1" ]; then
	FILE="$1";
else
	echo "$0: missing operand"
	exit 1
fi

cat "$FILE" | tr -d $'\r' | cut -d',' -f1 > ban-these-chatters.txt
echo "Wrote to ban-these-chatters.txt in the current working directory."
