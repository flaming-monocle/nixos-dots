{ config, pkgs, lib, ... }: 
{
  home.systemPackages = with pkgs; [
    obs-studio
  ];
}
