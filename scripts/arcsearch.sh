#!/usr/bin/env bash

## arcsearch.sh
# performs searches in my video game archive
# with colorful formatted output

## arguments
# $1: string: the query
#     example: "lord of"

# load dependencies
. ~/.config/scripts/lib/dir-games.sh
. ~/.config/scripts/lib/str-main.sh
. ~/.config/scripts/lib/str-games.sh

# associative array
declare -A flava
flava[3ds]=$DS3
flava[ds]=$DS
flava[gb]=$GB
flava[gba]=$GBA
flava[games]=$GCN
flava[genesis]=$GEN
flava[n64]=$N64
flava[nes]=$NES
flava[ps1]=$PS1
flava[ps2]=$PS2
flava[psp]=$PSP
flava[snes]=$SNES
flava[wbfs]=$WII

# final message function,
# $1: number of games found
function say-goodbye() {
   printf "%s\n%s games found\n" "$OUTPUT" "$1"
   exit 0
}

# generates list of matching games based on query
OUTPUT=$(find $DIR_BACKUP -iregex "${DIR_BACKUP//\//\\/}/\w*\/[^\[]*$@.*\/?.*" -type f ! -path "*/projectm/*" ! -path "*/config/*" ! -path "*/apps/*" ! -path "*/codes/*" ! -path "*.cue" ! -path "*/bios/*" 2> /dev/null)

# if find does not find anything...
if [ $(wc -c <<< "$OUTPUT") -eq 1 ]; then
   # ... exit with zero games found
   say-goodbye 0
fi

# eliminate file extensions like .sfc
OUTPUT=$(sed "s&\.[^ ]*$&&" <<< "$OUTPUT")
# eliminate regions like (USA, Europe)
OUTPUT=$(sed -E "s&\ ?\([A-Z]+.*\)&&" <<< "$OUTPUT")
# eliminate square bracket stuff like [C][!]
OUTPUT=$(sed -Ee "s&\[.*\]&&" <<< "$OUTPUT")
# eliminate revisions like (Rev 1)
# OUTPUT=$(sed -E "s& \(Rev.*\)&&" <<< "$OUTPUT")

# for every key in the array...
for key in ${!flava[@]}; do
   # ... replace every instance of the string $DIR_BACKUP/$key
   # with the value associated with $key,
   # AKA the colorized string inside brackets ie. [ SNES ]
   OUTPUT=$(sed "s&$DIR_BACKUP\/$key\/&[ ${flava[$key]} ] &" <<< "$OUTPUT")
done

# condense multiple disks
OUTPUT=$(uniq <<< "$OUTPUT")
# eliminate remaining paths
OUTPUT=$(sed -E "s& ?\/.*$&&" <<< "$OUTPUT")

# exit with number of games
say-goodbye $(wc -l <<< "$OUTPUT")
