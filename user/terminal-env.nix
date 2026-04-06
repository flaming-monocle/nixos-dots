# terminal-env.nix
{ config, lib, pkgs, ... }:
{
  imports = [
    ./terminal-env/git.nix
    ./terminal-env/kitty.nix
    ./terminal-env/zsh.nix
    ./terminal-env/nixvim.nix
    ./terminal-env/starship.nix
    #./terminal-env/math.nix
  ];
}
