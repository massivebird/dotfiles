#!/usr/bin/env bash

## ARCSTAT.SH
# Statistics about my local video game archive

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
PS2="$(tput setaf 242)PS2${NC}"
PSP="$(tput setaf 69)PSP${NC}"
SNES="$(tput setaf 57)SNES${NC}"
WII="${CYAN}WII${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"

# locates backup directory
if [ -d /mnt/*/wiiback ]; then
	echo "$STATUS_OK Archive detected"
	DIRBACKUP=/mnt/*/wiiback
else
	echo "$STATUS_OHNO No archive directory detected"
	exit 1
fi

# system directories
DIRDS="$DIRBACKUP/ds"
DIRDS3="$DIRBACKUP/3ds"
DIRGB="$DIRBACKUP/gb"
DIRGBA="$DIRBACKUP/gba"
DIRGCN="$DIRBACKUP/games"
DIRN64="$DIRBACKUP/n64"
DIRPS2="$DIRBACKUP/ps2"
DIRPSP="$DIRBACKUP/psp"
DIRSNES="$DIRBACKUP/snes"
DIRWII="$DIRBACKUP/wbfs"

# number of games per system
NUMDS=$(ls -l $DIRDS | grep -cE '\.nds')
NUMDS3=$(ls -l $DIRDS3 | grep -cE '\.cia')
NUMGB=$(ls -l $DIRGB | grep -cE '\.gb[c]?')
NUMGBA=$(ls -l $DIRGBA | grep -cE '\.gba')
NUMGCN=$(ls -l $DIRGCN | grep -cE '^d')
NUMN64=$(ls -l $DIRN64 | grep -cE '\.[nz]64|.rom')
NUMPS2=$(ls -l $DIRPS2 | grep -cE '\.iso')
NUMPSP=$(ls -l $DIRPSP | grep -cE '\.iso')
NUMSNES=$(ls -l $DIRSNES | grep -cE '\.sfc')
NUMWII=$(ls -l $DIRWII | grep -cE '^d')
NUMTOTAL=$[ $NUMDS + $NUMDS3 + $NUMGB + $NUMGBA + $NUMGCN + $NUMN64 + $NUMPS2 + $NUMSNES + $NUMWII ]

# calculates total drive usage of all directory arguments
calcsize () {
	du -chs $* | tail -n 1 | grep -oE '(^\w.+)[GM]'
}

# use function above to record drive usages
SIZEDS=$(calcsize $DIRDS)
SIZEDS3=$(calcsize $DIRDS3)
SIZEGB=$(calcsize $DIRGB)
SIZEGBA=$(calcsize $DIRGBA)
SIZEGCN=$(calcsize $DIRGCN)
SIZEN64=$(calcsize $DIRN64)
SIZEPS2=$(calcsize $DIRPS2)
SIZEPSP=$(calcsize $DIRPSP)
SIZESNES=$(calcsize $DIRSNES)
SIZEWII=$(calcsize $DIRWII)
SIZETOTAL=$(calcsize $DIRWII $DIRGCN $DIRPS2 $DIRDS $DIRSNES $DIRGBA $DIRGB $DIRN64)

# main output
printf """\n${HEADER}System${NC}\t${HEADER}# Games${NC}\t${HEADER}Size${NC}
${DS3}\t${NUMDS3}\t${SIZEDS3}
${DS}\t${NUMDS}\t${SIZEDS}
${GB}\t${NUMGB}\t${SIZEGB}
${GBA}\t${NUMGBA}\t${SIZEGBA}
${GCN}\t${NUMGCN}\t${SIZEGCN}
${N64}\t${NUMN64}\t${SIZEN64}
${PS2}\t${NUMPS2}\t${SIZEPS2}
${PSP}\t${NUMPSP}\t${SIZEPSP}
${SNES}\t${NUMSNES}\t${SIZESNES}
${WII}\t${NUMWII}\t${SIZEWII}
\t${NUMTOTAL}\t${SIZETOTAL}\n\n"""

exit 0
