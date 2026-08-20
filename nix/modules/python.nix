{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      python314
      ruff # Python LSP
      basedpyright # Python language server
    ];
  };
}

