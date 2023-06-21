{
  description = "please work please";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    userName = "penguino";
    system = "x86_64-linux";
  in
  {
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
