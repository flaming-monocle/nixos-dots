# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	# Boot options
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelParams = [ "usbcore.autosuspend=-1" ];

	# Hardware
	hardware = {
		cpu.amd.updateMicrocode = true;
		graphics = {
			enable = true;
			enable32Bit = true; # Critical for proton
		};
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			modesetting.enable = true;	# required for features and stability
			powerManagement.enable = false;
			nvidiaPersistenced = true;
			open = false;
		};
	};
	services.xserver.videoDrivers = [ "nvidia" ];

	# Networking
	networking = {
		hostName = "snowblack";
		networkmanager.enable = true;
		firewall.enable = true;
	};

	# Locale
	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";

	# Keyboard
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Sound
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};
	services.pipewire.extraConfig.pipewire."92-low-latency" = {
		"context.properties" = {
  			"default.clock.rate" = 48000;
			"default.clock.quantum" = 1024;
			"default.clock.min-quantum" = 512;
			"default.clock.max-quantum" = 2048;
		};
	};
	boot.extraModprobeConfig = ''
		options snd_usb_audio vid=0x1235 pid=0x8211 device_setup=1
	'';
	
	# System-wide settings
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowInsecure = true;
	nix.settings.auto-optimise-store = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	programs.dconf.enable = true;
	security.polkit.enable = true;

	# Home Manager
	home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "backup";
	};
	environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	# Users
	users.users.kobi = {
		isNormalUser = true;
		description = "Kobi";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};

	# OpenRGB
	services.hardware.openrgb.enable = true;
	services.hardware.openrgb.motherboard = "amd";

	# List packages installed in system profile. To search, run:
	# $ nix search [query]
	environment.systemPackages = with pkgs; [
		# Hardware
		linux-firmware
		microcode-amd
		dconf-editor
		vim
		clang
		openrgb-with-all-plugins
		scarlett2
		alsa-scarlett-gui

		# System Function
		wayland
		wayland-protocols
		xwayland

		# Sound
		pavucontrol	# PulseAudio VolUme Control
		pamixer	# cli mixer for pulseaudio
		alsa-plugins
		alsa-utils
		#sof-firmware	# sound firmware
	];

	fonts.fontDir.enable = true;
	fonts.packages = with pkgs; [
		google-fonts
		noto-fonts
		nerd-fonts.hack
		nerd-fonts.jetbrains-mono
	];
	
	# services.stash = {
	#	enable = true;
	#	settings = {
	#		stash = [
	#			{
	#				Path = "/home/kobi/Media/nsfw";
	#			}
	#		];
	#	};
	# };

	services.tumbler.enable = true;	# thumbnail support in Thunar
	services.gvfs.enable = true; # file shortcuts in hyprctl dash
	programs.zsh.enable = true; # enables zsh
	programs.steam = {
		enable = true; # cannot be config'd in home.nix
		extraCompatPackages = with pkgs; [
			proton-ge-bin
		];
	};
	programs.steam.gamescopeSession.enable = true;
	programs.gamemode.enable = true;
	nix.settings.download-buffer-size = 262144000; # 250MB	
	environment.sessionVariables = {
		# Forces wayland for element transparency reasons
		NIXOS_OZONE_WL = "1";
	};

	# Grafana things
	services.grafana = {
		enable = true;
		settings = {
			server = {
				port     = 3000;
				domain   = "localhost";
				protocol = "http";
			};
		};
		provision = {
			enable = true;
			datasources.settings.datasources = [
				{
					name = "Prometheus";
					type = "prometheus";
					url = "http://localhost:9090";
					isDefault = true;
				}
			];
		};
	};
	services.prometheus = {
		enable = true;
		port = 9090;
		scrapeConfigs = [
			{
				job_name = "nvidia-gpu";
				static_configs = [{
					targets = [ "127.0.0.1:9835" ];
				}];
			}
		];
		exporters.nvidia-gpu = {
			enable = true;
		};
	};

	system.stateVersion = "25.11";
}
