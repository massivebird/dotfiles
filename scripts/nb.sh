#!/usr/bin/env bash

# "neovim bin," opens a script in neovim

if [ -z "$1" ]; then
	printf "$0: missing operand\n"
	exit 1
fi

printf "$1\n"
nvim $(which "$1")
