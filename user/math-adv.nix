# math.nix
{config, pkgs, lib, ...}:
{
	home.packages = with pkgs; [
		qalculate-gtk
		gnuplot # Dependency for qalculate graphing feature
	];
}
