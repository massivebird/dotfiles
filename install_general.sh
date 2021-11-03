sudo apt update

# basics
sudo apt install build-essential # gcc + more libraries
sudo apt install git-all
sudo apt install tree
sudo apt-get install youtube-dl # media downloader

# zsh
sudo apt install zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
rm -f ~/.zshrc
ln ~/.config/zsh/.zshrc ~/.zshrc

# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# js
sudo apt install npm
sudo apt install nodejs

# rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# python
sudo apt install python3-pip

# absolutely unnecessary
sudo apt get cmatrix
sudo apt install nethack-console
