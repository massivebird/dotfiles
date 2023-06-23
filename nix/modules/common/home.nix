{ userName, pkgs, ... }: {

  # start requested services, stop others
  systemd.user.startServices = true;

  home = {
    stateVersion = "23.05";

    username = "${userName}";
    homeDirectory = "/home/${userName}";

    packages = with pkgs; [
      hello
    ];

  };
}
