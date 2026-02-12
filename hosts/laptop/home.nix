{ config, pkgs, lib, ... }:
{
  home.username = "kobi";
  home.homeDirectory = "/home/kobi";

  imports = [
    ./../../user/default.nix
    ./../../user/terminal-env.nix
    ./hypr-env.nix
    ./zsh-aliases.nix
  ];

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
