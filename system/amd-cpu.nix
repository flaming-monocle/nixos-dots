# /etc/nixos/system/amd-cpu.nix

{ config, lib, pkgs, ... }:

{
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true; # Critical for Proton
    };
  };

  environment.systemPackages = with pkgs; [
    microcode-amd
  ];
}
