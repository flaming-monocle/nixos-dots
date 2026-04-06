# flake.nix
{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-gaming.url = "github:fufexan/nix-gaming";
    
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, stylix, ... }: {
    nixosConfigurations = {
      snowblack = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
					./../hosts/desktop/configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.extraSpecialArgs = { inherit inputs; };
						home-manager.users.kobi = import ./../hosts/desktop/home.nix;
          }
#					stylix.nixosModules.stylix
				];
      };
    }; 
  };
}
