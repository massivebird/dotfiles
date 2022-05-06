# splash screen
if [ -z "$SSH_SHELL" ]; then
	bash ~/.config/scripts/shell-splash.sh
fi

# If you come from bash you might have to change your $PATH.
export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}:$HOME/bin

# Preferred editor
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Load up zplug plugin manager
source ~/.zplug/init.zsh

# zplug: install plugins
zplug "massivebird/k"
zplug "zsh-users/zsh-autosuggestions"
zplug load

# Fix permission errors when cd-ing
setopt auto_cd

# Disables BASH history expansion via ![number]
set -K

# Variable for vimgrep
export NOTES_DIR=~/academia/notes_all/

# Aliases
alias c="cd"
alias clj="clj/"
alias conf="~/.config"
alias diff="diff --color=always"
alias dirl="dirs -v"
alias exp="explorer.exe"
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc!="git commit -v --amend"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gf="git fetch"
alias ggpull="git pull origin $(git_current_branch)"
alias ggpush="git push origin $(git_current_branch)"
alias gl="git log --oneline --decorate=short --graph"
alias gll="git log --graph --stat"
alias glop="git log --graph -p"
alias grs="git restore"
alias gst="git status"
alias l="ls -1AshX --color=always --group-directories-first"
alias lessr="less -r"
alias ll="k -Ah --group-directories-first"
alias lll="ls -1Alh --color=always --group-directories-first"
alias lo="gnome-session-save --force-logout"
alias n="nvim"
alias nc="nvim ~/.config/nvim/init.vim"
alias nck="nvim ~/.config/kitty/kitty.conf"
alias ncr="nvim ~/.config/rofi/config.css"
alias ncs="nvim ~/.config/sway/config"
alias ncw="nvim ~/.config/waybar/config"
alias ncws="nvim ~/.config/waybar/style.css"
alias ncz="nvim ~/.config/zsh/.zshrc"
alias nn="ranger $NOTES_DIR"
alias nr="nvim -R"
alias pingg="ping google.com"
alias r="ranger ."
alias rename="prename"
alias schoo="~/academia"
alias shx="chmod +x *.sh"
alias src="source ~/.zshrc"
alias tree="tree -RC --dirsfirst"
alias trees="tree -RCI .g -L 2 --dirsfirst"
alias ytd="yt-dlp"
alias ytdy="yt-dlp -f 22 --embed-thumbnail --embed-chapters --embed-subs --compat-options no-live-chat"
alias zpc="zplug clean"
alias zpi="zplug install"
alias zpl="zplug list"
alias zpu="zplug update"

# Updates select git repositories
bash ~/.config/scripts/git-updater.sh $@

# load command prompt
source ~/.config/zsh/eastwood.zsh-theme
