# defaults.nix
{ config, lib, pkgs, ... }:
{
  # Boot options
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "usbcore.autosuspend=-1" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Home Manager
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
  };
  
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # System-wide Settings
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;
  nix.settings.auto-optimise-store = true;
  nix.settings.download-buffer-size = 262144000; # 250MB
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.polkit.enable = true;

  # Default Packages
  environment.systemPackages = with pkgs; [
    linux-firmware
    dconf-editor
    clang
  ];
  
  # Default Programs
  programs.dconf.enable = true;
  programs.firefox.enable = true;
  environment.variables.EDITOR = "nvim";
  environment.variables.SUDO_EDITOR = "nvim";

	# Garbage Collection
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};  
}
