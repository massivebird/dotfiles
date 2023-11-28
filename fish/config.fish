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

   fish_add_path /bin /usr/bin /usr/local/bin {$PATH} $HOME/bin $HOME/.cargo/bin $JAVA_HOME/bin

   set -x VG_ARCHIVE $HOME/game-archive

   set -x BROWSER "firefox"
   set -x EDITOR "nvim"
   # `plain` style has no line numbers, they break manpages
   set -x PAGER "bat --color always --style plain"
   # neovim notes querying
   set -x NOTES_DIR $HOME/academia/notes_all/
   # OBS wants these
   set -x QT_QPA_PLATFORM 'wayland'
   set -x XDG_CURRENT_DESKTOP 'sway'
   set -x XDG_SESSION_TYPE 'wayland'
   # tomcat
   set -x CATALINA_HOME "/usr/local/tomcat10"
   # android studio
   set -x _JAVA_AWT_WM_NONREPARENTING 1
   set -x STUDIO_JDK /opt/jdk-18/bin/javac

   if test -d /opt/jdk-18
      set -x JAVA_HOME /opt/jdk-18
   else
      set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
   end

   set -x CLASSPATH ".:./classes:../classes:"

   # vi mode #############################

   fish_vi_key_bindings insert

   set fish_cursor_default     block
   set fish_cursor_insert      line
   set fish_cursor_replace_one underscore

   function fish_mode_prompt
      # no body -> do not display vi mode
   end

   # keybinds ############################
   # use fish_key_reader!

   for mode in insert default visual
      bind -M $mode \cP 'up-or-search'
      bind -M $mode \cN 'down-or-search'
   end

   # aliases #############################

   if type -q eza
      alias l  'eza --all --long --git --sort type --no-user --no-permissions --no-time'
      alias ll 'eza --all --long --git --sort type'
   else
      alias l  'ls -1AshX --color=always --group-directories-first'
      alias ll 'ls -1Alh  --color=always --group-directories-first'
   end

   function man
      command man $argv | bat --style plain --language man
   end

   function ...; '../..'; end
   function ....; '../../..'; end
   function .....; '../../../..'; end
   function ......; '../../../../..'; end

   alias conf  'cd ~/.config'
   alias docc  'cd ~/docs'
   alias schoo 'cd ~/academia'

   alias g 'git'
   alias ga 'git add'
   alias gaa 'git add --all'
   alias gai 'git add --interactive'
   alias gap 'git add --patch'
   alias gb 'git branch'
   alias gbr 'git branch'
   alias gc 'git commit -v'
   alias gc! 'git commit -v --amend'
   alias gca 'git commit -v -a'
   alias gcam 'git commit -a -m'
   alias gcan 'git commit -a -m "adds: notes"'
   alias gcl 'git clone'
   alias gco 'git checkout'
   alias gd 'git diff'
   alias gf 'git fetch'
   alias gl 'git log --graph --all --decorate --oneline --pretty=format:\'%C(bold yellow)%h%C(reset) %s %C(auto)%d%C(reset)\''
   alias gll 'git log --graph -p'
   alias glop 'git log --graph -p'
   alias gm 'git merge'
   alias grb 'git rebase'
   alias grbi 'git rebase --interactive'
   alias grs 'git restore'
   alias gsh 'git show --oneline'
   alias gst 'git status'
   alias gsta 'git stash'
   alias gstad 'git stash drop'
   alias gstal 'git stash list'
   alias gstap 'git stash pop'
   alias gstas 'git stash show'

   alias ghi 'gh issue'
   alias ghil 'gh issue list'
   alias ghilm 'gh issue list --assignee "@me"'
   alias ghiv 'gh issue view'

   # cargo
   alias cg 'cargo'
   alias cgb 'cargo build'
   alias cgbr 'cargo build --release'
   alias cgcl 'cargo clippy -- \
   -W clippy::pedantic \
   -W clippy::nursery \
   -W clippy::pedantic'
   alias cgi 'cargo init'
   alias cgr 'cargo run'
   alias cgt 'cargo test'
   alias cgtr 'cargo tree'
   alias cgu 'cargo update'
   alias cgw 'cargo watch --clear'

   alias ncg 'sudo nix-collect-garbage --delete-old'
   alias nlg 'nix-env --list-generations' 
   alias nor "sudo nixos-rebuild switch --flake ~/.config/nix#"

   function ggpull; command git pull origin $(git branch --show-current); end
   function ggpush; command git push origin $(git branch --show-current); end

   # config shortcuts
   alias nc 'nvim ~/.config/nvim/init.lua'
   alias ncf 'nvim ~/.config/fish/config.fish'
   alias nci 'nvim ~/.config/i3/config'
   alias ncis 'nvim ~/.config/i3status/config'
   alias nck 'nvim ~/.config/kitty/kitty.conf'
   alias ncm 'nvim -c ":Telescope find_files \
   search_dirs={\'$HOME/.config/nvim/lua\'} \
   hidden=false path_display={'smart'} \
   prompt_title='Modules'"'
   alias ncn 'nvim ~/.config/nix/flake.nix -c ":Neotree \
   action=show \
   dir=~/.config/nix"'
   alias ncr 'nvim ~/.config/ranger/rc.conf'
   alias ncs 'nvim ~/.config/sway/config'
   alias ncw 'nvim -O2 ~/.config/waybar/config ~/.config/waybar/style.css'
   alias ncz 'nvim ~/.config/zathura/zathurarc'

   alias c 'cd'
   alias clj 'clj/'
   alias diff 'diff --color=always'
   alias dirl 'dirs -v'
   alias exp 'explorer.exe'
   alias foxalive "systemctl reboot"
   alias foxdie "systemctl poweroff"
   alias less 'less -r --jump-target=3'
   alias lo 'gnome-session-save --force-logout'
   alias n 'nvim'
   alias nn 'ranger $NOTES_DIR'
   alias nr 'nvim -R'
   alias pingg 'ping google.com'
   alias r 'ranger'
   alias rename 'prename'
   alias shx 'chmod +x *.sh'
   alias s 'source ~/.config/fish/config.fish'
   alias sc 'clear && source ~/.config/fish/config.fish -f'
   alias sf 'source ~/.config/fish/config.fish -f'
   alias sv 'source ~/.config/fish/config.fish -v'
   alias ta 'task add'
   alias tc 'task calendar'
   alias tl 'task list'
   alias tn 'task next'
   alias tpc 'tput cnorm'
   alias tree 'tree -RC --dirsfirst'
   alias trees 'tree -RCI .g -L 2 --dirsfirst'
   alias update-grub 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
   alias ytd 'yt-dlp'
   alias ytdy 'yt-dlp -f 22 --embed-thumbnail --embed-chapters --embed-subs --compat-options no-live-chat'

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

   # run custom splash program
   minifetch
   # run custom git repo updater program
   git_updater $argv
end
