# sound-pro.nix

{ config, lib, pkgs, ... }:

{
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context-properties" = {
	  "default.clock.rate" = 48000;
	  "default.clock.quantum" = 1024;
	  "default.clock.min-quantum" = 512;
	  "default.clock.max-quantum" = 2048;
        };
      };
    };
  };

  boot.extraModprobeConfig = ''
    options snd_usb_audio vid=0x1235 pid=0x8211 device_setup=1
  '';

  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
    alsa-plugins
    alsa-utils

    scarlett2
    alsa-scarlett-gui
  ];
}
