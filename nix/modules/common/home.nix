{ userName, pkgs, ... }: {

  # start requested services, stop others
  systemd.user.startServices = true;

  # allow home-manager to manage itself
  programs.home-manager.enable = true;

  home = {
    stateVersion = "23.05";

    username = "${userName}";
    homeDirectory = "/home/${userName}";

    packages = with pkgs; [
      hello
    ];

  };
}
