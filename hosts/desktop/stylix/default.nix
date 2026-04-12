# stylix.nix
{ config, pkgs, lib, inputs, ... }:
{
	imports = [
    #./everforest.nix
    #./everbox.nix
    ./apollo.nix
	];

	gtk.gtk4.theme = null;
}
