#!/usr/bin/env bash

## NB.SH
# "neovim bin," opens a binary
# in neovim

if [ -z "$1" ]; then
	echo "$0: missing operand"
	exit 1
fi

echo "$1"
nvim $(which "$1")
