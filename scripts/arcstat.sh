#!/usr/bin/env bash

## ARCHSTAT.SH
# Statistics about my local video game archive

# Color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
HEADER="$(tput setab 237)"
NC="$(tput sgr 0)"

# Colored strings
DS="$(tput setaf 253)DS${NC}"
GB="$(tput setaf 65)GB${NC}"
GBA="$(tput setaf 219)GBA${NC}"
GCN="${MAGENTA}GCN${NC}"
N64="$(tput setaf 42)N64${NC}"
PS2="$(tput setaf 242)PS2${NC}"
SNES="$(tput setaf 57)SNES${NC}"
WII="${CYAN}WII${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

# Parent backup directory
# contains all relevant directories below
DIRBACKUP="/mnt/d/wiiback"

# System directories
DIRDS="$DIRBACKUP/ds"
DIRGB="$DIRBACKUP/gb"
DIRGBA="$DIRBACKUP/gba"
DIRGCN="$DIRBACKUP/games"
DIRN64="$DIRBACKUP/n64"
DIRPS2="$DIRBACKUP/ps2"
DIRSNES="$DIRBACKUP/snes"
DIRWII="$DIRBACKUP/wbfs"

# Number of games per system
NUMDS=$(ls -l $DIRDS | grep -E '\.nds' | wc -l)
NUMGB=$(ls -l $DIRGB | grep -E '\.gb[c]?' | wc -l)
NUMGBA=$(ls -l $DIRGBA | grep -E '\.gba' | wc -l)
NUMGCN=$(ls -l $DIRGCN | grep -E '^d' | wc -l)
NUMN64=$(ls -l $DIRN64 | grep -E '\.[nz]64|.rom' | wc -l)
NUMPS2=$(ls -l $DIRPS2 | grep -E '\.iso' | wc -l)
NUMSNES=$(ls -l $DIRSNES | grep -E '\.sfc' | wc -l)
NUMWII=$(ls -l $DIRWII | grep -E '^d' | wc -l)
NUMTOTAL=$[ $NUMDS + $NUMGB + $NUMGBA + $NUMGCN + $NUMN64 + $NUMPS2 + $NUMSNES + $NUMWII ]

# Calculates total drive usage of all directory arguments
calcsize () {
	du -chs $* | tail -n 1 | grep -oE '(^\w.+)[GM]'
}

# Drive usage
SIZEDS=$(calcsize $DIRDS)
SIZEGB=$(calcsize $DIRGB)
SIZEGBA=$(calcsize $DIRGBA)
SIZEGCN=$(calcsize $DIRGCN)
SIZEN64=$(calcsize $DIRN64)
SIZEPS2=$(calcsize $DIRPS2)
SIZESNES=$(calcsize $DIRSNES)
SIZEWII=$(calcsize $DIRWII)
SIZETOTAL=$(calcsize $DIRWII $DIRGCN $DIRPS2 $DIRDS $DIRSNES $DIRGBA $DIRGB $DIRN64)

echo # Output newline

echo -e "${HEADER}System${NC}\t${HEADER}# Games${NC}\t${HEADER}""Size${NC}"
echo -e "${DS}\t${NUMDS}\t${SIZEDS}"
echo -e "${GB}\t${NUMGB}\t${SIZEGB}"
echo -e "${GBA}\t${NUMGBA}\t${SIZEGBA}"
echo -e "${GCN}\t${NUMGCN}\t${SIZEGCN}"
echo -e "${N64}\t${NUMN64}\t${SIZEN64}"
echo -e "${PS2}\t${NUMPS2}\t${SIZEPS2}"
echo -e "${SNES}\t${NUMSNES}\t${SIZESNES}"
echo -e "${WII}\t${NUMWII}\t${SIZEWII}"
echo -e "\t${NUMTOTAL}\t${SIZETOTAL}"

echo # Output newline
