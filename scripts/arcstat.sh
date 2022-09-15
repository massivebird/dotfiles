#!/usr/bin/env bash

## ARCSTAT.SH
# statistics about my local video game archive

# path to backup directory
DIR_BACKUP="/mnt/d/wiiback"
# and subsequent game directories
DIR_DS3="$DIR_BACKUP/3ds"
DIR_DS="$DIR_BACKUP/ds"
DIR_GB="$DIR_BACKUP/gb"
DIR_GBA="$DIR_BACKUP/gba"
DIR_GCN="$DIR_BACKUP/games"
DIR_N64="$DIR_BACKUP/n64"
DIR_PS1="$DIR_BACKUP/ps1"
DIR_PS2="$DIR_BACKUP/ps2"
DIR_PSP="$DIR_BACKUP/psp"
DIR_SNES="$DIR_BACKUP/snes"
DIR_WII="$DIR_BACKUP/wbfs"


# color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
HEADER="$(tput setab 237)"
NC="$(tput sgr 0)"

# colored strings
DS="$(tput setaf 253)DS${NC}"
DS3="$(tput setaf 160)3DS${NC}"
GB="$(tput setaf 65)GB${NC}"
GBA="$(tput setaf 219)GBA${NC}"
GCN="${MAGENTA}GCN${NC}"
N64="$(tput setaf 42)N64${NC}"
PS1="$(tput setaf 249)PS1${NC}"
PS2="$(tput setaf 242)PS2${NC}"
PSP="$(tput setaf 69)PSP${NC}"
SNES="$(tput setaf 57)SNES${NC}"
WII="${CYAN}WII${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

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
NUM_GCN=$(ls -l $DIR_GCN | grep -cE '^d')
NUM_N64=$(ls -l $DIR_N64 | grep -cE '\.[nz]64|.rom')
NUM_PS1=$(ls -l $DIR_PS1 | grep -vcE '^d.*(Disc [^1])|bios|total')
NUM_PS2=$(ls -l $DIR_PS2 | grep -cE '\.iso')
NUM_PSP=$(ls -l $DIR_PSP | grep -cE '\.iso')
NUM_SNES=$(ls -l $DIR_SNES | grep -cE '\.sfc')
NUM_WII=$(ls -l $DIR_WII | grep -cE '^d')
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
SIZE_N64=$(calcsize $DIR_N64)
SIZE_PS1=$(calcsize $DIR_PS1)
SIZE_PS2=$(calcsize $DIR_PS2)
SIZE_PSP=$(calcsize $DIR_PSP)
SIZE_SNES=$(calcsize $DIR_SNES)
SIZE_WII=$(calcsize $DIR_WII)
SIZE_TOTAL=$(calcsize $DIR_WII $DIR_GCN $DIR_PS1 $DIR_PS2 $DIR_DS $DIR_SNES $DIR_GBA $DIR_GB $DIR_N64)

# main output
printf """\n\
$(tput setaf 246)System\tGames\tSize
────────────────────${NC}
${DS3}\t${NUM_DS3}\t${SIZE_DS3}
${DS}\t${NUM_DS}\t${SIZE_DS}
${GB}\t${NUM_GB}\t${SIZE_GB}
${GBA}\t${NUM_GBA}\t${SIZE_GBA}
${GCN}\t${NUM_GCN}\t${SIZE_GCN}
${N64}\t${NUM_N64}\t${SIZE_N64}
${PS1}\t${NUM_PS1}\t${SIZE_PS1}
${PS2}\t${NUM_PS2}\t${SIZE_PS2}
${PSP}\t${NUM_PSP}\t${SIZE_PSP}
${SNES}\t${NUM_SNES}\t${SIZE_SNES}
${WII}\t${NUM_WII}\t${SIZE_WII}
\t${NUM_TOTAL}\t${SIZE_TOTAL}\n\n"""

exit 0
