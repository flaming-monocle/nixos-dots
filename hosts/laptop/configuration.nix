# configuration.nix

{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../system/defaults.nix
    #./../../system/monitoring-tools.nix
    ./../../system/sound-pro.nix
    ./../../system/fonts.nix
    ./../../system/wayland.nix
    ./../../system/zsh.nix
    ./../../system/thunar.nix
  ];

  # Networking
  networking = {
    hostName = "t480s";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Users
  users.users.kobi = {
    isNormalUser = true;
    description = "Kobi";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  #environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs; [
    # Temp
  ];
  
  system.stateVersion = "25.11"; # DO NOT MODIFY

  ## TO ABSTRACT ##
  programs.hyprland.enable = true;
}
