#!/usr/bin/env bash

## CHATTERINO-HIGHLIGHTS.SH
# takes a list of space-separated strings
# and makes a large regex expression
# that matches all of them w/ "or" logic

# takes input from pastebin
INP=$(curl -s https://pastebin.com/raw/TTkLHuvg)

# remove leading/trailing whitespace
sed -E 's/^\ *|\ *$//' <<< "$INP" | \
	# turns spaces into booleans
	sed 's/\ /|/g'
