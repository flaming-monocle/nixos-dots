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
    
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libxcursor
        libxi
				libxinerama
        libxscrnsaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };
  
  programs.steam.gamescopeSession.enable = true;
  
  programs.gamemode.enable = true; 
}
