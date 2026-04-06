# neovim.nix

{ config, pkgs, lib, ... }:

{
#  home.packages = with pkgs; [
#    neovim
#  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
