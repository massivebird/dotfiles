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

    # allow proprietary packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      bacon # background rust code checker
      bat # `less` clone
      binutils # nvim tree-sitter dep
      brightnessctl # keyboard brightness controls
      btop # command line process manager
      cargo
      clippy # rust linting
      cmake
      cmatrix
      coreutils
      croc
      discord
      dmidecode # get hardware info
      exa # modern alternative to `ls` written in rust
      firefox
      fish
      git
      gnat13 # GNU C++ compiler collection
      grim # screenshots in wayland
      java-language-server
      jdk17 # java
      kitty # terminal emulator
      libGL
      libgccjit # GNU C compiler collection
      lua-language-server
      mako # wayland notification daemon
      marksman # markdown language server
      mpv
      ncspot # ncurses spotify client written in rust
      neovim
      nodePackages_latest.bash-language-server
      nodejs_20
      nsxiv # image viewer
      obsidian # markdown note taking app
      pamixer # pulseaudio control
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
      vlc
      waybar
      wget
      wiki-tui
      wl-clipboard # neovim clipboard integration
      yt-dlp
      zathura # pdf viewer
    ];

    networking.hostName = hostName;
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.useDHCP = false;
    networking.hosts."172.29.0.191" = [ "clint" ];

    services.xserver = {
      layout = "us";
      autorun = false; # runs TTY login prompt instead of graphical
      displayManager.startx.enable = true;
      displayManager.lightdm.enable = false;
      # keybinds
      xkbVariant = "";
      xkbOptions = pkgs.lib.mkDefault "caps:swapescape"; # caps lock is second escape
    };

    time.timeZone = "America/Detroit";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
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

    # enable X11 windowing system
    services.xserver.enable = true;

    # enable the GNOME desktop environment
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # enable CUPS to print documents
    services.printing.enable = true;

    # enable sound with pipewire
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # if you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    fonts = {
      enableDefaultFonts = true;
      fonts = with pkgs; [ 
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

    nix = {
      # pkgs version compatible with flakes
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };
  };
}
