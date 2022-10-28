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

   # variables ###########################

   fish_add_path /bin /usr/bin /usr/local/bin {$PATH} $HOME/bin $HOME/.cargo/bin $JAVA_HOME/bin

   set -x BROWSER "firefox"
   set -x EDITOR "nvim"
   set -x PAGER "less -r"
   # neovim notes querying
   set -x NOTES_DIR $HOME/academia/notes_all/
   # OBS wants these
   set -x QT_QPA_PLATFORM 'wayland'
   set -x XDG_CURRENT_DESKTOP 'sway'
   set -x XDG_SESSION_TYPE 'wayland'

   # variables: java #####################

   if test -d /opt/jdk-18
      set -x JAVA_HOME /opt/jdk-18
   else
      set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
   end

   set -x CLASSPATH ".:./classes:../classes:"

   # vi mode #############################

   fish_vi_key_bindings insert

   set fish_cursor_default block
   set fish_cursor_insert line
   set fish_cursor_replace_one underscore

   # format vi mode indicator in prompt
   function fish_mode_prompt
      # printf "$fish_bind_mode"
   end

   # keybinds ############################
   # use fish_key_reader!

   for mode in insert default visual
      bind -M $mode \cP 'up-or-search'
      bind -M $mode \cN 'down-or-search'
   end

   # aliases #############################

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
   alias gcan 'git commit -a -m "+ notes"'
   alias gf 'git fetch'
   alias gl 'git log --oneline --decorate short --graph'
   alias gll 'git log --graph --stat'
   alias glop 'git log --graph -p'
   alias grs 'git restore'
   alias gst 'git status'
   function ggpull; command git pull origin $(git branch --show-current); end
   function ggpush; command git push origin $(git branch --show-current); end

   # config shortcuts
   alias nc 'nvim ~/.config/nvim/init.lua'
   alias ncf 'nvim ~/.config/fish/config.fish'
   alias nck 'nvim ~/.config/kitty/kitty.conf'
   alias ncr 'nvim ~/.config/ranger/rc.conf'
   alias ncs 'nvim ~/.config/sway/config'
   alias ncw 'nvim -O2 ~/.config/waybar/config ~/.config/waybar/style.css'
   alias ncz 'nvim ~/.config/zathura/zathurarc'

   # misc
   alias c 'cd'
   alias clj 'clj/'
   alias diff 'diff --color=always'
   alias dirl 'dirs -v'
   alias exp 'explorer.exe'
   alias foxdie "systemctl poweroff"
   alias l 'ls -1AshX --color=always --group-directories-first'
   alias less 'less -r'
   alias ll 'ls -1Alh --color=always --group-directories-first'
   # alias lll 'k -Ah --group-directories-first'
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
   alias tl 'task list'
   alias tn 'task next'
   alias tpc 'tput cnorm'
   alias tree 'tree -RC --dirsfirst'
   alias trees 'tree -RCI .g -L 2 --dirsfirst'
   alias update-grub 'sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
   alias ytd 'yt-dlp'
   alias ytdy 'yt-dlp -f 22 --embed-thumbnail --embed-chapters --embed-subs --compat-options no-live-chat'
   alias zpc 'zplug clean'
   alias zpi 'zplug install'
   alias zpl 'zplug list'
   alias zpu 'zplug update'

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

   # bash scripts
   bash ~/.config/scripts/fetch-p.sh
   bash ~/.config/scripts/git-updater.sh $argv
end
