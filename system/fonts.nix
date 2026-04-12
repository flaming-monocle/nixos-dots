# fonts.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    font-manager
  ];

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    google-fonts
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];
}
