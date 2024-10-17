{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      bash-language-server
      binutils # nvim tree-sitter dep
      fd # telescope dep: alternative to `find`
      gnat13 # GNU C++ compiler collection
      jdt-language-server # Java language server
      lldb_16 # C/C++/Rust debugger
      lua-language-server
      marksman # markdown language server
      neovim
      nixd # Nix language server
      php82Extensions.mysqlnd # PHP MySQL extension
      pyright # Python language server
      tree-sitter # the executable
      wl-clipboard # neovim clipboard integration
    ];
  };
}
