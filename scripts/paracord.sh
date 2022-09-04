#!/usr/bin/env bash

## PARACORD.SH
# generates procedural ascii art
# in fixed rectangle

WIDTH=${1:-8}
HEIGHT=${2:-4}
BG_CHAR="${3:-=}"

PARA_CHARS=("~" "-" "\"")

NL=$'\n'

# generates ascii canvas as array
generate-canvas () {
	for i in $(seq 1 $[ WIDTH * HEIGHT ]); do
		BG+=( "$BG_CHAR" )
	done
}

# prints array as rectangle
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
	# determine starting conditions
	case $[ RANDOM % 2 ] in
		0) # top going left
		BORDER="/"
		D_X () { echo $[POS_X - 1]; }
		char-to-fix () { echo $[ 1 + OFFSET * WIDTH ]; }
		;;
		1) # top going right
		BORDER="\\"
		D_X () { echo $[POS_X + 1]; }
		char-to-fix () { echo $[ $[ 1 + OFFSET ] * WIDTH - 1 ]; }
		;;
	esac

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

	# debug
	# printf "$POS_X:$OFFSET\n"
	# printf "$(char-to-fix)\n"

	# fix end if applicable
	if [[ $OFFSET -lt $HEIGHT ]]; then
		BG[$(char-to-fix)]="$BORDER"
	fi
}

generate-canvas
draw-strand
print-it
