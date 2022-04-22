#!/usr/bin/env bash

## SCRIPT-BIN.SH
# Creates a symbolic link of a script
# in the ~/bin/ directory

# Error if missing operand
if [ -z "$1" ]; then
	echo "script-bin.sh: missing operand"
	exit 1
fi

# Error if pathname is not an absolute path
# (not necessary, but a good habit)
if [ $(echo "$1" | grep -E '^[~/]') ]; then
	echo "script-bin.sh: $1: not an absolute path"
	exit 1
fi

# Error if file does not exist and/or
# is not a shell script
if [ ! -f "$1" ] && [ -z $(echo "$1" | grep -E '\.sh$') ]; then
	echo "script-bin.sh: $1: shell script does not exist"
	exit 1
fi

ln -s "$1" ~/bin/"$(echo "$1" | grep '^[^\.]*')"
