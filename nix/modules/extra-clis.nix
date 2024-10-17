{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      bun # JavaScript runtime/package manager/bunder/etc.
      gh # github cli
      hyperfine # benchmarking tool written in rust
      taskwarrior3
      wiki-tui
      yt-dlp
    ];
  };
}

