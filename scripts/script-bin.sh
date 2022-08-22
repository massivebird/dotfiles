#!/usr/bin/env bash

## SCRIPT-BIN.SH
# creates a symbolic link of a script
# in the ~/bin/ directory

# error if missing operand
if [ -z "$1" ]; then
	printf "$0: missing operand\n"
	exit 1
fi

# error if pathname is not an absolute path
# (not necessary, but a good habit)
if ! grep -qE '^[~/]' <<< "$1"; then
	printf "$0: $1: not an absolute path\n"
	exit 1
fi

# error if file does not exist and/or
# is not a shell script
if [ ! -f "$1" ] && ! grep -qE '\.sh$' <<< "$1"; then
	printf "$0: $1: shell script does not exist\n"
	exit 1
fi

ln -ivs "$1" ~/bin/"$(grep -oP '[^\\/:*?"<>|\r\n]+$' <<< "$1"| grep -o '^[^\.]*')"
exit 0
