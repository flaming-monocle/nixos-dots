# git.nix

{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "flaming-monocle";
    settings.user.email = "kobi.l.oreilly@gmail.com";
  };
}
