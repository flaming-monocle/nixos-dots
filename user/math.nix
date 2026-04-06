# math.nix
{config, pkgs, lib, ...}:
{
	home.packages = with pkgs; [
		kalker
	];
}
