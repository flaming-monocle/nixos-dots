# systemd wallpaper switcher for AM/PM
{ pkgs, ... }:
let 
  mainPapeDirDay = ./../../../wallpapers/bigsur-day-l.png;
  mainPapeDirNight = ./../../../wallpapers/bigsur-night-l.png;
  portraitPapeDirDay = ./../../../wallpapers/bigsur-day-r.png;
  portraitPapeDirNight = ./../../../wallpapers/bigsur-night-r.png;

  wallpaperScript = pkgs.writeShellScriptBin "cycle-wallpaper" ''

    TIME=$(date +%H)

    AM_WP_L=${mainPapeDirDay}
    AM_WP_R=${portraitPapeDirDay}
    PM_WP_L=${mainPapeDirNight}
    PM_WP_R=${portraitPapeDirNight}

    if [ $TIME -gt 6 ] && [ $TIME -lt 18 ]; then
      WP_L=$AM_WP_L
      WP_R=$AM_WP_R
    else
      WP_L=$PM_WP_L
      WP_R=$PM_WP_R
    fi

    if pgrep -x "hyprpaper" > /dev/null; then
      ${pkgs.hyprland}/bin/hyprctl hyprpaper preload "$WP_L"
      ${pkgs.hyprland}/bin/hyprctl hyprpaper preload "$WP_R"
      ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper "DP-3,$WP_L"
      ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper "DP-1,$WP_R"
    fi
  '';
in
{
  home.packages = [ wallpaperScript ];

  systemd.user.services.wallpaper-cycle = {
    Unit = {
      Description = "Set wallpaper based on time of day";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      Environment = [
        "DISPLAY=:0"
	"WAYLAND_DISPLAY=wayland-1"
	"XDG_RUNTIME_DIR=/run/user/1000"
      ];
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
      ExecStart = "${wallpaperScript}/bin/cycle-wallpaper";
    };
    Install ={
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.timers.wallpaper-cycle = {
    Unit = {
      Description = "Timer for wallpaper rotation";
    };
    Timer = {
      OnCalendar = [ "06:00:00" "18:00:00" ];
      OnStartupSec = "5sec";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
