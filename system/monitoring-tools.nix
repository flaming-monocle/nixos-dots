# test.nix
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
  ];
}
