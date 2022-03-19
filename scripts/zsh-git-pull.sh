#!/usr/bin/env bash

## ZSH-GIT-PULL
# Script utilized by .zshrc to automatically
# update git repositories

## OPTIONAL ARGUMENTS
# -v
# 	Outputs successful git pull messages

# Color presets
GREEN="$(tput setaf 34)"
RED="$(tput setaf 1)"
NC="$(tput sgr 0)"

# Colored strings
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_OHNO="[$RED OHNO $NC]"

# Flag checks
while getopts "v" arg; do
	case "${arg}" in
		v)
			FLAG_VERBOSE=1
			;;
	esac
done

# Main function
source_repo () {
	# Arguments -> readable variables
	REPO_PATH=$1
	REPO_LABEL=$2
	ERROR_DUMP="empty"
	# Check if path exists
	# Perform `git pull`
	if [ -d $REPO_PATH ]; then
		git -C $REPO_PATH pull 1> /dev/null 2> "$ERROR_DUMP"
	else
		echo "$STATUS_OHNO $REPO_LABEL not found."
	fi
	# Print vague error if pull fails
	if [ "$ERROR_DUMP" != "empty" ]; then
		echo "$STATUS_OHNO $REPO_LABEL failed to pull"
	# If -v, print message on successful pull
	elif [ -n "$FLAG_VERBOSE" ]; then
		echo "$STATUS_COOL $REPO_LABEL up to date!"
	fi
}

source_repo "$HOME/.config/" "Configuration directory"
source_repo "$HOME/docs" "Documents"
source_repo "$HOME/academia" "Academia"
