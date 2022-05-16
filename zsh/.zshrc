# splash screen
if [ -z "$SSH_SHELL" ]; then
	bash ~/.config/scripts/shell-splash.sh
fi

# load all those silly oh-my-zsh scripts
source ~/.config/zsh/lib/*

# If you come from bash you might have to change your $PATH.
export PATH=/bin:/usr/bin:/usr/local/bin:${PATH}:$HOME/bin

# Preferred editor
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# zsh options #########################

# fixes permission errors when cd-ing
setopt auto_cd
# on cd, push prev dir onto dir stack
setopt auto_pushd
# do not push multiple of one dir onto stack
setopt pushd_ignore_dups

# zplug ###############################

# load up zplug plugin manager
source ~/.zplug/init.zsh

# load plugins
zplug "massivebird/k"
zplug "zsh-users/zsh-autosuggestions"
zplug load

# keybinds ############################

# ctrl-backspace deletes word
bindkey '^H' backward-kill-word
# shift-tab navigates to previous menu item
bindkey '^[[Z' reverse-menu-complete
# ctrl-up moves cursor to beginning of line
bindkey '^[[1;5A' beginning-of-line
# ctrl-down moves cursor to end of line
bindkey '^[[1;5B' end-of-line
# ctrl-right moves cursor forward one word
bindkey '^[[1;5C' forward-word
# ctrl-left moves cursor backward one word
bindkey '^[[1;5D' backward-word

# autosuggestions config ##############

# all options: (history completion match_prev_cmd)
export ZSH_AUTOSUGGEST_STRATEGY=(history)

#######################################

# disables BASH history expansion via ![number]
set -K

# variable for vimgrep
export NOTES_DIR=~/academia/notes_all/

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# aliases #############################

# navigation
alias -- -="cd - > /dev/null"
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias conf="~/.config"
alias docc="~/docs"
alias schoo="~/academia"

# git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc!="git commit -v --amend"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gf="git fetch"
alias gl="git log --oneline --decorate=short --graph"
alias gll="git log --graph --stat"
alias glop="git log --graph -p"
alias grs="git restore"
alias gst="git status"
ggpull () { git pull origin $(git branch --show-current); }
ggpush () { git push origin $(git branch --show-current); }

# config shortcuts
alias nc="nvim ~/.config/nvim/init.vim"
alias nck="nvim ~/.config/kitty/kitty.conf"
alias ncr="nvim ~/.config/ranger/rc.conf"
alias ncs="nvim ~/.config/sway/config"
alias ncw="nvim ~/.config/waybar/config"
alias ncws="nvim ~/.config/waybar/style.css"
alias ncz="nvim ~/.config/zsh/.zshrc"

# misc
alias c="cd"
alias clj="clj/"
alias diff="diff --color=always"
alias dirl="dirs -v"
alias exp="explorer.exe"
alias l="ls -1AshX --color=always --group-directories-first"
alias lessr="less -r"
alias ll="k -Ah --group-directories-first"
alias lll="ls -1Alh --color=always --group-directories-first"
alias lo="gnome-session-save --force-logout"
alias n="nvim"
alias nn="ranger $NOTES_DIR"
alias nr="nvim -R"
alias pingg="ping google.com"
alias r="ranger"
alias rename="prename"
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

#######################################

# Updates select git repositories
bash ~/.config/scripts/git-updater.sh $@

# load command prompt
source ~/.config/zsh/eastwood.zsh-theme
