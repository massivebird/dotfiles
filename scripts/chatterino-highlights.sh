#!/usr/bin/env bash

# reads list of space-separated strings,
# creates regex expression matching all words
# w/ "or" logic

INPUT=$(curl -s https://pastebin.com/raw/TTkLHuvg)

# remove leading/trailing whitespace
sed -E 's/^\ *|\ *$//' <<< "$INPUT" | \
	# spaces to pipes
	sed 's/\ /|/g ; s/|$//'
