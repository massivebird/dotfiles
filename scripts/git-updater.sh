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

# color presets
GRAY="$(tput setaf 240)"
GREEN="$(tput setaf 34)"
RED="$(tput setaf 1)"
NC="$(tput sgr 0)"

# colored strings
STATUS_CONS="[$(tput setaf 244) CONS $NC]"
STATUS_COOL="[$GREEN COOL $NC]"
STATUS_OHNO="[$RED OHNO $NC]"

# flag checks
while getopts "vf" arg; do
	case "${arg}" in
		f) # "fast"
			exit 0
			;;
		v) # "verbose"
			FLAG_VERBOSE=1
			;;
	esac
done

# validate internet connection
check-connection () {
	# if connection is good...
	if ping -q -c 1 github.com 1> /dev/null 2> /tmp/gitup.txt; then
		# ... all is good
		if [ -n "$FLAG_VERBOSE" ]; then
			printf "\r$STATUS_COOL Internet connection established. \n"
		fi
		# exit back to main()
		return
	fi
	# bad connection
		if [ -n "$FLAG_VERBOSE" ]; then
			printf "\r$STATUS_OHNO Internet connection bad.   \n"
		fi
	exit 1
}

# main function
source-repo () {
	# declaring variables
	REPO_PATH=$1
	REPO_LABEL=$2
	REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"
	# check if repo path exists
	# if it does...
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

		# if `git pull` produced an error...
		if [ -n "$ERROR_DUMP" ]; then
			# ... inform user that the update failed
			printf "\r$STATUS_OHNO $REPO_LABEL failed to pull\n"
			echo $ERROR_DUMP
		# if repo needed to update or -v...
		elif [ -n "$DIFF_DUMP" ] || [ -n "$FLAG_VERBOSE" ]; then
			# ... inform user that the update succeeded
			printf "\r$STATUS_COOL $REPO_LABEL up to date! $GREEN$REPO_BRANCH$NC\n"
		fi
	# if path does not exist...
	else
		# ... inform user and exit the function
		printf "\r$STATUS_OHNO $REPO_LABEL not found.\n"
		return
	fi
	echo -n "$ERROR_DUMP" > "/tmp/gitup.txt"
}

# all main function calls
update-all () {
	## calling main function
	# $1: absolute path to repo
	# $2: human readable repo label
	check-connection
	source-repo "$HOME/.config/" "Configuration"
	source-repo "$HOME/docs" "Documents"
	source-repo "$HOME/academia" "Academia"
	source-repo "$HOME/tutoring" "Tutoring"
}

# updates all in background...
update-all &
# lib script: generates loading message
loading-spinner \
	"Updating Git repositories..." \
	"Git repositories up to date" \
	"Git repository update failed :(" \
	"/tmp/gitup.txt"
# clears contents of error dump file
: > "/tmp/gitup.txt"
