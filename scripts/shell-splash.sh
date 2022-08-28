#!/usr/bin/env bash

## SHELL-SPLASH.SH
# neofetch-like splash text for
# shell startup

## ARGUMENTS
# $1: name of your shell

# global variables
COLOR_SPLASH="$(tput setaf 75)"
COLOR_FETCH="$(tput setaf 33)"
NC="$(tput sgr 0)"

# checks if script argument exists and is a command
if [ -n "$1" ] && command -v $1 > /dev/null; then
	SHELL_INFO=$($1 --version | head -n1)
else
	SHELL_INFO=$(bash --version | head -n1)
fi

## ASCII splash text selector
# ASCII text generator: https://patorjk.com/software/taag/
print-splash-name () {
if [ "$1" == "0" ]; then
	# "big"
	printf "\n${COLOR_SPLASH}\
 _    _      _ _           _____                     _   _   _ 
| |  | |    | | |         / ____|                   | | | | | |
| |__| | ___| | | ___    | |  __  __ _ _ __ _ __ ___| |_| |_| |
|  __  |/ _ \ | |/ _ \   | | |_ |/ _\` | '__| '__/ _ \ __| __| |
| |  | |  __/ | | (_) |  | |__| | (_| | |  | | |  __/ |_| |_|_|
|_|  |_|\___|_|_|\___( )  \_____|\__,_|_|  |_|  \___|\__|\__(_)
	             |/${NC}\n"
elif [ "$1" == "1" ]; then
	# "three point"
	printf "\n${COLOR_SPLASH}\
|_| _ || _    /~_ _  _ _ _ _|__|_|\n\
| |(/_||(_),  \_/(_|| | (/_ |  | .\n${NC}\n"
elif [ "$1" == "2" ]; then
	# "1row"
	printf "\n${COLOR_SPLASH}\
|-| [- |_ |_ ()   (_, /\ /? /? [- ~|~ ~|~\
\n${NC}\n"
elif [ "$1" == "3" ]; then
	# "js cursive"
	printf "\n${COLOR_SPLASH}\
            _   _                                       
  /_   _   //  //  _,_     __  __,   ,_   ,_   _  -/--/-
_/ (__(/__(/__(/__(_/    _(_/_(_/(__/ (__/ (__(/__/__/_ 
                          _/_                           
                         (/${NC}\n"
else
	printf "\nERROR - Missing or invalid splash name selector\n\n"
fi
}

# neofetch-like print format
splash-info () {
printf "$COLOR_FETCH$1$NC: $2\n"
}

print-splash-name 1
printf "$COLOR_FETCH$USER@$HOSTNAME$NC\n"
sed 's/./-/g' <<< "$USER@$HOSTNAME"
splash-info "OS" "$(grep PRETTY_NAME < /etc/os-release | sed -E 's/"|PRETTY_NAME=//g')"
splash-info "Host" "$HOSTNAME"
splash-info "Kernel" "$(uname -r)"
splash-info "Uptime" "$(uptime -p | sed 's/up //')"
splash-info "Shell" "$SHELL_INFO"
splash-info "CPU" "$(lscpu | grep 'Model name' | sed 's/^.*:\ *//')"
printf "\n" # new line
printf "$COLOR_SPLASH\"$(shuf -n 1 ~/.config/scripts/res/splash-messages.txt)\"$NC\n"
printf "\n"
