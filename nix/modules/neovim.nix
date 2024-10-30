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
      lua51Packages.lua # lazy.nvim requires Lua 5.1
      luarocks
      marksman # markdown language server
      neovim
      nixd # Nix language server
      nodejs_20
      php82Extensions.mysqlnd # PHP MySQL extension
      ruff-lsp # Python language server
      tree-sitter # the executable
      wl-clipboard # neovim clipboard integration
    ];
  };
}
