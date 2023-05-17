#!/usr/bin/env bash

## ARCSTAT.SH
# statistics about my local video game archive

. ~/.config/scripts/lib/dir-games.sh
. ~/.config/scripts/lib/str-main.sh
. ~/.config/scripts/lib/str-games.sh

# verifies backup directory existence
if [ -d "$DIR_BACKUP" ]; then
	printf "$STATUS_OK Archive detected\n"
else
	printf "$STATUS_OHNO No archive directory detected\n"
	exit 1
fi

# number of games per system
NUM_DS=$(ls -l $DIR_DS | grep -cE '\.nds')
NUM_DS3=$(ls -l $DIR_DS3 | grep -cE '\.cia')
NUM_GB=$(ls -l $DIR_GB | grep -cE '\.gb[c]?')
NUM_GBA=$(ls -l $DIR_GBA | grep -cE '\.gba')
NUM_GCN=$(ls -l $DIR_GCN | grep -cE '^d.*\[.*')
NUM_GEN=$(ls -l $DIR_GEN | grep -cE '\.md')
NUM_N64=$(ls -l $DIR_N64 | grep -cE '\.[nz]64|.rom')
NUM_NES=$(ls -l $DIR_NES | grep -cE '\.nes')
NUM_PS1=$(ls -l $DIR_PS1 | grep -vcE '^d.*(Disc [^1])|bios|total')
NUM_PS2=$(ls -l $DIR_PS2 | grep -cE '\.(iso|bin)')
NUM_PSP=$(ls -l $DIR_PSP | grep -cE '\.iso')
NUM_SNES=$(ls -l $DIR_SNES | grep -cE '\.sfc')
NUM_WII=$(ls -l $DIR_WII | grep -cE '^d.*\[.*')
NUM_TOTAL=$[ NUM_DS + NUM_DS3 + NUM_GB + NUM_GBA + NUM_GCN + NUM_N64 + NUM_PS2 + NUM_SNES + NUM_WII + NUM_PS1 ]

# calculates total drive usage of all directory arguments
calcsize () {
	du -chs $* | tail -n 1 | grep -oE '(^\w.+)[GM]'
}

# use function above to record drive usages
SIZE_DS=$(calcsize $DIR_DS)
SIZE_DS3=$(calcsize $DIR_DS3)
SIZE_GB=$(calcsize $DIR_GB)
SIZE_GBA=$(calcsize $DIR_GBA)
SIZE_GCN=$(calcsize $DIR_GCN)
SIZE_GEN=$(calcsize $DIR_GEN)
SIZE_N64=$(calcsize $DIR_N64)
SIZE_NES=$(calcsize $DIR_NES)
SIZE_PS1=$(calcsize $DIR_PS1)
SIZE_PS2=$(calcsize $DIR_PS2)
SIZE_PSP=$(calcsize $DIR_PSP)
SIZE_SNES=$(calcsize $DIR_SNES)
SIZE_WII=$(calcsize $DIR_WII)
SIZE_TOTAL=$(calcsize $DIR_WII $DIR_GCN $DIR_PS1 $DIR_PS2 $DIR_PSP $DIR_DS $DIR_DS3 $DIR_GEN $DIR_SNES $DIR_GBA $DIR_GB $DIR_N64 $DIR_NES)

# main output
printf """\n\
$(tput setaf 246)System\tGames\tSize
────────────────────${NC}
${DS3}\t${NUM_DS3}\t${SIZE_DS3}
${DS}\t${NUM_DS}\t${SIZE_DS}
${GB}\t${NUM_GB}\t${SIZE_GB}
${GBA}\t${NUM_GBA}\t${SIZE_GBA}
${GCN}\t${NUM_GCN}\t${SIZE_GCN}
${GEN}\t${NUM_GEN}\t${SIZE_GEN}
${N64}\t${NUM_N64}\t${SIZE_N64}
${NES}\t${NUM_NES}\t${SIZE_NES}
${PS1}\t${NUM_PS1}\t${SIZE_PS1}
${PS2}\t${NUM_PS2}\t${SIZE_PS2}
${PSP}\t${NUM_PSP}\t${SIZE_PSP}
${SNES}\t${NUM_SNES}\t${SIZE_SNES}
${WII}\t${NUM_WII}\t${SIZE_WII}
\t${NUM_TOTAL}\t${SIZE_TOTAL}\n\n"""

exit 0
