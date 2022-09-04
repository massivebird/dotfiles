#!/usr/bin/env bash

## PARACORD.SH
# generates procedural ascii art
# in fixed rectangle

WIDTH=${1:-8}
HEIGHT=${2:-4}
BG_CHAR="${3:-=}"

PARA_CHARS=("~" "-" "\"" ";" ":" "\`")

# generates ascii canvas as array
generate-canvas () {
	for i in $(seq 1 $[ WIDTH * HEIGHT ]); do
		BG+=( "$BG_CHAR" )
	done
}

# prints array as rectangle
print-it () {
	# print first element
	printf "${BG[0]}"
	# every $WIDTH elements,
	# insert newline
	for i in $(seq 1 $[ WIDTH * HEIGHT ]); do
		if [[ $[ i % WIDTH ] -eq 0 ]]; then
			printf "\n"
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
		char-to-fix () { echo $[ OFFSET * WIDTH ]; }
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

	while [[ $POS_X -ge 0 ]] && [[ $POS_X -le $[ WIDTH - 1 ] ]] && [[ $OFFSET -le $[ HEIGHT - 1 ] ]]; do
		[ $POS_X -ne 0 ] && BG[$[ POS_X + $[ OFFSET * WIDTH ] - 1 ]]="$BORDER"
		[ $POS_X -ne $[ WIDTH - 1 ] ] && BG[$[ POS_X + $[ OFFSET * WIDTH ] + 1 ]]="$BORDER"
		BG[ POS_X + $[ OFFSET * WIDTH ] ]="$FILL"

		# increment
		POS_X=$(D_X)
		OFFSET=$[ OFFSET + 1 ]
	done

	# debug
	# printf '%s\n' "$POS_X:$OFFSET"
	# printf '%s\n' "$(char-to-fix)"

	# fix end if applicable
	if [[ $OFFSET -lt $[ HEIGHT - 0] ]]; then
		BG[$(char-to-fix)]="$BORDER"
	fi
}

generate-canvas
draw-strand
print-it
