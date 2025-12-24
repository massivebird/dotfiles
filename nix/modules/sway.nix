{ inputs, pkgs, ... }: {
  # Introduces sway wm, quasi-deps, and the "bare essentials" graphical suite.
  config = {
    programs.sway.enable = true;

    environment.systemPackages = with pkgs; [
      firefox
      glfw # temp solution for kitty GLFW launch error
      grim # screenshots in wayland
      kitty # terminal emulator
      mako # wayland notification daemon
      mpv
      nsxiv # image viewer
      rofi # "start menu" pop-up
      slurp # display region selector for Wayland
      waybar
      wl-mirror # sway output mirror solution
      wlsunset
      zathura # pdf viewer
    ];
  };
}
