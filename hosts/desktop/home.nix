{ config, pkgs, lib, ... }:
{
  home.username = "kobi";
  home.homeDirectory = "/home/kobi";

  imports = [
    ./../../user/default.nix
    ./../../user/terminal-env.nix
    ./../../user/gaming.nix
    ./../../user/video-recording.nix
    ./zsh-aliases.nix
    ./hypr-env.nix
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
