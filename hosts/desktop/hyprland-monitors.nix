{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = "DP-1, 2560x1080@60, 3440x-660, 1";
    workspace = "2, monitor:DP-1";

    monitor = "DP-3, 3440x1440@143.92, 0x0, 1";
    workspace = "1, monitor:DP-3";
  };
}
