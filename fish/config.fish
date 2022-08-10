# Set some display-related env vars when in graphical environment so I can use
# fish to reliably launch graphical apps by using `fish -c "somecommand"`
if set -q XDG_CURRENT_DESKTOP
	set -x _JAVA_AWT_WM_NONREPARENTING 1
	# If using wayland, set appropriate env vars
	if set -q WAYLAND_DISPLAY
		set -x MOZ_ENABLE_WAYLAND 1
		set -x QT_QPA_PLATFORM 'wayland'
	end
	if test (command -s qt5ct)
		set -x QT_QPA_PLATFORMTHEME "qt5ct"
	end
end

if status is-interactive
	# Commands to run in interactive sessions can go here
	fish_vi_key_bindings
	bash ~/.config/scripts/shell-splash.sh
	bash ~/.config/scripts/git-updater.sh $argv

	# variables ###########################

	set -x BROWSER "firefox"
	set -x EDITOR "nvim"
	set -x PAGER "less -r"

	# aliases #############################

	# navigation
	# alias -- - 'cd - > /dev/null'
	alias 1 'cd -1'
	alias 2 'cd -2'
	alias 3 'cd -3'
	alias 4 'cd -4'
	alias 5 'cd -5'
	alias 6 'cd -6'
	alias 7 'cd -7'
	alias 8 'cd -8'
	alias 9 'cd -9'

	# alias ...  '../..'
	# alias .... '../../..'
	# alias ..... '../../../..'
	# alias ...... '../../../../..'

	alias conf 'cd ~/.config'
	alias docc 'cd ~/docs'
	alias schoo 'cd ~/academia'

	# git
	alias g 'git'
	alias ga 'git add'
	alias gaa 'git add --all'
	alias gb 'git branch'
	alias gc! 'git commit -v --amend'
	alias gc 'git commit -v'
	alias gca 'git commit -v -a'
	alias gf 'git fetch'
	alias gl 'git log --oneline --decorate short --graph'
	alias gll 'git log --graph --stat'
	alias glop 'git log --graph -p'
	alias grs 'git restore'
	alias gst 'git status'
	function ggpull; command git pull origin $(git branch --show-current); end
	function ggpush; command git push origin $(git branch --show-current); end

	# config shortcuts
	alias nc 'nvim ~/.config/nvim/init.vim'
	alias ncf 'nvim ~/.config/fish/config.fish'
	alias nck 'nvim ~/.config/kitty/kitty.conf'
	alias ncr 'nvim ~/.config/ranger/rc.conf'
	alias ncs 'nvim ~/.config/sway/config'
	alias ncw 'nvim ~/.config/waybar/config'
	alias ncws 'nvim ~/.config/waybar/style.css'
	alias ncz 'nvim ~/.config/zsh/.zshrc'

	# misc
	alias c 'cd'
	alias clj 'clj/'
	alias diff 'diff --color always'
	alias dirl 'dirs -v'
	alias exp 'explorer.exe'
	alias l 'ls -1AshX --color=always --group-directories-first'
	alias less 'less -r'
	alias ll 'k -Ah --group-directories-first'
	alias lll 'ls -1Alh --color=always --group-directories-first'
	alias lo 'gnome-session-save --force-logout'
	alias n 'nvim'
	alias nn 'ranger $NOTES_DIR'
	alias nr 'nvim -R'
	alias pingg 'ping google.com'
	alias r 'ranger'
	alias rename 'prename'
	alias shx 'chmod +x *.sh'
	alias src 'source ~/.config/fish/config.fish'
	alias tree 'tree -RC --dirsfirst'
	alias trees 'tree -RCI .g -L 2 --dirsfirst'
	alias ytd 'yt-dlp'
	alias ytdy 'yt-dlp -f 22 --embed-thumbnail --embed-chapters --embed-subs --compat-options no-live-chat'
	alias zpc 'zplug clean'
	alias zpi 'zplug install'
	alias zpl 'zplug list'
	alias zpu 'zplug update'

	# keybinds ############################
	# use fish_key_reader!

	bind \cC 'commandline -r ""'
	bind \cP history-search-backward
end
