# hyprpolkit.nix
{ config, lib, pkgs, ... }:
{
	home.packages = with pkgs; [
		hyprpolkitagent
	];

	hyprpolkitagent.enable = true;
}
