{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    protonup-ng

    # For MO2:
    jq
    websocat
  ];

  # Proton GE
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
