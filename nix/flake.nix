{
  description = "massivebird's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arcsearch = {
      url = "github:massivebird/arcsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arcstat = {
      url = "github:massivebird/arcstat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bsrc = {
      url = "github:massivebird/bsrc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    died = {
      url = "github:massivebird/died";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanturn = {
      url = "github:massivebird/lanturn";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minifetch = {
      url = "github:massivebird/minifetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scoundrel = {
      url = "github:massivebird/scoundrel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    subterfuge = {
      url = "github:massivebird/subterfuge";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {

    # `nixosConfigurations.<hostname>` is the output schema used by
    # `nixos-rebuild switch --flake .#<hostname>`.
    # Each attribute can be assigned the attribute set produced
    # by `nixpkgs.lib.nixosSystem`. (see below)

    # `nixpkgs.lib.nixosSystem` handles packages + settings,
    # and guarantees that the result produces a valid operating system.

    # nixosMachine flow courtesy of Stel @ stelcodes! :3
    # This is a parameterized wrapper around `nixpkgs.lib.nixosSystem`.

    nixosConfigurations =
      let
        nixosMachine = { system, hostName, userName }:
          inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            # inputs relayed to each module
            specialArgs = { inherit inputs userName hostName; };
            # files containing actual OS configuration
            modules = [
              ./modules/common.nix
              ./hosts/${hostName}
            ];
          };
      in
      {

        # hp laptop
        ray = nixosMachine {
          hostName = "ray";
          userName = "penguino";
          system = "x86_64-linux";
        };

        # clint
        clint = nixosMachine {
          hostName = "clint";
          userName = "penguino";
          system = "x64";
        };

        # mini = nixosMachine {
        #   hostName = "mini";
        #   userName = "mini";
        #   system = "x86_64-linux";
        # };

      };

  };
}
