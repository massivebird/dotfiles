{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      bacon # background rust code checker
      cargo # Rust package manager, code runner, etc
      cargo-expand # Expand macros
      clippy # rust linting
      gdb # GNU debugger
      libGL
      libgccjit # GNU C compiler collection
      rust-analyzer
      rustc
      rustfmt # Rust source code formatter
      pkg-config # common build dep
      openssl # common build dep
    ];
  };
}

