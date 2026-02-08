# zsh.nix

{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
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
      nixconf = "sudo nvim /etc/nixos/configuration.nix";
      nixhome = "sudo nvim /etc/nixos/home.nix";
      nixflake = "sudo nvim /etc/nixos/flake.nix";
      nixrs = "sudo nixos-rebuild switch";
      img = "qimgv";
      stash = "cd /home/kobi/Media && ./stash-linux";
      pavu = "pavucontrol";
      H = "Hyprland";
      git = "sudo git";
    };
    
    history = {
      size = 10000;
    };

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "alias-finder"
	"common-aliases"
	"colored-man-pages"
	"fzf"
	"kitty"
	"vscode"
      ];
    };
  };
}
