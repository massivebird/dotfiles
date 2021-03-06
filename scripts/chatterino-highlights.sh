#!/usr/bin/env bash

## CHATTERINO-HIGHLIGHTS.SH
# Takes a list of space-separated strings
# and makes a large regex expression
# that matches all of them w/ "or" logic

# Takes input from pastebin
INP=$(curl -s https://pastebin.com/raw/TTkLHuvg)

# Remove leading/trailing whitespace
sed -E 's/^\ *|\ *$//' <<< "$INP" | \
	# Turns spaces into booleans
	sed 's/\ /|/g'
