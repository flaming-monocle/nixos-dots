# nixvim/plugins/tiny-inline-diagnostic.nix
{ config, pkgs, lib, ... }:
{
  config.programs.nixvim.plugins.tiny-inline-diagnostic = {
    enable = true;
    settings = {
      preset = "modern"; # Options: "modern", "classic", "minimal"
      options = {
        show_source = true;
        throttle = 20;
      };
    };
  };
}
