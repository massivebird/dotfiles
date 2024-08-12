{
  description = "massivebird's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self} @ inputs:
    let
      inherit (self) outputs;
    in {

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
        nixosMachine = { system, hostName, userName, ... }:
          inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            # inputs relayed to each module
            specialArgs = { inherit inputs userName hostName; };
            # files containing actual OS configuration
            modules = [
              ./modules/common
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
      };

    homeConfigurations = {
        "penguino@clint" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/home.nix
          ];
        };
      };

  };
}
