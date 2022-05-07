#!/usr/bin/env bash

## SCRIPT-BIN.SH
# Creates a symbolic link of a script
# in the ~/bin/ directory

# Error if missing operand
if [ -z "$1" ]; then
	echo "$0: missing operand"
	exit 1
fi

# Error if pathname is not an absolute path
# (not necessary, but a good habit)
if ! grep -qE '^[~/]' <<< "$1"; then
	echo "$0: $1: not an absolute path"
	exit 1
fi

# Error if file does not exist and/or
# is not a shell script
if [ ! -f "$1" ] && ! grep -qE '\.sh$' <<< "$1"; then
	echo "$0: $1: shell script does not exist"
	exit 1
fi

ln -ivs "$1" ~/bin/"$(grep -oP '[^\\/:*?"<>|\r\n]+$' <<< "$1"| grep -o '^[^\.]*')"
exit 0
