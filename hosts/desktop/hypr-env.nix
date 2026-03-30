{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland
    hyprpanel
    hyprpolkitagent
    hyprcursor
    hyprshot
    wl-clipboard
    wl-clip-persist
    libnotify
    xfce.thunar
    wofi
  ];

  
  # security.pam.services.hyprlock = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        # "~/wallpapers/mossy.jpg"
        "~/wallpapers/mossy-l.jpg"
        "~/wallpapers/mossy-r.jpg"
        "~/wallpapers/forest.jpg"
        # "~/wallpapers/geometric.jpg"
        # "~/wallpapers/west/jpg"
        "~/wallpapers/west-l/jpg"
        "~/wallpapers/west-r/jpg"
        # "~/wallpapers/falls.jpg"
        # "~/wallpapers/falls-l.jpg"
        # "~/wallpapers/falls-r.jpg"
	# "~/wallpapers/pass.jpg"
	# "~/wallpapers/pass-l.jpg"
	# "~/wallpapers/pass-r.jpg"
	"~/wallpapers-bigsur-day-l.png"
	"~/wallpapers-bigsur-day-r.png"
	"~/wallpapers-bigsur-night-l.png"
	"~/wallpapers-bigsur-night-r.png"
      ];
      splash = false;
      wallpaper = [
        {
	  monitor = "DP-3";
	  path = "/wallpapers/bigsur-night-l.png";
	  fit_mode = "fill";
	}
	{
	  monitor = "DP-1";
	  path = "/wallpapers/bigsur-night-r.png";
	  fit_mode = "fill";
	}
      ];
    };
  };

  # Force hyprpaper to grab the latest hyprpaper.conf on restart
  systemd.user.services.hyprpaper = {
    Unit.X-Restart-Triggers = [
      config.lib.dag.entryAfter ["writeBoundary"] "${config.xdg.configFile."hypr/hyprpaper.conf".source}"
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "DP-1, 2560x1080@60, 3440x-660, 1, transform, 3"
	"DP-3, 3440x1440@143.92, 0x0, 1"
      ];

      workspace = [
        "2, monitor:DP-1"
	"1, monitor:DP-3"
      ];

      "ecosystem:no_update_news" = true;
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun -I -a -n -W 750 -H 500 -s ~/.config/wofi/themes/gruvbox.css";

      exec-once = [
	"systemctl --user import-environment WAYLAND_DISPLAY XDG_RUNTIME_DIR HYPRLAND_INSTANCE_SIGNATURE"
	"systemctl --user start hyprpolkitagent"
        "hyprpanel"
	"hyprpaper"
      ];
      
      env = [
        #"LIBVA_DRIVER_NAME,nvidia"
        #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
	"HYPRCURSOR_SIZE, 15"
      ];
      
      general = {
        resize_on_border = true;
	allow_tearing = false;
	layout = "dwindle";
        
	"col.active_border" = "rgb(D79921) rgb(8EC07C) 0deg";
	"col.inactive_border" = "rgb(3C3836)";

	gaps_in = "5";
	gaps_out = "0,10,3,10";
	border_size = "1.5";
      };
      
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, $terminal"
	"$mod, T, exec, $terminal"
	"$mod, Q, killactive"
	"$mod, R, exec, $fileManager"
	"$mod, F, exec, firefox"
	"$mod, D, exec, $menu"
	"$mod, O, exec, obsidian"
	", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
	", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
	#", XF86AudioPlay, exec, playerctl play-pause"
	#", XF86AudioPause, exec, playerctl play-pause"
	#", XF86AudioPrev, exec, playerctl previous"
	#", XF86AudioNext, exec, playerctl next"
	"$mod, Space, togglefloating"
	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
	"$mod, 4, workspace, 4"
	"$mod, 5, workspace, 5"
	"$mod, 6, workspace, 6"
	"$mod, 7, workspace, 7"
	"$mod, 8, workspace, 8"
	"$mod, 9, workspace, 9"
	"$mod, 0, workspace, 10"
	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
	"$mod SHIFT, 0, movetoworkspace, 10"
	"SHIFT, PRINT, exec, hyprshot -o ~/Pictures/Screenshots -m output"
	"SHIFT CONTROL, PRINT, exec, hyprshot -o ~/Pictures/Screenshots -m region"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];
      
      ## COSMETICS ##
      animations = {
        enabled = true;
	bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
	animation = [
	  "windows, 1, 7, myBezier"
	  "windowsOut, 1, 7, default, popin 80%"
	  "border, 1, 10, default"
	  "borderangle, 1, 8, default"
	  "fade, 1, 7, default"
	  "fade, 1, 7, default"
        ];
      };

      decoration = {
        rounding = 10;
	active_opacity = 1.0;
	inactive_opacity = 0.9;
	blur = {
	  enabled = true;
	  size = 4;
	  passes = 3;
	  new_optimizations = true;
	  ignore_opacity = true;
	  xray = false;
        };
      };

      windowrule = [
        "opacity 0.9 0.9,class:firefox"
        "opacity 0.9 0.9,class:code-oss"
        "opacity 0.9 0.9,class:thunar"
        "opacity 0.9 0.9,class:discord"
        "opacity 0.95 override 0.95 override,class:obsidian"
	"opacity 0.9 0.9,class:spotify"
	"opacity 1, class:kitty"
      ];
    };
  };

  programs.hyprpanel.enable = true;

  services.hyprpolkitagent.enable = true;
}
