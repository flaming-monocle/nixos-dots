# kitty.nix

{ config, lib, pkgs, ... }:

{
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
}
