# gaming.nix

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zenity
  ];
  programs.steam = {
    enable = true; # cannot be config'd in home.nix
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    protontricks.enable = true;
  };
  
  programs.steam.gamescopeSession.enable = true;
  
  programs.gamemode.enable = true; 
}
