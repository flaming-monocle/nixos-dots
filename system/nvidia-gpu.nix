# nvidia-gpu.nix

{ config, pkgs, lib, ... }:
{
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    nvidiaPersistenced = true;
    open = false;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
