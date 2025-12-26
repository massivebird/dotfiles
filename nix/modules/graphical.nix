{ inputs, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # jetbrains.idea-ultimate
      # zoom-us
      discord
      gparted # requires `sudo -E` for some reason?
      obs-studio
      obsidian # markdown note taking app
      # vlc
    ];
  };
}
