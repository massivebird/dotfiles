{
  description = "massivebird's NixOS configuration";

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
  in {
    nixosConfigurations = {

      # hp laptop
      ray = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          hostName = "ray";
          system = "x86_64-linux";
          inherit inputs userName;
        };
        modules = [
          ./hosts/ray
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;   # default.nix pkgs
            home-manager.useUserPackages = true; # home.nix pkgs
            home-manager.extraSpecialArgs = {
              inherit userName;
            };
            home-manager.users.${userName} = {
              imports = [ ./hosts/ray/home.nix ];
            };
          }
        ];
      };

    };

    homeConfigurations = {
      rex = inputs.home-manager.lib.homeManagerConfiguration {
        inherit userName;
        pkgs= inputs.nixpkgs;
        modules = [ "./modules/common/home.nix" ];
      };
    };

  };
}
