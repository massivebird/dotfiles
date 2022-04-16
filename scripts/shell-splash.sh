#!/usr/bin/env bash

## SHELL-SPLASH.SH
# Neofetch-like splash text for
# shell startup

# Global variables
COLOR_SPLASH="$(tput setaf 75)"
COLOR_FETCH="$(tput setaf 33)"
NC="$(tput sgr 0)"

## ASCII splash text selector
# ASCII text generator: https://patorjk.com/software/taag/
echo-splash-name () {
if [ "$1" == "0" ]; then
	# "Short"
	echo -e "\n${COLOR_SPLASH}|_| _ ||     /~        _ |-|- |\n| |(/_||(),  \_|(||\`|\`(/_|_|_ .\n${NC}"
elif [ "$1" == "1" ]; then
	# "Three Point"
	echo -e "\n${COLOR_SPLASH}|_| _ || _    /~_ _  _ _ _ _|__|_|\n| |(/_||(_),  \_/(_|| | (/_ |  | .\n${NC}"
else
	echo -e "\nERROR - Missing or invalid splash name selector\n"
fi
}

# Neofetch-like print format
echo-fetch () {
echo "$COLOR_FETCH$1$NC: $2"
}

echo-splash-name 1
echo -e "$COLOR_FETCH$USER@$HOSTNAME$NC"
echo "$USER@$HOSTNAME" | sed 's/./-/g'
echo-fetch "OS" "$(grep PRETTY_NAME < /etc/os-release | sed -E 's/"|PRETTY_NAME=//g')"
echo-fetch "Host" "$HOSTNAME"
echo-fetch "Kernel" "$(uname -r)"
echo-fetch "Uptime" "$(uptime -p | sed 's/up //')"
echo-fetch "Shell" "$(zsh --version)"
echo-fetch "CPU" "$(lscpu | grep 'Model name' | sed 's/^.*:\ *//')"
echo # New line
echo "$COLOR_SPLASH\"$(shuf -n 1 ~/.config/scripts/res/splash-messages.txt)\"$NC"
echo 
