#!/usr/bin/env bash

## ZSH-GIT-PULL
# Script utilized by .zshrc to automatically
# update git repositories

## OPTIONAL ARGUMENTS
# -v
# 	Outputs successful git pull messages

# Color presets
GRAY="$(tput setaf 240)"
GREEN="$(tput setaf 34)"
RED="$(tput setaf 1)"
NC="$(tput sgr 0)"

# Colored strings
STATUS_CONS="[$(tput setaf 244) CONS $NC]"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OHNO="[$RED OHNO $NC]"
STATUS_OK="[$GREEN  OK  $NC]"
STATUS_SPINOK="[$GREEN#$NC]"

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
	# Declaring readable variables
	REPO_PATH=$1
	REPO_LABEL=$2
	REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"
	# Check if repo path exists
	# If it does...
	if [ -d $REPO_PATH ]; then
		# ...  `git fetch` to get latest remote commits
		git -C $REPO_PATH fetch -q origin $REPO_BRANCH
		# Store differences between newest local and newest remote commits
		DIFF_DUMP=$(git -C $REPO_PATH diff $REPO_BRANCH origin/$REPO_BRANCH --compact-summary)
		# If there are differences...
		if [ -n "$DIFF_DUMP" ]; then
			# ... inform user that it's being updated
			printf "\r$STATUS_CONS Updating $REPO_LABEL...\n"
		fi

		# `git pull` and store its errors
		ERROR_DUMP=$(git -C $REPO_PATH pull -q origin $REPO_BRANCH 2>&1)

		# If `git pull` produced an error...
		if [ -n "$ERROR_DUMP" ]; then
			# ... inform user that the update failed
			printf "\r$STATUS_OHNO $REPO_LABEL failed to pull\n"
			echo $ERROR_DUMP
		# If repo needed to update or -v...
		elif [ -n "$DIFF_DUMP" ] || [ -n "$FLAG_VERBOSE" ]; then
			# ... inform user that the update succeeded
			printf "\r$STATUS_COOL $REPO_LABEL up to date! [$REPO_BRANCH]\n"
		fi
	# If path does not exist...
	else
		# ... inform user and exit the function
		printf "\r$STATUS_OHNO $REPO_LABEL not found.\n"
		return
	fi
	
}

## Calling main function
# $1: absolute path to repo
# $2: human readable repo label
update_all () {
	source_repo "$HOME/.config/" "Configuration"
	source_repo "$HOME/docs" "Documents"
	source_repo "$HOME/academia" "Academia"
}

update_all &
pid=$! # Process Id of the previous running command

spin="-\|/"
tput civis
i=0
while kill -0 $pid 2>/dev/null
do
	i=$(( (i+1) %4  ))
	printf "\r[$GRAY${spin:$i:1}$NC] Updating Git repositories..."
	sleep .1
done
printf "\r$STATUS_SPINOK Git repositories successfully updated\n"
tput cnorm
