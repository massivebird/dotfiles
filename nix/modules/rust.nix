{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      bacon # background rust code checker
      cargo # Rust package manager, code runner, etc
      clippy # rust linting
      gdb # GNU debugger
      lc3tools # LC-3 toolchain and emulator
      libGL
      libgccjit # GNU C compiler collection
      rust-analyzer
      rustc
      rustfmt # Rust source code formatter
    ];
  };
}

