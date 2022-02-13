#!/bin/bash

# Output colors
# printf "I ${RED}love${NC} Stack Overflow\n"]']'
NC='\033[0m' # No Color
RED='\033[0;31m'

# Paths to Wii and GCN directories
wiigames=/mnt/*/wiiback/wbfs
gcngames=/mnt/*/wiiback/Games

# Returns unexpected filenames
unexwii=$(ls $wiigames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
unexgcn=$(ls $gcngames/*/* | grep -vE '\[([A-Z0-9]{6})\]\/game\.iso')

if [ $(echo $unexwii | wc -w) -gt 0 ]; then
	echo "Unexpected Wii filenames detected:"
	echo -e $unexwii "\n"
else
	echo -e "Wii games look good!\n"
fi

if [ $(echo $unexgcn | wc -w) -gt 0 ]; then
	echo "Unexpected GCN filenames detected:"
	echo $unexgcn
else
	echo "GCN games look good!"
fi
