#!/usr/bin/env bash

## OLD-INSTALLS.SH (deprecated)
# Original non-GUI version of current
# installs.sh

echo
read -p "Update APT cache? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt update
fi

echo
read -p "Install BASICS package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install build-essential # gcc + more libraries
	sudo apt install git-all
   sudo apt install net-tools # netstat
	sudo apt install tree
	sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
	sudo chmod a+rx /usr/local/bin/yt-dlp
	sudo apt install neofetch # pretty-print system info
	sudo apt install pandoc
	sudo apt install rename
fi

echo
read -p "Install ZSH package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install zsh
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi

echo
read -p "Install ZSH PLUGINS? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh # zplug: plugin manager
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions: history-based completions
fi

echo
read -p "Install NEOVIM package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
	# sudo dnf install -y g++ fixes treesitter errors
fi

echo
read -p "Install JS package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install npm
	curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
	sudo apt-get install -y nodejs
fi

echo
read -p "Install RUST package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi

echo
read -p "Install PYTHON package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install python3-dev python3-pip python3-setuptools
fi

echo
read -p "Install CLOJURE package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	curl -O https://download.clojure.org/install/linux-install-1.10.3.1029.sh
	chmod +x linux-install-1.10.3.1029.sh
	sudo ./linux-install-1.10.3.1029.sh
	sudo apt install java
	sudo apt install default-jdk
fi

echo
read -p "Install FUNTIMES package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install cmatrix
	sudo apt install nethack-console
fi
