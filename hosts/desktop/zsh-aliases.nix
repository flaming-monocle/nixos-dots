{ config, lib, pkgs, ... }:
{
  programs.zsh = {
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
      ivm = "nvim";
      svim = "sudoedit";
      r = "ranger";
      nixls = "cd /etc/nixos/ && tree -I 'wallpapers|flake-laptop|hosts/laptop'";
      nixconf = "sudo vim /etc/nixos/hosts/desktop/configuration.nix";
      nixhome = "sudo vim /etc/nixos/hosts/desktop/home.nix";
      nixrs = "cd /etc/nixos && sudo git add . && sudo nixos-rebuild switch --flake /etc/nixos/flake-desktop/";
      img = "qimgv";
      stash = "cd /home/kobi/Media && ./stash-linux";
      pavu = "pavucontrol";
      H = "Hyprland";
      g = "git";
      sg = "sudo git";
      ga = "git add .";
      sga = "sudo git add .";
      #gc = "git commit -m";
      #sgc = "sudo git commit -m";
      ggpull = ''git pull origin "$(current_git_branch)"'';
      sggpull = ''sudo git pull origin "$(current_git_branch)"'';
      ggpush = ''git push origin "$(current_git_branch)"'';
      sggpush = ''sudo git push origin "$(current_git_branch)"'';
    };

    initContent = ''
			gc() { 
				git commit -m "$*" 
			}
			sgc() { 
				sudo git commit -m "$*" 
			}
		'';
  };
}
