# window-manager.nix

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wayland
    wayland-protocols
    xwayland
		wl-clipboard
		wl-clip-persist
  ];

  services.gvfs.enable = true; # file shortcuts in hyprctl dash

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Forces Wayland for transparency reasons
  };
}
