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
STATUS_CONS="[$(tput setaf 244) CONS $NC]"
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
	REPO_BRANCH="$(git -C $REPO_PATH branch -a | grep -Po '(?<=\*\ ).*')"
	# Check if path exists
	if [ -d $REPO_PATH ]; then
		# If path exists,
		# check if it needs updating
		git -C $REPO_PATH fetch -q origin $REPO_BRANCH
		DIFF_DUMP=$(git -C $REPO_PATH diff $REPO_BRANCH origin/$REPO_BRANCH)
		if [ -n "$DIFF_DUMP" ]; then
			echo "$STATUS_CONS Updating $REPO_LABEL..."
		fi
		ERROR_DUMP=$(git -C $REPO_PATH pull -q origin $REPO_BRANCH 2>&1)
	else
		echo "$STATUS_OHNO $REPO_LABEL not found."
	fi
	# Print vague error if pull fails
	if [ -n "$ERROR_DUMP" ]; then
		echo "$STATUS_OHNO $REPO_LABEL failed to pull"
	# If -v, print message on successful pull
	elif [ -n "$FLAG_VERBOSE" ]; then
		echo "$STATUS_COOL $REPO_LABEL up to date! [$REPO_BRANCH]"
	fi
}

source_repo "$HOME/.config/" "Configuration directory"
source_repo "$HOME/docs" "Documents"
source_repo "$HOME/academia" "Academia"
