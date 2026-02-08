{ config, pkgs, lib, ... }:
{
	home.username = "kobi";
	home.homeDirectory = "/home/kobi";

	# set cursor size and dpi for 4k monitor
	xresources.properties = {
		"Xcursor.size" = 16;
		"Xft.dpi" = 172;
	};

	# Packages that should be installed to the user profile.
	home.packages = with pkgs; [
		# Archives and formats
		zip
		unzip
		rar
		gnutar
		ffmpeg

		# Command Line
		gnugrep
		ripgrep
		fzf # A command-line fuzzy finder
		wget
		ranger
		git
		killall
		file
		which
		tree
		iotop # io monitoring
		iftop # network monitoring
		lsof # list open files

		# System Tools
		pciutils # lspci
		usbutils # lsusb

		# User Environment
			# TODO
			# hyprcursor setup
			# hyprshot setup
			# hyprpolkit rice
			# thunar rice
			# is wofi the best option?
		hyprland	# Window manager
		hyprpanel	# Status bar for Hyprland
		hyprpolkitagent	# Auth agent for Hyprland
		hyprcursor	# Cursor util for Hyprland
		hyprshot	# Screenshot util for Hyprland
		wl-clipboard	# Wayland clipboard
		wl-clip-persist
		libnotify	# Notifications daemon
		xfce.thunar	# GUI file manager
		wofi		# Application launcher

		# Terminal Environment
		kitty
		oh-my-zsh
		fastfetch

		# Communications
		thunderbird
		discord
		firefox
		google-chrome

		# Content Creation
			# TODO 
			# neovim rice
		neovim
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

		# Gaming
		steam
		protonup-ng
	];

	# Proton GE
	home.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
	};

	# Git
	programs.git = {
		enable = true;
		settings.user.name = "Kobi O'Reilly";
		settings.user.email = "kobi.l.oreilly@gmail.com";
	};

	# Z Shell
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			c = "clear";
			cs = "clear;ls";
			la = "ls -a";
			ll = "ls -l";
			lsa = "ls -laFh";
			root = "cd /";
			".." = "cd ..";
			"..." = "cd ..; cd ..";
			"...." = "cd ..; cd ..; cd ..";
			vim = "nvim";
			cim = "nvim";
			nvim = "sudo nvim";
			ncim = "sudo nvim";
			r = "ranger";
			nixls = "cd /etc/nixos/ && tree";
			nixconf = "sudo nvim /etc/nixos/configuration.nix";
			nixhome = "sudo nvim /etc/nixos/home.nix";
			nixflake = "sudo nvim /etc/nixos/flake.nix";
			nixrs = "sudo nixos-rebuild switch";
			img = "qimgv";
			stash = "cd /home/kobi/Media && ./stash-linux";
			pavu = "pavucontrol";
			H = "Hyprland";
			git = "sudo git";
		};
		history = {
			size = 10000;
		};
		setOptions = [
			"HIST_IGNORE_ALL_DUPS"
		];
		oh-my-zsh = {
			enable = true;
			plugins = [ 
				"alias-finder"
				"common-aliases"
				"colored-man-pages"
				"fzf"
				"kitty"
				"vscode"
			];
		};
	};

	# Kitty terminal
	programs.kitty = lib.mkForce {
		enable = true;
		themeFile = "everforest_dark_hard";
		settings = {
			# Font and cursor
			font_family = "JetBrains Mono";
			font_size = 14.0;
			adjust_line_height = "100%";
			cursor_shape = "block";
			cursor_blink_interval = 0;
			cursor_trail = 1;
			cursor_trail_decay = "0.05 0.20";
			cursor_trail_start_threshold = 1;

			# Technical settings
			scrollback_lines = 10000;
			enable_audio_bell = "no";
			confirm_os_window_close = 0;
			shell = "zsh";
			shell_integration = "enabled";

			# Visuals
			background_opacity = 0.2;
			inactive_text_alpha = 1;
			url_style = "dotted";
			show_hyperlink_targets = "yes";
			window_padding_width = 5;

			# Binds
			open_url_modifiers = "ctrl";
			kitty_mod = "alt";

			"map ctrl+c" = "copy_to_clipboard";
			"map ctrl+v" = "paste_from_clipboard";
			"map ctrl+equal" = "change_font_size all +0.5";
			"map ctrl+minus" = "change_font_size all -0.5";
		};
	};

	# Starship prompt
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			add_newline = false;
			# ░▒▓  kobi /etc/nixos  git  nixshell
			# ░▒▓ └─── % _
			format = lib.strings.concatStrings [
				"[░▒▓](fg:bg_dim)[  ](fg:fg0 bg:bg_dim)$username[ ](fg:bg_dim)"
				"$directory"
				"$git_branch"
				"$git_status"
				"$c"
				"$cpp"
				"$rust"
				"$golang"
				"$nodejs"
				"$php"
				"$python"
				"$time"
				"$line_break"
				"[░▒▓](fg:bg_dim)[ └─── % ](fg:fg0 bg:bg_dim)[](fg:bg_dim)"
				"$character"
			];
			username = {
				show_always = true;
				style_root = "fg:statusline3 bg:bg_dim";
				style_user = "fg:fg0 bg:bg_dim";
				format = "[$user ]($style)";
			};
			directory = {
				style = "fg = fg0";
				truncation_length = 3;
				truncation_symbol = "…/";
				format = "[$path]($style)";
			};
			git_branch = {
				symbol = "";
				style = "fg = fg0";
				format = "[  ](fg0)[$symbol $branch]($style)";
			};
			git_status = {
				style = "fg = fg0";
				format = "[  ](fg0)[(ahead_behind)]($style)";
			};
			nodejs = {
				symbol = "";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			c = {
				symbol = " ";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			cpp = {
				symbol = " ";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			rust = {
				symbol = "";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			golang = {
				symbol = "";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			php = {
				symbol = "";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			python = {
				symbol = "";
				style = "bg:color_blue";
				format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
			};
			time = {
				disabled = false;
				time_format = "%R";
				style = "fg = fg0";
				format = "[  ](fg0)[$time]($style)";
			};
			character = {
				success_symbol = "";
				error_symbol = "";
			};
			palette = "everforest";
			palettes.everforest = {
				bg_dim = "#232a2e";
				bg0 = "#2d353b";
				bg1 = "#343f44";
				bg2 = "#3d484d";
				bg3 = "#475258";
				bg4 = "#4f585e";
				bg5 = "#56635f";
				bg_green = "#425047";

				fg0 = "#d3c6aa";
				statusline3 = "#e67e80";
			};
		};
	};

	# Desktop environment
	wayland.windowManager.hyprland = {
		enable = true;
		# env = "HYPRCURSOR_SIZE, 15"
		settings = {
			source = [
				"~/.config/hypr/snowBlack.conf"
				"~/.config/hypr/themeGruvDark.conf"
				"~/.config/hypr/cosmetics.conf"
			];
			"$terminal" = "kitty";
			"$fileManager" = "thunar";
			"$menu" = "wofi --show drun -I -a -n -W 750 -H 500 -s ~/.config/wofi/themes/gruvbox.css";
			exec-once = [
				"hyprpanel"
				"systemctl --user start hyprpolkitagent"
			];
			env = [
				"LIBVA_DRIVER_NAME,nvidia"
				"__GLX_VENDOR_LIBRARY_NAME,nvidia"
			];
			general = {
				resize_on_border = true;
				allow_tearing = false;
				layout = "dwindle";
			};
			"$mod" = "SUPER";
			bind = [
				"$mod, Return, exec, $terminal"
				"$mod, T, exec, $terminal"
				"$mod, Q, killactive"
				"$mod, R, exec, $fileManager"
				"$mod, F, exec, firefox"
				"$mod, Space, togglefloating"
				"$mod, D, exec, $menu"
				"$mod, O, exec, obsidian"
				"$mod, G, exec, lutris"
				", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
				", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
				", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPause, exec, playerctl play-pause"
				", XF86AudioPrev, exec, playerctl previous"
				", XF86AudioNext, exec, playerctl next"
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

	# TODO declarative hyprpanel setup
	programs.hyprpanel = {
		enable = true;
	};

	# Hyprpolkit init
	services.hyprpolkitagent = {
		enable =true;
	};

	# TODO KDE Connect setup

  home.stateVersion = "25.11";
}
