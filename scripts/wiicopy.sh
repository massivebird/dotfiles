#!/usr/bin/etc bash

# WIICOPY.SH
# Copies contents of local archive to external HDD

# Color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
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
STATUS_CONS="[$(tput setaf 237) CONS $NC]"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"
DRIVE=$(echo "$DRIVE/wbfs" | grep -E '.{6}')

# Backup directory
DIRBACKUP="/mnt/d/wiiback"

mycopy () {
	cp -uvr $1 $2
	echo "$STATUS_OK $3 transfer completed"
}

echo "$STATUS_OK Wii drive initialized"
mycopy $DIRBACKUP/README.md $DRIVE/README.md "README"
mycopy $DIRBACKUP/wbfs/* $DRIVE/wbfs $WII
mycopy $DIRBACKUP/games/* $DRIVE/games $GCN
if [ %1 = "-a" ]; then
	echo "$STATUS_CONS -a flag detected. Copying all systems..."
	mycopy $DIRBACKUP/ds/* $DRIVE/ds $DS
	mycopy $DIRBACKUP/gb/* $DRIVE/gb $GB
	mycopy $DIRBACKUP/gba/* $DRIVE/gba $GBA
	mycopy $DIRBACKUP/n64/* $DRIVE/n64 $N64
	mycopy $DIRBACKUP/ps2/* $DRIVE/ps2 $PS2
	mycopy $DIRBACKUP/snes/* $DRIVE/snes $SNES
fi
