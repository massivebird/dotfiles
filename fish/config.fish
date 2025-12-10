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

   # environment variables ###############

   # Defined here in case I install fish + these tools on a non-NixOS distro.
   # Most env vars are otherwise defined in my Nix flake.

   if type -q nvim
      set -x EDITOR "nvim"
   else
      set -x EDITOR "vim"
   end

   if type -q bat
      # bat's `plain` style has no line numbers to avoid breaking manpages
      set -x PAGER "bat --color always --style plain"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
   else
      set -x MANPAGER "less"
      set -x PAGER "less"
   end
   set -x MANROFFOPT "-c"

   # For massivebird/arcsearch, massivebird/arcstat
   set -x VG_ARCHIVE "$HOME/game-archive"

   # vi mode #############################

   fish_vi_key_bindings insert

   set fish_cursor_default     block
   set fish_cursor_insert      line
   set fish_cursor_replace_one underscore

   function fish_mode_prompt
      # no body -> do not display vi mode
   end

   # keybinds ############################

   # fish_key_reader reports key codes, helpful for adding keymaps.

   for mode in insert default visual
      # \c: ctrl

      bind -M $mode \cp 'up-or-search'
      bind -M $mode \cn 'down-or-search'
      bind -M $mode \ck 'accept-autosuggestion'
   end

   # aliases, abbreviations ##############

   if type -q eza
      alias l  'eza --all --long --git --sort type --no-user --no-permissions --no-time'
      alias ll 'eza --all --long --git --sort type'
   else
      alias l  'ls -1AshX --color=always --group-directories-first'
      alias ll 'ls -1Alh  --color=always --group-directories-first'
   end

   if test "$TERM" = "xterm-kitty"
      alias ssh 'kitty +kitten ssh' # solves SSH kitty issues [kovidgoyal/kitty#713]
   end

   if not type -q rename
      alias rename 'prename'
   end

   # https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
   # Exit Yazi with `q` to cd. Exit with `Q` to exit without cd.
   function y
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
         builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
   end

   function ...; '../..'; end
   function ....; '../../..'; end
   function .....; '../../../..'; end
   function ......; '../../../../..'; end

   alias conf  'cd ~/.config'
   alias docc  'cd ~/docs'
   alias schoo 'cd ~/academia'

   abbr --add g 'git'
   abbr --add ga 'git add'
   abbr --add gaa 'git add --all'
   abbr --add gai 'git add --interactive'
   abbr --add gap 'git add --patch'
   abbr --add gb 'git branch'
   abbr --add gbr 'git branch'
   abbr --add gc 'git commit -v'
   abbr --add gc! 'git commit -v --amend'
   abbr --add gca 'git commit -v -a'
   abbr --add gcam 'git commit -a -m'
   abbr --add --add gcan 'git commit -a -m "added: notes"'
   abbr --add gcl 'git clone'
   abbr --add gco 'git checkout'
   abbr --add gd 'git diff'
   abbr --add gf 'git fetch'
   abbr --add gl 'git log --graph --all --oneline --color=always'
   abbr --add gll 'git log --graph --oneline --color=always --stat'
   abbr --add glop 'git log --graph -p --color=always'
   abbr --add gm 'git merge'
   abbr --add grb 'git rebase'
   abbr --add grbi 'git rebase --interactive'
   abbr --add grs 'git restore'
   abbr --add gsh 'git show --oneline'
   abbr --add gst 'git status'
   abbr --add gsta 'git stash'
   abbr --add gstad 'git stash drop'
   abbr --add gstal 'git stash list'
   abbr --add gstap 'git stash pop'
   abbr --add gstas 'git stash show'

   function ggpull; command git pull origin (git branch --show-current); end
   function ggpush; command git push origin (git branch --show-current); end

   abbr --add ghi 'gh issue'
   abbr --add ghil 'gh issue list'
   abbr --add ghilm 'gh issue list --assignee "@me"'
   abbr --add ghiv 'gh issue view'

   abbr --add cg 'cargo'
   abbr --add cgb 'cargo build'
   abbr --add cgbr 'cargo build --release'
   abbr --add cgcl 'cargo clippy -- -W clippy::pedantic -W clippy::nursery'
   abbr --add cgf 'cargo fmt'
   abbr --add cgi 'cargo init'
   abbr --add cgr 'cargo run'
   abbr --add cgrr 'cargo run --release'
   abbr --add cgt 'cargo test'
   abbr --add cgtr 'cargo tree'
   abbr --add cgu 'cargo update'
   abbr --add cgw 'cargo watch --clear'

   alias nbu "nix build"
   alias ncg 'sudo nix-collect-garbage --delete-old'
   alias nde 'nix develop'
   alias nfu "nix flake update --commit-lock-file --flake ~/.config/nix/#"
   alias ninfo 'nix-shell -p nix-info --run "nix-info -m"'
   alias nlg 'nix-env --list-generations' 
   alias nor "sudo nixos-rebuild switch --flake ~/.config/nix#"
   if type -q nh
      abbr --add nor 'nh os switch --ask --update --accept-flake-config ~/.config/nix -H ray'
   else
      abbr --add nor 'sudo nixos-rebuild switch --flake ~/.config/nix#'
   end

   alias nc '$EDITOR ~/.config/nvim/init.lua'
   alias ncf '$EDITOR ~/.config/fish/config.fish'
   alias nci '$EDITOR ~/.config/i3/config'
   alias ncis '$EDITOR ~/.config/i3status/config'
   alias nck '$EDITOR ~/.config/kitty/kitty.conf'
   alias ncm '$EDITOR -c ":Telescope find_files search_dirs={\'$HOME/.config/nvim/\'} hidden=false path_display={\'smart\'} prompt_title='Modules'"'
   alias ncn '$EDITOR ~/.config/nix/flake.nix -c ":Neotree action=show dir=~/.config/nix"'
   alias ncs '$EDITOR ~/.config/sway/config'
   alias ncw '$EDITOR -O2 ~/.config/waybar/config ~/.config/waybar/style.css'
   alias ncz '$EDITOR ~/.config/zathura/zathurarc'

   alias c 'cd'
   alias clj 'clj/'
   alias diff 'diff --color=always'
   alias dirl 'dirs -v'
   alias exp 'explorer.exe' # WSL: open cwd in Windows File Explorer
   alias foxalive "systemctl reboot"
   alias foxdie "systemctl poweroff"
   alias greep 'grep' # ben
   alias less 'less -r --jump-target=3'
   alias n '$EDITOR'
   alias nr '$EDITOR -R'
   alias pingg 'ping github.com'
   alias s 'source ~/.config/fish/config.fish'
   alias sc 'clear && source ~/.config/fish/config.fish -f'
   alias sf 'source ~/.config/fish/config.fish -f'
   alias shx 'chmod +x *.sh'
   alias sv 'source ~/.config/fish/config.fish -v'
   alias ta 'task add'
   alias tc 'task calendar'
   alias tl 'task list'
   alias tn 'task next'
   alias tpc 'tput cnorm'
   alias tree 'tree -RC --dirsfirst'
   alias trees 'tree -RCI .g -L 2 --dirsfirst'
   alias update-grub 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
   abbr --add batt "cat /sys/class/power_supply/BAT0/capacity"
   abbr --add pkill "pkill --ignore-case"
   abbr --add rg "rg -i"
   abbr --add ytd 'yt-dlp'
   abbr --add ytda 'yt-dlp --embed-thumbnail --embed-chapters --embed-subs --compat-options no-live-chat -o "%(uploader)s - %(title)s (%(upload_date)s) [%(display_id)s]" -f 'bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/mp4'' # "archive mode"
   abbr --add ytdt 'yt-dlp --embed-thumbnail --embed-subs -o "%(uploader)s - %(title)s (%(upload_date)s) [%(display_id)s]" -f 'bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/mp4'' # "twitter mode"

   abbr --add dn --position=anywhere /dev/null

   # prompt ##############################

   # Command prompt is controlled by stdout of fish_prompt fn.
   function fish_prompt
      if fish_is_root_user
         set -f USER_ICON '# '
      else
         set -f USER_ICON '$ '
      end

      # If inside a Git repo, display active branch.
      if fish_git_prompt > /dev/null
         set -f GIT_BRANCH \[(git branch --show-current)\]
         if test -n "$(git status --porcelain)"
            set -f GIT_DIRTY_ICON '*'
         else
            set -f GIT_DIRTY_ICON ''
         end
      else # Not inside a Git repo
         set -f GIT_BRANCH ''
         set -f GIT_DIRTY_ICON ''
      end

      # Print prompt from left to right.

      set_color $fish_color_error
      printf $GIT_DIRTY_ICON

      set_color $fish_color_user
      printf $GIT_BRANCH

      set_color $fish_color_cwd
      printf [(prompt_pwd)]

      set_color --bold $fish_color_normal
      printf $USER_ICON

      set_color normal
   end

   # color scheme ########################

   set fish_color_normal f2f2f2
   # commands: echo
   set fish_color_command $fish_color_normal
   # keywords: if
   set fish_color_keyword $fish_color_command
   # quoted text: "echo"
   set fish_color_quote eeaaff
   # IO redirs: > /dev/null
   set fish_color_redirection ff8867
   # process separators: ; &
   set fish_color_end $fish_color_normal
   # syntax errors
   set fish_color_error fb5599
   # command parameters
   set fish_color_param ff8867 --italics
   # filename command parameters
   set fish_color_valid_path ff8867 --italics
   # command flags/options: --ignore-case -i
   set fish_color_option $fish_color_normal
   # comments
   set fish_color_comment 656565
   # selected text in vi visual mode
   set fish_color_selection red
   # param expansion chars: * ~
   set fish_color_operator $fish_color_comment
   # character escapes: \n \x70
   set fish_color_escape $fish_color_comment
   # command autosuggestions
   set fish_color_autosuggestion $fish_color_comment
   # prompt cwd
   set fish_color_cwd 00bbff 
   # prompt cwd for root user
   set fish_color_cwd_root $fish_color_cwd
   # prompt username
   set fish_color_user ffcc66
   # prompt hostname
   set fish_color_host $fish_color_user
   # prompt hostname for remote sessions
   set fish_color_host_remote $fish_color_usr
   # prompt nonzero exit code of last command
   set fish_color_status red
   # ^C indicator
   set fish_color_cancel $fish_color_comment
   # bg of history search matches, selected pager items
   set fish_color_search_match default

   function try_running
      if type -q $argv
         command $argv
      else
         echo "config.fish: command not found:" $argv
      end
   end

   # custom splash program
   try_running minifetch
end

# starship ############################

# If `starship` doesn't exist on this machine,
# don't do anything else.
#
# Note to future self: I hope this causes you pain
if not type -q starship
   return
end

# Do not run starship in a TTY
if test "$TERM" != linux
   starship init fish | source
end

# The rest of this section removes the annoying empty line at the top of the
# screen after a `clear`.
#
# https://github.com/starship/starship/issues/560#issuecomment-2409922650

function starship_transient_prompt_func
	tput cuu1
	starship module character
end

function prompt_newline --on-event fish_postexec
	echo
end

alias clear "command clear; commandline -f clear-screen"
