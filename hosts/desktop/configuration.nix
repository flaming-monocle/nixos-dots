# configuration.nix

{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../system/defaults.nix
    ./../../system/nvidia-gpu.nix
    ./../../system/amd-cpu.nix
    ./../../system/monitoring-tools.nix
    ./../../system/sound-pro.nix
    ./../../system/openrgb.nix
    ./../../system/fonts.nix
    ./../../system/gaming.nix
    ./../../system/wayland.nix
    ./../../system/zsh.nix
    ./../../system/thunar.nix
  ];

  # Networking
  networking = {
    hostName = "snowblack";
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

  environment.systemPackages = with pkgs; [
    # Temp
  ];

  system.stateVersion = "25.11"; # DO NOT MODIFY
}
