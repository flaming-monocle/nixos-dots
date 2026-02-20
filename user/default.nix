# default.nix

{ config, lib, pkgs, ... }:

{
  # Cursor size and DPI
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    # Archives and Formats
    zip
    unzip
    rar
    p7zip
    gnutar
    ffmpeg

    # CLI Utils
    gnugrep
    ripgrep
    fzf
    wget
    ranger
    killall
    file
    which
    tree

    # Monitoring
    btop
    iotop
    iftop
    lsof
    pciutils
    usbutils
  ];
}
