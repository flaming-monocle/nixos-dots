# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "usbcore.autosuspend=-1" ];
  };

  # Networking
  networking = {
    hostName = "t480s";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # Home-manager temp
   home-manager = {
     useUserPackages = true;
     useGlobalPkgs = true;
     backupFileExtension = "backup";
   };

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kobi = {
    isNormalUser = true;
    description = "Kobi";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  services.desktopManager.plasma6.enable = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    tree
  ];
  
  programs.firefox.enable = true;

  system.stateVersion = "25.11";

}
