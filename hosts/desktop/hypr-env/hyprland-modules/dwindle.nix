# hyprland-dwindle.nix
{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      general = {
        layout = "dwindle";
      };
      input."follow_mouse" = 1; # focus change on hover enabled
    };
  };
  config.custom.hyprlandLayoutBindm = [
    "$mod, mouse:272, movewindow"
  ];
}
