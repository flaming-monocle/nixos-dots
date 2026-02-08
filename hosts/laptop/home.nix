# hosts/laptop/home.nix

{ config, pkgs, lib, ... }:

{
  home.username = "kobi";
  home.homeDirectory = "/home/kobi";

  imports = [
    ./../../user/default.nix
    ./../../user/terminal-env.nix
    ./zsh-aliases.nix
    ./../../user/hypr-env.nix
  ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Communications
    thunderbird
    discord
    firefox
    google-chrome

    # Content Creation
    vscodium
    obsidian
    kdePackages.kate
    gimp
    shotcut
    audacity
    reaper
    libreoffice-qt

    # Content consumption
    qimgv
    vlc
    spotify
    transmission_4
  ];

  home.stateVersion = "25.11";
}
