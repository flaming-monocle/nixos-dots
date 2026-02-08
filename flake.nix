# flake.nix

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      t480s = nixpkgs.lib.nixosSystem {
        modules = [
	  ./hosts/laptop/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.kobi = import ./hosts/laptop/home.nix;
          }
	];
      };
      snowblack = nixpkgs.lib.nixosSystem {
        modules = [
	  ./hosts/desktop/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.userUserPackages = true;
	    home-manager.users.kobi = import ./hosts/desktop/home.nix;
          }
	];
      };
    }; 
  };
}
