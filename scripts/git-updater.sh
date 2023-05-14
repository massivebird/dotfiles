#!/usr/bin/env bash

# updates git repositories,
# customizable via run() function

## OPTIONAL ARGUMENTS
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

check-connection()
{
   curl --max-time 1.3 -Is https://github.com 1> /dev/null

   if [ $? -eq 0 ]; then
      if [ -n "$FLAG_VERBOSE" ]; then
         printf "\r$STATUS_COOL Internet connection established. \n"
      fi
      return
   fi

   if [ -n "$FLAG_VERBOSE" ]; then
      printf "\r$STATUS_OHNO Internet connection bad.   \n"
   fi

   # make sure error file is populated
   printf "L" > /tmp/gitup.txt
   exit 1

}

update-repo()
{

   REPO_PATH=$1
   REPO_LABEL=$2

   if ! [ -d $REPO_PATH ]
   then
      # if repo path does not exist, inform user
      printf "\r$STATUS_OHNO $REPO_LABEL repo path not found.       \n" | tee /tmp/gitup.txt
      return
   fi

   REPO_BRANCH="$(git -C $REPO_PATH branch --show-current)"

   # fetch latest remote commits
   git -C $REPO_PATH fetch -q origin $REPO_BRANCH 2>/dev/null

   # compile commits in remote that are ahead of local
   DIFF_DUMP=$(git -C $REPO_PATH log HEAD..origin/$REPO_BRANCH)

   # if such commits exist
   if [ -n "$DIFF_DUMP" ]; then
      printf "\r$STATUS_CONS Updating $REPO_LABEL...                 \n"
   fi

   # try to pull, storing errors if any
   ERROR_DUMP=$(git -C $REPO_PATH pull -q origin $REPO_BRANCH 2>&1)

   if [ -n "$ERROR_DUMP" ]; then
      printf "\r$STATUS_OHNO $REPO_LABEL failed to pull\n"
      printf $ERROR_DUMP"\n"
      return
   fi

   if [ -n "$FLAG_VERBOSE" ]; then
      printf "\r$STATUS_COOL $REPO_LABEL up to date! $GREEN$REPO_BRANCH$NC        \n"
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
   "/tmp/gitup.txt"

# clears contents of error dump file
: > "/tmp/gitup.txt"
