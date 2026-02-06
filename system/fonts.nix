# fonts.nix

{ config, lib, pkgs, ... }:

{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    google-fonts
    noto-fonts
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];
}
