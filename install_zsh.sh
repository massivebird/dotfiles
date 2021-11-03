# zsh
sudo apt install zsh
# oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# replace configuration file
rm -f ~/.zshrc
ln ~/.config/zsh/.zshrc ~/.zshrc
