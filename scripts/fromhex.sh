#!/usr/bin/env bash

## fromhex.sh
# converts colors from hex to tput
#
# Arguments :
#	$1: six-character hex code

# argument detection
if [ -z "$1" ]; then
	echo "$0: missing operand"
	exit 1
fi

# http://unix.stackexchange.com/a/269085/67282
hex=${1#"#"}
r=$(printf '0x%0.2s' "$hex")
g=$(printf '0x%0.2s' ${hex#??})
b=$(printf '0x%0.2s' ${hex#????})
printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 + 
(g<75?0:(g-35)/40)*6   +
(b<75?0:(b-35)/40)     + 16 ))"
printf "\n"
exit 0
