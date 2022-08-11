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
	bash ~/.config/scripts/shell-splash.sh fish
	bash ~/.config/scripts/git-updater.sh $argv

	fish_add_path /bin /usr/bin /usr/local/bin {$PATH} $HOME/bin

	# vi mode #############################

	fish_vi_key_bindings insert

	set fish_cursor_default block
	set fish_cursor_insert line
	set fish_cursor_replace_one underscore

	# format vi mode indicator in prompt
	function fish_mode_prompt
		# printf "$fish_bind_mode"
	end

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

	function ...; '../..'; end
	function ....; '../../..'; end
	function .....; '../../../..'; end
	function ......; '../../../../..'; end

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
	alias gcam 'git commit -a -m'
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
	alias foxdie "systemctl poweroff"
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
	bind \cP 'up-or-search'
	bind \cN 'down-or-search'

	# prompt ##############################

	function fish_prompt
		# check user privileges
		if fish_is_root_user
			set -f STR_ROOT '# '
		else
			set -f STR_ROOT '$ '
		end
		# if cwd is git controlled...
		if fish_git_prompt > /dev/null
			# ... then prepare git string
			set -f STR_GIT (set_color $fish_color_user)\[(git branch --show-current)\]
			# and if cwd is dirty...
			set -l DIRTY_TEST (git status --porcelain)
			if test -n "$DIRTY_TEST"
				# ... then prepare dirty indicator
				set -f STR_DIRTY (set_color $fish_color_error)\*
			else
				# or empty if clean
				set -f STR_DIRTY ''
			end
		# if cwd is not git controlled...
		else
			# ... make git strings empty
			set -f STR_GIT ''
			set -f STR_DIRTY ''
		end
		# print prompt from left to right
		printf $STR_DIRTY
		printf $STR_GIT
		set_color $fish_color_cwd
		printf [(prompt_pwd)]
		set_color --bold $fish_color_normal
		printf $STR_ROOT
		set_color normal
	end
end

# color scheme ########################

set fish_color_normal cccccc
set fish_color_command $fish_color_normal
set fish_color_keyword $fish_color_command
set fish_color_quote $fish_color_normal
set fish_color_redirection $fish_color_normal
set fish_color_end $fish_color_normal
set fish_color_error c50f1f
set fish_color_param $fish_color_normal
set fish_color_valid_path $fish_color_normal
set fish_color_option $fish_color_normal
set fish_color_comment 656565
set fish_color_selection red
set fish_color_operator $fish_color_comment
set fish_color_escape $fish_color_comment
set fish_color_autosuggestion $fish_color_comment
set fish_color_cwd 00bbff 
set fish_color_cwd_root $fish_color_cwd
set fish_color_user ffcc66
set fish_color_host $fish_color_user
set fish_color_host_remote $fish_color_usr
set fish_color_status red
set fish_color_cancel $fish_color_comment
set fish_color_search_match default
