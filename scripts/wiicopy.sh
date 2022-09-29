#!/usr/bin/env bash

## WIICOPY.SH
# copies contents of local archive to external HDD,
# only transfers WII and GCN games by default

## OPTIONS
# -a
#	Transfers all system archives
# -v
# 	Copies contents verbosely

# identifies flags
while getopts "av" arg; do
	case "${arg}" in
		v)
			FLAG_VERBOSE=1
			;;
		a)
			FLAG_ALL=1
			;;
	esac
done

. ~/.config/scripts/lib/str-main.sh
. ~/.config/scripts/lib/str-games.sh
. ~/.config/scripts/lib/dir-games.sh

# locates external drive in /mnt/?/ format
if [ -d /mnt/*/wbfs ]; then
	printf "$STATUS_OK External drive detected\n"
	DRIVE=$(grep -oE '.{6}' <<< "/mnt/*/wbfs")
else
	printf "$STATUS_OHNO No external drive detected\n"
	exit
fi

# configures copy function
if [ -n "$FLAG_VERBOSE" ]; then
	COPYOPTS="-ah --progress"
else
	COPYOPTS="-vah --progress"
fi

# copy function per system/item copied
mycopy () {
	printf "$STATUS_CONS Initiating $3 transfer\n"
	rsync $COPYOPTS $1 $2
	printf "$STATUS_OK $3 transfer completed\n"
}

# copying process begins
printf "$STATUS_OK External drive initialized\n"
mycopy $DIRBACKUP/README.md $DRIVE "README"
mycopy "$DIRBACKUP/wbfs/*" $DRIVE/wbfs $WII
mycopy "$DIRBACKUP/games/*" $DRIVE/games $GCN
if [ -n "$FLAG_ALL" ]; then
	printf "$STATUS_CONS -a flag detected. Copying all systems...\n"
	mycopy "$DIRBACKUP/3ds/*" $DRIVE/3ds $DS3
	mycopy "$DIRBACKUP/ds/*" $DRIVE/ds $DS
	mycopy "$DIRBACKUP/gb/*" $DRIVE/gb $GB
	mycopy "$DIRBACKUP/gba/*" $DRIVE/gba $GBA
	mycopy "$DIRBACKUP/n64/*" $DRIVE/n64 $N64
	mycopy "$DIRBACKUP/ps2/*" $DRIVE/ps2 $PS2
	mycopy "$DIRBACKUP/snes/*" $DRIVE/snes $SNES
fi
