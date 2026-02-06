# git.nix

{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "Kobi O'Reilly";
    settings.user.email = "kobi.l.oreilly@gmail.com";
  };
}
