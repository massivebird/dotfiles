#!/usr/bin/env bash

## MOUNTD
# [ For WSL on Windows ]
# Mounts a drive visible through Windows
# to the WSL file system

## ARGUMENTS
# $1: Drive letter as it appears in Windows
# $2: Drive letter to assign in WSL

sudo mount -t drvfs $1: /mnt/$2
