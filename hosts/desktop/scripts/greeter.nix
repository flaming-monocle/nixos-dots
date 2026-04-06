# Testing Gemini 3's ricing capacity, thinking model

# Preserving this file as a reminder about the nature of LLMs
# they'll do crazy shit for you, and you give up control 
# at every level as soon as you introduce it to a project. 
{ pkgs, lib, ... }:

let
  # 1. Define a minimal Hyprland config for the greeter
  # This configures your monitors and launches the wallpaper daemon.
  greeterHyprConf = pkgs.writeText "greeter-hyprland.conf" ''
    # Monitor setup (Adjust names to match your hardware)
    monitor=DP-3, 3440x1440, 0x0, 1
    monitor=DP-1, 2560x1080, 3440x-660, 3

    # Launch wallpaper daemon for per-monitor backgrounds
    exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
    
    # Launch the actual greeter UI
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
    
    # Visual Polish
    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
    }
    windowrulev2 = opacity 0.8, class:(regreet)
  '';

  # 2. Configure hyprpaper for the greeter user
  hyprpaperConf = pkgs.writeText "hyprpaper.conf" ''
    preload = /etc/nixos/wallpapers/bigsur-night-l.png
    preload = /etc/nixos/wallpapers/bigsur-night-r.png
    wallpaper = DP-3,/etc/nixos/wallpapers/bigsur-night-l.png
    wallpaper = DP-1,/etc/nixos/wallpapers/bigsur-night-r.png
  '';
in
{
  # Enable ReGreet (GUI)
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/nixos/wallpapers/bigsur-night.jpg"; # Used if hyprpaper fails
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        font_name = lib.mkForce "Sans 11";
      };
    };
  };

  # Configure Greetd to use our Hyprland "Greeter OS"
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Launch Hyprland with our custom greeter config
        command = "${pkgs.hyprland}/bin/Hyprland --config ${greeterHyprConf}";
        user = "greeter";
      };
    };
  };

  # Ensure the greeter user has access to the wallpaper config
  systemd.tmpfiles.rules = [
    "L+ /var/lib/greeter/.config/hypr/hyprpaper.conf - - - - ${hyprpaperConf}"
  ];
}
