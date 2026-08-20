{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      bun # JavaScript runtime/package manager/bunder/etc.
      bvi # hex editor w vim controls
      hyperfine # benchmarking tool written in rust
      mutagen
      taskwarrior3
      wiki-tui
      yt-dlp
    ];
  };
}

