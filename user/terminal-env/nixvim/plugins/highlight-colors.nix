# nixvim/plugins/highlight-colors.nix
# For clarity: highlights color values, does not do other highlighting tasks
{ config, pkgs, lib, ... }:
{
  programs.nixvim.plugins = {
    highlight-colors = {
      enable = true;
      render = "virtual";
      virtual_symbol = "󰝤";
      enable_named_colors = true;
    };
  };
}
