# hypr-env.nix
# Currently declares all Hypr settings, including Hyprland
# Bit bloated. Consider modularizing
{ config, lib, pkgs, ... }:
{

	imports = [
		./hypr-env/hyprland-test.nix
		./hypr-env/hyprpanel.nix
		./hypr-env/hyprpaper.nix # See also: ./scripts/ampm-pape.nix
#		./hypr-env/hyprpolkit.nix
	];

	# Potentially useful for screen locking utilities
  # security.pam.services.hyprlock = true;
}
