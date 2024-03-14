# configuration applied to all hosts
{ pkgs, lib, config, inputs, userName, hostName, ... }: {
  config = {
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    programs.sway.enable = true;

    users.mutableUsers = true;
    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "password";
    };

    nixpkgs.config = {
      allowUnfree = true; # allow proprietary packages
      permittedInsecurePackages = [
        "electron-25.9.0" # updated apps may use EOL dep
      ];
    };

    environment.systemPackages = with pkgs; [
      bacon # background rust code checker
      bat # `less` clone
      binutils # nvim tree-sitter dep
      brightnessctl # keyboard brightness controls
      btop # command line process manager
      bun # JavaScript runtime/package manager/bunder/etc.
      cargo
      clippy # rust linting
      cmake
      cmatrix
      coreutils
      croc
      discord
      dmidecode # get hardware info
      duf # disk usage util, better than `df`
      dust # `du` alternative written in rust
      exiftool # read/write metadata
      eza # modern alternative to `ls` written in rust
      fd # telescope dep: alternative to `find`
      firefox
      fish
      gh # github cli
      git
      gnat13 # GNU C++ compiler collection
      gnumake42 # `make` command
      grim # screenshots in wayland
      helvetica-neue-lt-std
      java-language-server
      jdk17 # java
      jetbrains.idea-ultimate
      kitty # terminal emulator
      lc3tools # LC-3 toolchain and emulator
      libGL
      libgccjit # GNU C compiler collection
      libnotify # notify-send and other notification utils
      lua-language-server
      mako # wayland notification daemon
      marksman # markdown language server
      mpv
      ncspot # ncurses spotify client written in rust
      neovim
      nixd # Nix language server
      nodePackages_latest.bash-language-server
      nodePackages_latest.typescript-language-server
      nodejs_20
      nsxiv # image viewer
      obs-studio
      obsidian # markdown note taking app
      pamixer # pulseaudio control
      php82Extensions.mysqlnd # PHP MySQL extension
      playerctl # keyboard audio controls
      python311
      ranger
      ripgrep # real fast grep written in rust
      rnix-lsp # nix lsp
      rofi # "start menu" pop-up
      rust-analyzer
      rustc
      rustup
      spotify-tui
      spotifyd # lightweight spotify daemon
      taskwarrior
      tldr
      tree
      tree-sitter # the executable
      unzip
      vlc
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers
      waybar
      wget
      wiki-tui
      wl-clipboard # neovim clipboard integration
      yt-dlp
      zathura # pdf viewer
      zip
      zoom-us
    ];

    environment.variables = {
      HOSTNAME = hostName;
    };

    networking = {
      hostName = hostName;
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [ 22 ];
      useDHCP = false;
      hosts."192.168.1.152" = [ "clint" ];
    };

    # TTY login prompt aka /etc/issue
    # https://www.linuxfromscratch.org/blfs/view/svn/postlfs/logon.html
    # current ASCII style: Cyberlarge
    services.getty.greetingLine = ''\e[1;33m
   __  ________________   __      ____________   ___     ___  _____  __
  /  |/  / __/_  __/ _ | / /     / ___/ __/ _ | / _ \\   / _ \\/ _ \\ \\/ /
 / /|_/ / _/  / / / __ |/ /__   / (_ / _// __ |/ , _/  / , _/ __ |\\  / 
/_/  /_/___/ /_/ /_/ |_/____/   \\___/___/_/ |_/_/|_|  /_/|_/_/ |_|/_/  
\e[1;33m
MODEL: A6M2 ZERO
KRNEL: \r
ARMOR: CERAMIC-TITANIUM ALLOY: OK
ENGIN: FGS-EO55Sx4             ONLINE
WEAPN: ANTI-TANK MISSILE:      ONLINE
       ANTI-SHIP MISSILE:      ONLINE
       \e[1;31mWATER JET CUTTER:       OFFLINE
       \e[1;33mCLUSTER MISSILES:       ONLINE

\e[1;33m>>> \e[1;33mENTER PILOT CREDENTIALS \e[1;33m<<<
    '';

    # suppress nixos-help message on boot
    documentation.nixos.enable = false;

    time.timeZone = "America/Detroit";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };

    # enable sound with pipewire
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services = {
      printing.enable = true; # enable CUPS to print documents
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      xserver = {
        enable = true;
        autorun = false; # false runs TTY login prompt instead of graphical
        displayManager.startx.enable = true;
        displayManager.lightdm.enable = false;
        displayManager.gdm.enable = true; # GNOME display manager
        desktopManager.gnome.enable = true; # GNOME desktop manager
        xkb = {
          layout = "us";
          options = pkgs.lib.mkDefault "caps:swapescape"; # caps as escape
        };
      };
    };

    console.useXkbConfig = true; # apply keybinds to TTY

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [ 
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        noto-fonts-cjk-sans # japanese chars
      ];
      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Sans Mono" "JetBrainsMono" ];
          sansSerif = [ "Noto Sans Mono" "JetBrainsMono" ];
          monospace = [ "JetBrainsMono" ];
        };
      };
    };

    boot.loader.systemd-boot.configurationLimit = 10;

    nix = {
      package = pkgs.nixFlakes; # pkgs version compatible with flakes
      extraOptions = "experimental-features = nix-command flakes";
      # garbage collector
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
      # uses single copy for identical store files
      settings.auto-optimise-store = true;
    };
  };
}
