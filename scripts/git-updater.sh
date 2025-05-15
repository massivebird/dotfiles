#!/usr/bin/env bash

# updates git repositories,
# customizable via run() function

# optional arguments
# -v
# 	 "Verbose"
# 	 More detailed output
#
# -f
# 	 "Fast"
# 	 Immediately exists script, useful for quick shell reloads

while getopts "vf" arg; do
   case "${arg}" in
      f)
         exit 0
         ;;
      v)
         FLAG_VERBOSE=1
         ;;
   esac
done

# dependencies
. ~/.config/scripts/lib/loading-spinner.sh
. ~/.config/scripts/lib/str-main.sh

SCRIPT_PID=$$
# loading-spinner.sh reads this to determine msg at the end,
# such as "success" or "failure"
SCRIPT_ERROR_FILE="/tmp/gitupd${SCRIPT_PID}errors"

check-connection()
{

   curl --max-time 1.3 -Is https://github.com 1> /dev/null
   if [ $? -eq 0 ]; then
      if [[ $FLAG_VERBOSE -eq 1 ]]; then
         printf "\r$STATUS_COOL Internet connection established. \n"
      fi
      return
   fi

   if [[ $FLAG_VERBOSE -eq 1 ]]; then
      printf "\r$STATUS_OHNO Internet connection bad.   \n"
   fi

   # make sure error file is populated
   printf "L" > $SCRIPT_ERROR_FILE
   exit 1

}

update-repo()
{

   REPO_PATH=$1
   REPO_LABEL=$2
   REPO_REMOTE=$(git -C $REPO_PATH remote show -n)

   if [ ! -d $REPO_PATH ]
   then
      printf "\r$STATUS_OHNO $REPO_LABEL repo path not found.       \n" \
         | tee $SCRIPT_ERROR_FILE
      return
   fi

   REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"

   # fetch latest remote commits
   git -C $REPO_PATH fetch -q $REPO_REMOTE $REPO_BRANCH &> /dev/null

   # compile commits in remote that are ahead of local
   DIFF_DUMP=$(git -C $REPO_PATH log --numstat --format=format:'' HEAD..$REPO_REMOTE/$REPO_BRANCH)

   if [ -z "$DIFF_DUMP" ] && [[ $FLAG_VERBOSE -eq 1 ]]; then
      printf "\r$STATUS_OK $REPO_LABEL already up to date! $GRAY $REPO_BRANCH$NC     \n"
   fi

   git -C $REPO_PATH pull -q origin $REPO_BRANCH &> /dev/null

   if [ $? -ne 0 ]; then
      printf "\r$STATUS_OHNO $REPO_LABEL failed to pull. $RED$REPO_BRANCH$NC\n"
      echo "L" > "$SCRIPT_ERROR_FILE"
      return
   fi

   if [ -n "$DIFF_DUMP" ]; then
      printf "\r$STATUS_COOL $REPO_LABEL has been updated! $GREEN$REPO_BRANCH$NC        \n"
      return
   fi

}

run()
{
   check-connection
   update-repo "$HOME/.config" "Configuration" &
   update-repo "$HOME/docs" "Documents" &
   update-repo "$HOME/academia" "Academia" &
   update-repo "$HOME/.task" "Tasks" &
   wait
}

run &
loading-spinner \
   "Updating Git repositories..." \
   "Git repositories up to date" \
   "Git repository update(s) failed :(" \
   "$SCRIPT_ERROR_FILE"

# clears contents of error dump file
: > "$SCRIPT_ERROR_FILE"
