# .bashrc
export EDITOR="vi"
export VISUAL="vi"
export PAGER="less"

# command prompt
export PS1="\[$(tput bold)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\] \n\[$(tput bold)\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# user specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

alias s='source .bashrc'
alias c='cd'
alias conf='cd ~/.config'
alias diff='diff --color always'
alias dirl='dirs -v'
alias exp='explorer.exe'
alias l='ls -1AshX --color=always --group-directories-first'
alias less='less -r'
alias ll='k -Ah --group-directories-first'
alias lll='ls -1Alh --color=always --group-directories-first'
alias lo='gnome-session-save --force-logout'
alias n='$EDITOR'
alias nc='$EDITOR ~/.config/nvim/init.vim'
alias ncf='$EDITOR ~/.bashrc'
alias rename='prename'
alias shx='chmod +x *.sh'
alias s='source ~/.bashrc'
alias tree='tree -RC --dirsfirst'
alias trees='tree -RCI .g -L 2 --dirsfirst'

unset rc
