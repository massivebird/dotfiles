{ inputs, pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # jetbrains.idea-ultimate
      # zoom-us
      discord
      firefox
      glfw # temp solution for kitty GLFW launch error
      grim # screenshots in wayland
      mpv
      nsxiv # image viewer
      obs-studio
      obsidian # markdown note taking app
      rofi # "start menu" pop-up
      slurp # display region selector for Wayland
      # vlc
      wl-mirror # sway output mirror solution
      wlsunset
      zathura # pdf viewer
    ];

    boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
    # boot.kernelModules = [ "vboxdrv" "vboxnetadp" "vboxnetflt" ];
    # boot.extraModulePackages = [ kernelModules ];
  };
}
