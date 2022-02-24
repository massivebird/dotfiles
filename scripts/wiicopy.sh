#!/usr/bin/etc bash

DRIVE=$(echo "$DRIVE/wbfs" | grep -E '.{6}')

cp -uvr /mnt/d/WIIBACK/games/* $DRIVE/games
cp -uvr /mnt/d/WIIBACK/wbfs/* $DRIVE/wbfs
cp -uvr /mnt/d/WIIBACK/README.md $DRIVE/README.md
