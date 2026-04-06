{ config, pkgs, lib, ... }:
{
	home.packages = with pkgs; [
		hyprland
		hyprcursor
		rose-pine-hyprcursor # sourced through /flake-desktop/flake.nix
		hyprshot
		libnotify
		thunar # investigate replacements
		hyprpolkitagent
	];

	services.hyprpolkitagent.enable = true;

 	wayland.windowManager.hyprland = {
  	enable = true;
  	settings = {
  		input = {
  			"accel_profile" = "flat";
  			"numlock_by_default" = "true";
       };
       
       misc = {
         "vfr" = "true";
         "disable_hyprland_logo" = "true";
         "disable_splash_rendering" = "true";
       };
  
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
      "$menu" = "rofi";
  
      exec-once = [
  			"systemctl --user import-environment WAYLAND_DISPLAY XDG_RUNTIME_DIR HYPRLAND_INSTANCE_SIGNATURE"
  			"systemctl --user start hyprpolkitagent"
        "hyprpanel"
				"hyprpaper"
      ];
      
      env = [
        #"LIBVA_DRIVER_NAME,nvidia"
        #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
				"HYPRCURSOR_THEME,rose-pine-hyprcursor"
				"HYPRCURSOR_SIZE,25"
      ];
      
      general = {
        resize_on_border = true;
				allow_tearing = false;
				layout = "dwindle";
        
				"col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base0D}) rgb(${config.lib.stylix.colors.base0E}) 30deg";
				"col.inactive_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base06}) rgb(${config.lib.stylix.colors.base01}) 30deg";

				gaps_in = "4";
				gaps_out = "8,8,8,8";
				border_size = "2";
      };
      
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, $terminal"
				"$mod, CAPS, exec, $terminal"
				"$mod, Q, killactive"
				"$mod, R, exec, $fileManager"
				"$mod, F, exec, firefox"
				"$mod, D, exec, $menu -show drun"
				"$mod, O, exec, obsidian"
				"$mod, S, exec, spotify"
				"$mod, G, exec, gimp"
				''$mod, C, exec, [float; size 400 600] $terminal -e "kalker"''
				"$mod SHIFT, C, exec, [float;size 800 400] qalculate-gtk"
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

      animations = {
        enabled = true;
				bezier = "myBezier, 0.5, 0, 0.5, 1";
				animation = [
					"windowsIn, 1, 3, myBezier, popin 80%"
					"windowsOut, 1, 3, myBezier, popin 80%"
          "windowsMove, 1, 1, myBezier, popin 20%"
					"border, 1, 3, default"
					"borderangle, 1, 4, default"
					"fade, 1, 5, default"
        ];
      };

      decoration = {
        rounding = 5;
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
        #"opacity 1 0.9,class:firefox"
        #"opacity 1 0.9,class:code-oss"
        #"opacity 1 0.9,class:thunar"
        #"opacity 1 0.9,class:discord"
				#"opacity 1 0.9,class:spotify"
				#"opacity 1 0.9, class:kitty"
				
				# Delicate balance between Hyprland opacity and blur with Obsidian CSS. Change with caution.
        "match:class obsidian, opacity 0.95 override 0.95 override"
      ];
    };
  };
}
