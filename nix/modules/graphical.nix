{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # jetbrains.idea-ultimate
      # zoom-us
      discord
      firefox
      glfw # temp solution for kitty GLFW launch error
      grim # screenshots in wayland
      kitty # terminal emulator
      mako # wayland notification daemon
      mpv
      nsxiv # image viewer
      obs-studio
      obsidian # markdown note taking app
      rofi # "start menu" pop-up
      slurp # display region selector for Wayland
      # vlc
      waybar
      wl-mirror # sway output mirror solution
      wlsunset
      zathura # pdf viewer
    ];
  };
}
