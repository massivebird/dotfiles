{ inputs, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # jetbrains.idea-ultimate
      # zoom-us
      discord
      obs-studio
      obsidian # markdown note taking app
      # vlc
    ];
  };
}
