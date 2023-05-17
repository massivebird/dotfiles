#!/usr/bin/env bash

# validates the file system structure for an external storage device
# for use by the Wii Homebrew application "USB Loader GX"

## OPTIONAL ARGUMENTS
# $1
#    Path to the root of your archive, expects two directories:
#    1) ROOT/wbfs  containing Wii games
#    2) ROOT/games containing GameCube games

# dependencies
. ~/.config/scripts/lib/str-main.sh
. ~/.config/scripts/lib/str-games.sh
. ~/.config/scripts/lib/dir-games.sh

get-number-of-games()
{
   echo $(ls -l $@ | grep '^d' | wc -l)
}

assign-directories()
{

   # no path provided -> use defaults
   if [ -z "$1" ] && [ -d "$DIR_BACKUP/games" ] && [ -d "$DIR_BACKUP/wbfs" ]
   then
      DIR_WII="$DIR_BACKUP/wbfs"
      DIR_GCN="$DIR_BACKUP/games"
      printf "$STATUS_OK Analyzing archive at $DIR_BACKUP\n"
      return
   fi

   if [ -d "$1/wbfs" ] && [ -d "$1/games" ]; then
      DIR_WII="$1/wbfs"
      DIR_GCN="$1/games"
      printf "$STATUS_OK Analyzing archive at $1\n"
      return
   fi

   printf "$STATUS_OHNO Invalid archive path.\n"
   exit 1
} 

assign-directories $@

NUM_GAMES_TOTAL=$(get-number-of-games $DIR_WII $DIR_GCN)

SIZE_TOTAL=$(du -chs $DIR_WII $DIR_GCN | tail -n 1 | grep -oE '(^\w.+)[GM]')

BAD_FILES_WII=$(find $DIR_WII -empty)$(ls $DIR_WII/*/* | grep -vE '\!bios|\[([A-Z0-9]{6})\]\/\1\.wbf[s0-9]')
BAD_FILES_GCN=$(find $DIR_GCN -empty)$(ls $DIR_GCN/*/* | grep -vE '\!bios|\[([A-Z0-9]{6})\]\/game\.iso')

declare -i WII_IS_GOOD
declare -i GCN_IS_GOOD

if [ -n "$BAD_FILES_WII" ]; then
   printf "$STATUS_OHNO $WII: Unexpected filename(s) detected\n"
   printf "$BAD_FILES_WII\n"
else
   printf "$STATUS_OK $WII: Looking good!\n"
   WII_IS_GOOD=1
fi

if [ -n "$BAD_FILES_GCN" ]; then
   printf "$STATUS_OHNO $GCN: Unexpected filename(s) detected\n"
   printf "$BAD_FILES_GCN\n"
else
   printf "$STATUS_OK $GCN: Looking fresh!\n"
   GCN_IS_GOOD=1
fi

if [[ $WII_IS_GOOD -eq 1 ]] && [[ $GCN_IS_GOOD -eq 1 ]]; then
   printf "$STATUS_COOL $NUM_GAMES_TOTAL games in $SIZE_TOTAL! Cool!\n"
fi

exit 0 
