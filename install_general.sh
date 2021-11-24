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
	sudo apt install tree
	sudo apt-get install youtube-dl # media downloader
	sudo apt install neofetch # pretty-print system info
fi

echo
read -p "Install ZSH package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install zsh
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	rm -f ~/.zshrc
	ln ~/.config/zsh/.zshrc ~/.zshrc
fi

echo
read -p "Install NEOVIM package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
fi

echo
read -p "Install JS package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install npm
	sudo apt install nodejs
fi

echo
read -p "Install RUST package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi

echo
read -p "Install PYTHON package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install python3-pip
fi

echo
read -p "Install FUNTIMES package? [y/n] " MSG
if [ "$MSG" == "yes" ] || [ "$MSG" == "y" ]; then
	sudo apt install cmatrix
	sudo apt install nethack-console
fi

# # basics
# sudo apt install build-essential # gcc + more libraries
# sudo apt install git-all
# sudo apt install tree
# sudo apt-get install youtube-dl # media downloader

# # zsh
# sudo apt install zsh
# sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# rm -f ~/.zshrc
# ln ~/.config/zsh/.zshrc ~/.zshrc

# # neovim
# sudo add-apt-repository ppa:neovim-ppa/unstable
# sudo apt-get update
# sudo apt-get install neovim

# # js
# sudo apt install npm
# sudo apt install nodejs

# # rust
# curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# # python
# sudo apt install python3-pip

# # absolutely unnecessary
# sudo apt get cmatrix
# sudoapt install nethack-console
