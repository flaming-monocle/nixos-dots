# gaming.nix

{ config, lib, pkgs, ... }:

{
  programs.steam = {
    enable = true; # cannot be config'd in home.nix
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  
  programs.steam.gamescopeSession.enable = true;
  
  programs.gamemode.enable = true; 
}
