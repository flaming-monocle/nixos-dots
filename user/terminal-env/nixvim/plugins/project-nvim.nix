# nixvim/plugins/project-nvim
{ config, pkgs, lib, ... }:
{
  config.programs.nixvim.plugins.project-nvim = {
    enable = true;
    enableTelescope = true; # Integrates with Telescope for <leader>fp
  };
}
