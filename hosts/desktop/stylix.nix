# stylix.nix
{ inputs, pkgs, lib, ... }:
{
	imports = [
		inputs.stylix.homeModules.stylix
	];

	stylix = {
		enable = true;

		# Ignore certain programs:
		targets = {
			hyprpanel.enable = false;
			starship.enable = false;
      
      nixvim.enable = false;
    };

		opacity = {
			terminal = 0.5;
		};

		fonts = {
			serif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Serif";
			};
		
			sansSerif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Sans";
			};
			
			monospace = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Sans Mono";
			};
			
			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};
		};

		base16Scheme = {
			system = "base16";
			name = "Everbox Dark";
			author = "Kobi O'Reilly (https://github.com/flaming-monocle)";
			# Credits: 
			#	https://github.com/nordtheme/nord
			# https://github.com/sainnhe/everforest
			# https://github.com/sainnhe/gruvbox-material
			variant = "dark";

			palette = {
				base00 = "#1E2326"; # bg0
				base01 = "#272E33"; # bg1
				base02 = "#414B50"; # bg2
				base03 = "#596971"; # fg0 
					# comments
					# vim numbers
				base04 = "#DDC7A1"; # fg1
				base05 = "#E9E8DA"; # fg2
					# most terminal text
					# vim operators
					# bit bright at the moment
				base06 = "#384B55"; # bg_blue
				base07 = "#1E2326"; # bg0
				base08 = "#E57E80"; # fg_red
					# error text
					# vim variables
				base09 = "#6C95C7"; # fg_darkblue
				base0A = "#DABC7F"; # fg_yellow
				base0B = "#89B482"; # fg_aqua
					# vim strings
				base0C = "#A7C080"; # fg_green
				base0D = "#8FBCBB"; # fg_lightblue
				base0E = "#E78A4E"; # fg_orange
					# warnings
				base0F = "#E9E8DA"; # fg1
			};
		};

#		base16Scheme = {
#			system = "base16";
#			name = "Everforest Dark Hard";
#			author = "Sainnhe Park (https://github.com/sainnhe)";
#			variant = "dark";
#
#			palette = {
#				# 26.04.02: swapped base08 (original: red) and base0D (blue)
#				base00 = "#272e33"; # bg0,       palette1 dark
#				base01 = "#2e383c"; # bg1,       palette1 dark
#				base02 = "#414b50"; # bg3,       palette1 dark
#				base03 = "#859289"; # grey1,     palette2 dark
#				base04 = "#9da9a0"; # grey2,     palette2 dark
#				base05 = "#d3c6aa"; # fg,        palette2 dark
#				base06 = "#edeada"; # bg3,       palette1 light
#				base07 = "#fffbef"; # bg0,       palette1 light
#				base0D = "#e67e80"; # red,       palette2 dark
#				base09 = "#e69875"; # orange,    palette2 dark
#				base0A = "#dbbc7f"; # yellow,    palette2 dark
#				base0B = "#a7c080"; # green,     palette2 dark
#				base0C = "#83c092"; # aqua,      palette2 dark
#				base08 = "#7fbbb3"; # blue,      palette2 dark
#				base0E = "#d699b6"; # purple,    palette2 dark
#				base0F = "#9da9a0"; # grey2,     palette2 dark
#			};
#		};

  };

	gtk.gtk4.theme = null;

}
