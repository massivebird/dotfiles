{ userName, hostName, pkgs, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/common
  ];

  nix = {
    # pkgs version compatible with flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # tty settings (ctrl + alt + f<1-12>)
  console = {
    # set console options as early as possible
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    # [some] fonts in /etc/kbd/consolefonts/
    font = "latarcyrheb-sun32";
  };

  # fixes slow gnome app startup
  services.dbus.enable = true;

  # fixes unresponsive keyboard on wakeup
  boot.kernelParams = [ "i8042.dumbkbd=1" "i8042.reset=1" "i8042.direct=1" ];

  # supposed to fix slow app startup (it didn't)
  powerManagement.cpuFreqGovernor = "performance";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enables wireless support via wpa_supplicant
  # networking.wireless.enable = true;

  # configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # enable the X11 windowing system
  services.xserver.enable = true;

  # enable the GNOME desktop environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.sway.enable = true;

  # list packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    binutils # tree-sitter dep
    brightnessctl
    cargo
    cmatrix
    croc
    dmidecode # get hardware info
    firefox
    fish
    git
    gnat13 # GNU C++ compiler collection
    java-language-server
    kitty
    libgccjit # GNU C compiler collection
    lua-language-server
    mako # wayland notification daemon
    marksman # markdown language server
    mpv
    neovim
    nodePackages_latest.bash-language-server
    nodejs_20
    nsxiv # image viewer
    pamixer # pulseaudio control
    playerctl # audio controls like play, skip
    python311
    ranger
    ripgrep # nvim-telescope dep
    rnix-lsp # nix lsp
    rofi
    rust-analyzer
    rustc
    rustup
    taskwarrior
    tldr
    tree
    tree-sitter # the executable
    vlc
    waybar
    wget
    wl-clipboard # neovim clipboard integration
    yt-dlp
    zathura # pdf viewer
  ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ 
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      noto-fonts-cjk-sans
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Sans Mono" "JetBrainsMono" ];
        sansSerif = [ "Noto Sans Mono" "JetBrainsMono" ];
        monospace = [ "JetBrainsMono" ];
      };
    };
  };

  # some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh = {
    enable = true;
    # openFirewall = true; # auto-open specific ports
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
  };

  # this value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system
  # before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "23.05"; # did you read the comment?
}
