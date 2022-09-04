#!/usr/bin/env bash

## PARACORD.SH
# generates procedural ascii art
# in fixed rectangle

WIDTH=10
HEIGHT=4
BG_CHAR="="
PARA_CHARS=("~" "-" "\"")

NL=$'\n'

generate-canvas () {
	for i in $(seq 1 $[ WIDTH * HEIGHT ]); do
		BG+=( "$BG_CHAR" )
	done
}

print-it () {
	for i in $(seq 1 $[ WIDTH * HEIGHT ]); do
		if [[ $[ i % WIDTH ] -eq 0 ]]; then
			printf "\n"
			continue
		fi
		printf "${BG[$i]}"
	done

}

# generates procedural strand
draw-strand () {
	# generate direction
	DIR=$[ RANDOM % 2 ]

	# direction is left
	if [[ $[ RANDOM % 2 ] -eq 0 ]]; then
		BORDER="/"
		D_X () { echo $[POS_X - 1]; }
		char-to-fix () { echo $[ 1 + OFFSET * WIDTH ]; }
	else
		BORDER="\\"
		D_X () { echo $[POS_X + 1]; }
		char-to-fix () { echo $[ $[ 1 + OFFSET ] * WIDTH - 1 ]; }
	fi

	# generate starting point for strand,
	# never on the edge
	POS_X=$[ 2 + $[ RANDOM % $[ WIDTH - 3 ] ] ]
	OFFSET=0

	# generate random filler character
	FILL=${PARA_CHARS[$[ RANDOM % ${#PARA_CHARS[@]} ]]}

	while [[ $[ POS_X % WIDTH ] -ne 0 ]]; do
	# print line
	BG[$[ POS_X + $[ OFFSET * WIDTH ] - 1 ]]="$BORDER"
	BG[$[ POS_X + $[ OFFSET * WIDTH ] + 1 ]]="$BORDER"
	BG[ POS_X + $[ OFFSET * WIDTH ] ]="$FILL"

	# increment
	POS_X=$(D_X)
	OFFSET=$[ OFFSET + 1 ]
	done
	printf "$POS_X:$OFFSET\n"
	if [[ $OFFSET -lt $HEIGHT ]]; then
		printf "$(char-to-fix)\n"
		BG[$(char-to-fix)]="$BORDER"
	fi
}

generate-canvas
draw-strand
print-it
