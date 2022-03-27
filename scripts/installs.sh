#!/usr/bin/env bash

export NEWT_COLORS='
root=,black
window=,black
checkbox=,black
actcheckbox=brightblue,blue
border=white,black
textbox=white,black
button=brightblue,black
'

CHOICE=$(whiptail --checklist "Choose your packages!" 18 80 10 \
	"UPAPT" "Update apt cache (recommended)" ON \
	"INBASICS" "Basics (git, tree, rename, ...)" OFF \
	"INZSHSHELL" "ZSH" OFF \
	"INZSHPLUG" "ZSH Plugins" OFF \
	"INVIM" "Neovim" OFF \
	"INJS" "JavaScript (npm, nodejs)" OFF \
	"INRS" "Rust" OFF \
	"INPY" "Python" OFF \
	"INCLJ" "Clojure" OFF \
	"INFUN" "Fun times! (cmatrix, nethack)" OFF 3>&1 1>&2 2>&3)

# Updates whiptail gauge with a percent and title
percent-and-title () {
	echo -e "XXX\n$1\n$2\nXXX"
}

## Variables
# Seconds to hang after category completion
PAUSE=2
GAUGE_HEIGHT=6
GAUGE_WIDTH=50

if [[ "$CHOICE" == *"UPAPT"* ]]; then
	{
		percent-and-title 0 "APT: Updating..."
		apt-get update
		percent-and-title 20 "APT: Upgrading..."
		apt-get upgrade -y
		percent-and-title 50 "APT: Updating distro..."
		apt-get dist-upgrade -y
		percent-and-title 75 "APT: Cleaning..."
		apt-get clean
		percent-and-title 100 "APT: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Updating apt stuff..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INBASICS"* ]]; then
	{
		percent-and-title 0 "BASICS: Installing essential libraries..."
		apt install build-essential 2> /dev/null # gcc + more libraries
		percent-and-title 10 "BASICS: Installing Git..."
		apt install git-all 2> /dev/null
		percent-and-title 20 "BASICS: Installing networking tools..."
		apt install net-tools 2> /dev/null # netstat
		percent-and-title 30 "BASICS: Installing tree..."
		apt install tree 2> /dev/null
		percent-and-title 45 "BASICS: Installing youtube-dl..."
		curl -Ls https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
		chmod a+rx /usr/local/bin/yt-dlp
		percent-and-title 60 "BASICS: Installing neofetch..."
		apt install neofetch 2> /dev/null # pretty-print system info
		percent-and-title 80 "BASICS: Installing pandoc..."
		apt install pandoc 2> /dev/null
		percent-and-title 90 "BASICS: Installing rename..."
		apt install rename 2> /dev/null
		percent-and-title 100 "BASICS: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing basic packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INZSHSHELL"* ]]; then
	{
		percent-and-title 0 "ZSH: Installing zsh..."
		apt install zsh 2> /dev/null
		percent-and-title 100 "ZSH: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing ZSH packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INZSHPLUG"* ]]; then
	{
		percent-and-title 0 "ZSH PLUGINS: Installing zplug..."
		curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh # zplug: plugin manager
		percent-and-title 50 "ZSH PLUGINS: Installing zsh-autosuggestions..."
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions: history-based completions
		percent-and-title 100 "ZSH PLUGINS: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing ZSH PLUGINS..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INVIM"* ]]; then
	{
		percent-and-title 0 "NEOVIM: Adding Neovim repository..."
		add-apt-repository ppa:neovim-ppa/unstable
		apt-get update
		percent-and-title 20 "NEOVIM: Installing dependencies..."
		apt install g++
		percent-and-title 70 "NEOVIM: Installing Neovim..."
		apt-get install neovim
		percent-and-title 100 "NEOVIM: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing Neovim packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INJS"* ]]; then
	{
		percent-and-title 0 "JAVASCRIPT: Installing npm..."
		apt install -y npm 2> /dev/null
		percent-and-title 60 "JavaScript: Installing nodejs..."
		{
			curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
			apt-get install -y nodejs 2> /dev/null
		}
		percent-and-title 100 "JavaScript: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing JavaScript packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INRS"* ]]; then
	{
		percent-and-title 50 "RUST: Installing Rust..."
		curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
		percent-and-title 100 "RUST: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing Rust packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INPY"* ]]; then
	echo "Install Python"
	{
		percent-and-title 50 "PYTHON: Installing Python..."
		apt install python3-dev python3-pip python3-setuptools 2> /dev/null
		percent-and-title 100 "PYTHON: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing Python packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INCLJ"* ]]; then
	{
		percent-and-title 0 "CLOJURE: Installing Java dependencies..."
		apt install java
		apt install default-jdk
		percent-and-title 50 "CLOJURE: Installing Clojure..."
		curl -O https://download.clojure.org/install/linux-install-1.10.3.1029.sh
		chmod +x linux-install-1.10.3.1029.sh
		sudo ./linux-install-1.10.3.1029.sh
		percent-and-title 100 "CLOJURE: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing Clojure packages..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
if [[ "$CHOICE" == *"INFUN"* ]]; then
	{
		percent-and-title 0 "FUN: Installing cmatrix..."
		apt install cmatrix
		percent-and-title 50 "FUN: Installing nethack..."
		apt install nethack-console
		percent-and-title 100 "FUN: Done!"
		sleep $PAUSE
	} | whiptail --gauge "Installing fun packages for fun..." $GAUGE_HEIGHT $GAUGE_WIDTH 0
fi
