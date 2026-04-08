# nixvim/plugins/grug-far.nix
{ config, pkgs, lib, ... }:
{
  programs.nixvim.plugins.grug-far = {
    enable = true;
    lazyload.settings.cmd = "GrugFar";
  };
}
