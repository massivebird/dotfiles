{
  description = "massivebird's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    userName = "penguino";
    system = "x86_64-linux";
  in {
    nixosConfigurations = {

      # hp laptop
      ray = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs userName;
          hostName = "ray";
        };
        modules = [
          ./hosts/ray
        ];
      };

    };
  };
}
