# nixvim/plugins/lspkind.nix
{ config, pkgs, lib, ... }:
{
  config.programs.nixvim.plugins.lspkind = {
    enable = true;
    settings = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
