# hyprland-scrolling.nix
{ lib, ... }:
let
  inherit (lib) mod;
  mainMonitor = "DP-3";
  portraitMonitor = "DP-1";
  wsRange = builtins.genList (i: i + 1) 10;
in
{
  config = {
    custom.hyprland = {
      layoutBind = [
        # Scrolling layout vim binds
        # TODO Make per-monitor
        # TODO Disable splitting windows vertically
        "$mod SHIFT, H, layoutmsg, swapcol l"
        "$mod, H, layoutmsg, focus l"
        "$mod SHIFT, J, movetoworkspace, +2"
        "$mod, J, workspace, +2"
        "$mod SHIFT, K, movetoworkspace, -2"
        "$mod, K, workspace, -2"
        "$mod SHIFT, L, layoutmsg, swapcol r"
        "$mod, L, layoutmsg, focus r"
      ];
      layoutWorkspace = builtins.map (ws:
        if (mod ws 2 == 0)
        then "${toString ws}, monitor:${portraitMonitor}, layoutopt:direction:down, default:true"
        else "${toString ws}, monitor:${mainMonitor}, layoutopt:direction:right, default:true"
      ) wsRange;
      layoutWindowrule = [
        #"match:class gimp, scrolling_width 0.6"
      ];
    };
  
    wayland.windowManager.hyprland = {
      settings = {
        input."follow_mouse" = 2; # no focus change on hover, ref general.no_focus_fallback
        general = {
          layout = "scrolling";
          no_focus_fallback = true; # mouse-over scrolling, but not focusing
        };
        scrolling = {
          focus_fit_method = 0; # Centers focused window in scroll
          column_width = 0.4;
          fullscreen_on_one_column = false;
          #wrap_focus = true;
        };
      };
    };
  };
}
