# nixvim/plugins/alpha.nix
{ config, pkgs, lib, ... }:
let
  button = shortcut: desc: action: {
    type = "button";
    val = desc;
    on_press = action;
    opts = {
      shortcut = shortcut;
      width = 30;
      align_shortcut = "right";
      hl_shortcut = "Keyword";
      position = "center";
      keymap = [ "n" shortcut "<cmd>${action}<cr>" { noremap = true; silent = true; } ];
    };
  };
in
{
  programs.nixvim = {
    highlight = {
      Base16_00 = { fg = "${config.lib.stylix.colors.withHashtag.base00}"; };
      Base16_01 = { fg = "${config.lib.stylix.colors.withHashtag.base01}"; };
      Base16_02 = { fg = "${config.lib.stylix.colors.withHashtag.base02}"; };
      Base16_03 = { fg = "${config.lib.stylix.colors.withHashtag.base03}"; };
      Base16_04 = { fg = "${config.lib.stylix.colors.withHashtag.base04}"; };
      Base16_05 = { fg = "${config.lib.stylix.colors.withHashtag.base05}"; };
      Base16_06 = { fg = "${config.lib.stylix.colors.withHashtag.base06}"; };
      Base16_07 = { fg = "${config.lib.stylix.colors.withHashtag.base07}"; };
      Base16_08 = { fg = "${config.lib.stylix.colors.withHashtag.base08}"; };
      Base16_09 = { fg = "${config.lib.stylix.colors.withHashtag.base09}"; };
      Base16_0A = { fg = "${config.lib.stylix.colors.withHashtag.base0A}"; };
      Base16_0B = { fg = "${config.lib.stylix.colors.withHashtag.base0B}"; };
      Base16_0C = { fg = "${config.lib.stylix.colors.withHashtag.base0C}"; };
      Base16_0D = { fg = "${config.lib.stylix.colors.withHashtag.base0D}"; };
      Base16_0E = { fg = "${config.lib.stylix.colors.withHashtag.base0E}"; };
      Base16_0F = { fg = "${config.lib.stylix.colors.withHashtag.base0F}"; };
    };

    plugins.alpha = {
      enable = true;
      theme = null;
      settings = {
        layout = [
          { type = "padding"; val = 10; }
          {
            type = "text";
            val = [
              "              db                          db                    "
              ""
              "`7MMpMMMb.  `7MM  `7M'   `MF'`7M'   `MF'`7MM  `7MMpMMMb.pMMMb.  "
              "  MM    MM    MM    `VA ,V'    VA   ,V    MM    MM    MM    MM  "
              "  MM    MM    MM      XMX       VA ,V     MM    MM    MM    MM  "
              "  MM    MM    MM    ,V' VA.      VVV      MM    MM    MM    MM  "
              ".JMML  JMML..JMML..AM.   .MA.     W     .JMML..JMML  JMML  JMML."
            ];
            opts = { 
              hl = "Type"; 
              position = "center"; 
            };
          }
          { type = "padding"; val = 2; }
          {
            type = "text";
            val = "Base16 - Everbox Dark";
            opts = { 
              hl = "Comment"; 
              position = "center"; 
            };
          }
          {
            type = "text";
            val = " ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██ ";
            #val = "            ██   ██   ██   ██   ██   ██   ██   ██               ";
            #val = "----------------------------------------------------------------";
            opts = {
              position = "center";
              hl = [
                [ "Base16_00" 1 7 ]
                [ "Base16_01" 9 15 ]
                [ "Base16_02" 17 23 ]
                [ "Base16_03" 25 31 ]
                [ "Base16_04" 33 39 ]
                [ "Base16_05" 41 47 ]
                [ "Base16_06" 49 55 ]
                [ "Base16_07" 57 63 ]
                [ "Base16_08" 65 71 ]
                [ "Base16_09" 73 79 ]
                [ "Base16_0A" 81 87 ]
                [ "Base16_0B" 89 95 ]
                [ "Base16_0C" 97 103 ]
                [ "Base16_0D" 105 111 ]
                [ "Base16_0E" 113 119 ]
                [ "Base16_0F" 121 127 ]
              ];
            };
          }
          { type = "padding"; val = 3; }
          {
            type = "group";
            val = [
              (button "n" "   New File" "ene | startinsert")
              (button "r" "   Recent Files" "Telescope oldfiles")
              (button "f" "   Find File" "Telescope find_files")
              (button "g" "   Live Grep" "Telescope live_grep")
              (button "t" "󰙅  Tree View" "")
              ""
              (button "o" "󰮋  Obsidian" "")
              (button "x" "  NixOS" "")
              (button "p" "  Projects" "Telescope projects")
              ""
              (button "m" "  Keymaps" "Telescope keymaps")
              (button "i" "  LSP Info" "LspInfo")
              (button "q" "󰅙  Quit" "qa")
              #projects
              #git branches
              #git status

              #restore session
              #save session
            ];
          }
          { type = "padding"; val = 3; }
          {
            type = "text";
            val = "";
            opts = {
              position = "center";
              hl = "Comment";
              __raw = ''
                function()
                  return os.date("%Y %m %d - %A %H:%M")
                end
              '';
            };
          }
        ];
      };
    };
  };
}
