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
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.sway.enable = true;

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
