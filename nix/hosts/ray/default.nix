{ userName, hostName, pkgs, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  # tty settings (ctrl + alt + f<1-12>)
  console = {
    # set console options as early as possible
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    # Find fonts in `/etc/kbd/consolefonts/`. 32 is the comfiest size!
    font = "ter-h32b";
  };

  # fixes unresponsive keyboard on wakeup
  boot.kernelParams = [ "i8042.dumbkbd=1" "i8042.reset=1" "i8042.direct=1" ];

  powerManagement.cpuFreqGovernor = "powersave";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh = {
    enable = true;
    openFirewall = true; # auto-open specific ports
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
