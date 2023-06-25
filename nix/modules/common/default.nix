# configuration applied to all hosts
{ pkgs, lib, config, inputs, userName, hostName, ... }: {

  config = {

    users.mutableUsers = true;
    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "password";
    };

    environment.systemPackages = with pkgs; [
      bacon # background rust code checker
      bat # `less` clone
      binutils # tree-sitter dep
      brightnessctl # keyboard brightness controls
      cargo
      clippy # rust linting
      cmatrix
      coreutils
      croc
      dmidecode # get hardware info
      exa # modern alternative to `ls` written in rust
      firefox
      fish
      git
      gnat13 # GNU C++ compiler collection
      grim # screenshots in wayland
      java-language-server
      kitty
      libgccjit # GNU C compiler collection
      lua-language-server
      mako # wayland notification daemon
      marksman # markdown language server
      mpv
      ncspot # ncurses spotify client written in rust
      neovim
      nodePackages_latest.bash-language-server
      nodejs_20
      nsxiv # image viewer
      pamixer # pulseaudio control
      playerctl # keyboard audio controls
      python311
      ranger
      ripgrep # real fast grep written in rust
      rnix-lsp # nix lsp
      rofi
      rust-analyzer
      rustc
      rustup
      spotify-tui
      spotifyd # lightweight spotify daemon
      taskwarrior
      tldr
      tree
      tree-sitter # the executable
      vlc
      waybar
      wget
      wiki-tui
      wl-clipboard # neovim clipboard integration
      yt-dlp
      zathura # pdf viewer
    ];

    networking.hostName = hostName;
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.useDHCP = false;
    networking.hosts."172.29.0.191" = [ "clint" ];
  };
}
