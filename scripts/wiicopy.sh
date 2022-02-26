#!/usr/bin/etc bash

# Color presets
CYAN="$(tput setaf 45)"
GREEN="$(tput setaf 34)"
MAGENTA="$(tput setaf 99)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 220)"
NC="$(tput sgr 0)"

# Colored strings
WII="${CYAN}WII${NC}"
GCN="${MAGENTA}GCN${NC}"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_WARN="[$YELLOW WARN $NC]"
DRIVE=$(echo "$DRIVE/wbfs" | grep -E '.{6}')

echo
echo "$STATUS_OK Wii drive initialized"
echo
cp -uvr /mnt/d/WIIBACK/README.md $DRIVE/README.md
echo
echo "$STATUS_OK README updated"
echo
cp -uvr /mnt/d/WIIBACK/wbfs/* $DRIVE/wbfs
echo
echo "$STATUS_OK $WII: transfer completed"
echo
cp -uvr /mnt/d/WIIBACK/games/* $DRIVE/games
echo
echo "$STATUS_OK $GCN: transfer completed"
echo
