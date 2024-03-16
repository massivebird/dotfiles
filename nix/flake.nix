{
  description = "massivebird's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {

    # nixpkgs.lib.nixosSystem handles packages + settings.
    # It guarantees that the result produces a valid operating system.

    # nixosMachine flow courtesy of Stel @ stelcodes! :3

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

  };
}
