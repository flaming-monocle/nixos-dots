{ config, lib, pkgs, ... }:
{
  programs.zsh.shellAliases = {
    c = "clear";
    cs = "clear;ls";
    ct = "clear;tree";
    la = "ls -a";
    ll = "ls -l";
    lsa = "ls -laFh";
    tre = "tree";
    ter = "tree";
    root = "cd /";
    ".." = "cd ..";
    "..." = "cd ..; cd ..";
    "...." = "cd ..; cd ..; cd ..";
    vim = "nvim";
    cim = "nvim";
    nvim = "sudo nvim";
    ncim = "sudo nvim";
    nivm = "sudo nvim";
    r = "ranger";
    nixls = "cd /etc/nixos/ && tree";
    nixconf = "sudo nvim /etc/nixos/hosts/desktop/configuration.nix";
    nixhome = "sudo nvim /etc/nixos/hosts/desktop/home.nix";
    nixrs = "sudo nixos-rebuild switch --flake /etc/nixos/flake-desktop/";
    img = "qimgv";
    stash = "cd /home/kobi/Media && ./stash-linux";
    pavu = "pavucontrol";
    H = "Hyprland";
    git = "sudo git";
  };
}
