# configuration applied to all hosts
{ pkgs, userName, hostName, ... }: {
  config = {
    programs.sway.enable = true;
    # Configures fish as an interactive shell
    programs.fish.enable = true;

    users.defaultUserShell = pkgs.fish;

    users.mutableUsers = true;
    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "password";
    };

    nixpkgs.config = {
      allowUnfree = true; # Allow proprietary packages
      permittedInsecurePackages = [
        "electron-25.9.0" # updated apps may use EOL dep
        "nix-2.16.2"
      ];
    };

    environment.systemPackages = with pkgs; [
      # jetbrains.idea-ultimate
      # zoom-us
      alacritty # terminal emulator
      bacon # background rust code checker
      bash-language-server
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
      ffmpeg
      firefox
      fish
      gh # github cli
      git
      glfw # temp solution for kitty GLFW launch error
      gnat13 # GNU C++ compiler collection
      gnumake42 # `make` command
      grim # screenshots in wayland
      helvetica-neue-lt-std
      hyperfine # benchmarking tool written in rust
      jdk22 # java
      jdt-language-server # java language server
      kitty # terminal emulator
      lc3tools # LC-3 toolchain and emulator
      libGL
      libgccjit # GNU C compiler collection
      libnotify # notify-send and other notification utils
      lldb_16 # C/C++/Rust debugger
      logisim # logic circuit design and simulation
      lua-language-server
      mako # wayland notification daemon
      marksman # markdown language server
      mpv
      neovim
      nixd # Nix language server
      nodejs_20
      nsxiv # image viewer
      obs-studio
      obsidian # markdown note taking app
      pamixer # pulseaudio control
      php82Extensions.mysqlnd # PHP MySQL extension
      playerctl # keyboard audio controls
      pyright
      python311
      ranger
      ripgrep # real fast grep written in rust
      rofi # "start menu" pop-up
      rust-analyzer
      rustc
      rustfmt # Rust source code formatter
      taskwarrior3
      tldr
      tree
      tree-sitter # the executable
      unzip
      vlc
      vscode
      waybar
      wget
      wiki-tui
      wl-clipboard # neovim clipboard integration
      yt-dlp
      zathura # pdf viewer
      zip
    ];

    environment.variables = {
      HOSTNAME = hostName;
      # I think this helps nvim-cmp generate stdlib completions
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      # Theme for Nautilus, Disks, etc.
      GTK_THEME = "Adwaita:dark";
    };

    networking = {
      hostName = hostName;
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [ 22 7878 7879 ];
      useDHCP = false;
      hosts."192.168.1.152" = [ "clint" ];
    };

    # TTY login prompt, sets contents of /etc/issue
    services.getty = {
      greetingLine = ''
    Logging onto \n (\l)
    Today is \d \t'';
      extraArgs = [ "--nonewline" ];
    };

    # Display nixos-help message on boot
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

    # Fixes audio not working on startup
    hardware.alsa.enablePersistence = true;

    services = {
      printing.enable = true; # enable CUPS for printing documents
      pipewire = {
        enable = true;
        alsa.enable = true; # ALSA support
        alsa.support32Bit = true; # 32-bit ALSA support on 64-bit arch
        audio.enable = true; # pipewire as primary sound server
        jack.enable = true; # JACK audio emulation
        pulse.enable = true; # PulseAudio server emulation
      };
      xserver = {
        # Fixes cursor issues in Sway/Wayland. Why? How? idk
        desktopManager.gnome.enable = true;
        xkb = {
          layout = "us";
          options = pkgs.lib.mkDefault "caps:swapescape"; # caps as escape
        };
      };
    };

    console.useXkbConfig = true; # apply xkb keybinds to TTY

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
        options = "--delete-older-than 12d";
      };
      # uses single copy for identical store files
      settings.auto-optimise-store = true;
    };
  };
}
