#!/usr/bin/env bash

## GIT-UPDATER.SH
# Script utilized by .zshrc to automatically
# update git repositories

## OPTIONAL ARGUMENTS
# -v
# 	Outputs successful git pull messages
# -f
#	Exits script immediately, used by shell rc

. ~/.config/scripts/lib/loading-spinner.sh

# Color presets
GRAY="$(tput setaf 240)"
GREEN="$(tput setaf 34)"
RED="$(tput setaf 1)"
NC="$(tput sgr 0)"

# Colored strings
STATUS_CONS="[$(tput setaf 244) CONS $NC]"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OHNO="[$RED OHNO $NC]"

# Flag checks
while getopts "vf" arg; do
	case "${arg}" in
		f) # "Fast"
			exit 0
			;;
		v) # "Verbose"
			FLAG_VERBOSE=1
			;;
	esac
done

# Main function
source_repo () {
	# Declaring variables
	REPO_PATH=$1
	REPO_LABEL=$2
	REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"
	# Check if repo path exists
	# If it does...
	if [ -d $REPO_PATH ]; then
		# ...  `git fetch` to get latest remote commits
		git -C $REPO_PATH fetch -q origin $REPO_BRANCH 2>/dev/null
		# show commits from remote that are not present in local
		DIFF_DUMP=$(git -C $REPO_PATH log HEAD..origin/$REPO_BRANCH)
		# if such commits exist...
		if [ -n "$DIFF_DUMP" ]; then
			# ... inform user that it's being updated
			printf "\r$STATUS_CONS Updating $REPO_LABEL...     \n"
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
			printf "\r$STATUS_COOL $REPO_LABEL up to date! $GREEN$REPO_BRANCH$NC\n"
		fi
	# If path does not exist...
	else
		# ... inform user and exit the function
		printf "\r$STATUS_OHNO $REPO_LABEL not found.\n"
		return
	fi
	echo -n "$ERROR_DUMP" > "/tmp/gitup.txt"
}
# All main function calls
update_all () {
	## Calling main function
	# $1: absolute path to repo
	# $2: human readable repo label
	source_repo "$HOME/.config/" "Configuration"
	source_repo "$HOME/docs" "Documents"
	source_repo "$HOME/academia" "Academia"
	source_repo "$HOME/tutoring" "Tutoring"
}

# Updates all in background...
update_all &
# lib script: generates loading message
loading-spinner \
	"Updating Git repositories..." \
	"Git repositories up to date" \
# Clears contents of error dump file
: > "/tmp/gitup.txt"
