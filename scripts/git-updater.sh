#!/usr/bin/env bash

## GIT-UPDATER.SH
# updates git repositories, customizable
# via update-all() function

## OPTIONAL ARGUMENTS
# -v
# 	Outputs successful git pull messages
# -f
#	Exits script immediately, used by shell rc

# load dependencies
. ~/.config/scripts/lib/loading-spinner.sh
. ~/.config/scripts/lib/str-main.sh

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

# validates internet connection
check-connection () {
# tests connection
curl --max-time 1.3 -Is https://github.com 1> /dev/null
# if connection is good...
if [ $? -eq 0 ]; then
   # ... and user wants verbose output...
   if [ -n "$FLAG_VERBOSE" ]; then
      # ... inform user we're cool
      printf "\r$STATUS_COOL Internet connection established. \n"
   fi
   return
fi
# on a bad connection...
if [ -n "$FLAG_VERBOSE" ]; then
   # ... inform user if applicable
   printf "\r$STATUS_OHNO Internet connection bad.   \n"
   fi
   # make sure error file is populated
   # (ping redirection sometimes unreliable)
   printf "L" > /tmp/gitup.txt
   # abort script
   exit 1
}

# updates a git repository
source-repo () {
# arguments -> variables
REPO_PATH=$1
REPO_LABEL=$2
# verify repo path exists, and
# if it does...
if [ -d $REPO_PATH ]; then
   # ...  `git fetch` for latest remote commits
   REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"
   git -C $REPO_PATH fetch -q origin $REPO_BRANCH 2>/dev/null
   # find commits from remote that are not present in local
   DIFF_DUMP=$(git -C $REPO_PATH log HEAD..origin/$REPO_BRANCH)
   # if such commits exist...
   if [ -n "$DIFF_DUMP" ]; then
      # ... inform user that it's being updated
      printf "\r$STATUS_CONS Updating $REPO_LABEL...                 \n"
   fi

# `git pull` while storing its errors
ERROR_DUMP=$(git -C $REPO_PATH pull -q origin $REPO_BRANCH 2>&1)

# if `git pull` produced an error...
if [ -n "$ERROR_DUMP" ]; then
   # ... inform user that the update failed
   printf "\r$STATUS_OHNO $REPO_LABEL failed to pull\n"
   printf $ERROR_DUMP"\n"
   return
fi

# if repo needed to update or -v...
if [ -n "$DIFF_DUMP" ] || [ -n "$FLAG_VERBOSE" ]; then
   # ... inform user that repo is up to date
   printf "\r$STATUS_COOL $REPO_LABEL up to date! $GREEN$REPO_BRANCH$NC        \n"
fi

return
fi
# if repo path does not exist, inform user
printf "\r$STATUS_OHNO $REPO_LABEL repo path not found.       \n" | tee /tmp/gitup.txt
return
}

# contains all function calls
update-all () {
# aborts script on bad connection
check-connection
## source-repo() calls
# $1: absolute path to repo
# $2: human readable repo label
source-repo "$HOME/.config/" "Configuration"
source-repo "$HOME/docs" "Documents"
source-repo "$HOME/academia" "Academia"
source-repo "$HOME/.task" "Tasks"
}

# updates all in background...
update-all &
# ... so loading-spinner can track it
loading-spinner \
   "Updating Git repositories..." \
   "Git repositories up to date" \
   "Git repository update(s) failed :(" \
   "/tmp/gitup.txt"

# clears contents of error dump file
: > "/tmp/gitup.txt"
