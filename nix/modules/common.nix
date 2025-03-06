# Common configuration applied to all hosts
{ inputs, pkgs, userName, hostName, ... }:
let
    my_pkg = name: inputs.${name}.packages.${pkgs.system}.default;
in
{
  config = {
    programs.sway.enable = true;

    # Configure fish as an interactive shell.
    programs.fish.enable = true;

    users.users.${userName} = {
      isNormalUser = true;
      initialPassword = "password"; # change with `passwd`
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config = {
      # Allow proprietary packages.
      allowUnfree = true;

      permittedInsecurePackages = [
        "electron-25.9.0" # updated apps may use EOL dep
        "nix-2.16.2"
      ];
    };

    environment.systemPackages = with pkgs; [
      (my_pkg "lanturn")
      (my_pkg "minifetch")
      (my_pkg "subterfuge")
      bat # `less` clone
      brightnessctl # keyboard brightness controls
      btop # command line process manager
      cmake
      cmatrix
      coreutils
      croc
      dmidecode # get hardware info
      duf # disk usage util, better than `df`
      dust # `du` alternative written in rust
      exiftool # read/write metadata
      eza # modern alternative to `ls` written in rust
      ffmpeg
      file # file metadata
      git
      glib
      gnumake42 # `make` command
      helvetica-neue-lt-std
      jdk # java
      libnotify # notify-send and other notification utils
      pamixer # pulseaudio control
      playerctl # keyboard audio controls
      python311
      ripgrep # real fast grep written in rust
      tldr
      tree
      unzip
      wget
      yazi # terminal file manager
      zip
    ];

    # Add ~/bin/ to PATH.
    environment.homeBinInPath = true;

    environment.variables = {
      HOSTNAME = hostName;

      # Application defaults
      BROWSER = "firefox";

      # I think this helps nvim-cmp generate stdlib completions
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

      # GUI theme for Nautilus, Disks, etc.
      GTK_THEME = "Adwaita:dark";

      # OBS settings.
      QT_QPA_PLATFORM = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    };

    networking = {
      hostName = hostName;
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [ 22 7878 7879 25565 8080 ];
      useDHCP = false;
      hosts."192.168.1.152" = [ "clint" ];
    };

    services.getty = {
      # TTY login prompt.
      greetingLine = ''
    Logging onto \n (\l)
    Today is \d \t'';

      # Additional args passed to getty.
      extraArgs = [ "--nonewline" ];
    };

    # Display nixos-help message on boot.
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

    # Apply xserver mappings to virtual console config.
    console.useXkbConfig = true;

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [ 
        noto-fonts-cjk-sans # japanese chars
        nerd-fonts.jetbrains-mono
      ];
      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Sans Mono" "JetBrainsMono" ];
          sansSerif = [ "Noto Sans Mono" "JetBrainsMono" ];
          monospace = [ "JetBrainsMono" ];
        };
      };
    };

    # Maximum number of latest generations in the boot menu.
    boot.loader.systemd-boot.configurationLimit = 10;

    nix = {
      # Nix package instance to use throughout the system.
      package = pkgs.nixVersions.latest;

      # Additional text appended to `nix.conf`.
      extraOptions = "experimental-features = nix-command flakes";

      # Garbage collector.
      gc = {
        # Automatically remove unused nix store entries.
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      # https://nixos.wiki/wiki/Storage_optimization
      # Optimize nix store during every build. May slow down builds.
      settings.auto-optimise-store = false;
    };
  };
}
