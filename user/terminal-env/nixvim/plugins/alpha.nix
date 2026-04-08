# nixvim/plugins/alpha.nix
{ config, pkgs, lib, ... }:
let
  base08 = config.lib.stylix.colors.withHashtag.base08;
  base09 = config.lib.stylix.colors.withHashtag.base09;
  base0A = config.lib.stylix.colors.withHashtag.base0A;
  base0B = config.lib.stylix.colors.withHashtag.base0B;
  base0C = config.lib.stylix.colors.withHashtag.base0C;
  base0D = config.lib.stylix.colors.withHashtag.base0D;
  base0E = config.lib.stylix.colors.withHashtag.base0E;
  base0F = config.lib.stylix.colors.withHashtag.base0F;
  button = key: desc: action: {
    type = "button";
    val = desc;
    #on_press = "Telescope find_files";
    on_press = { __raw = "function() vim.cmd([[${action}]]) end"; };
    opts = {
      shortcut = key;
      width = 30;
      align_shortcut = "right";
      hl_shortcut = "Keyword";
      hl = "Normal";
      position = "center";
    };
  };
in
{
  
  programs.nixvim = {
    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "alpha" ];
        command = "setlocal nocursorline | let b:cursorline_enabled = 0";
        # Fixes a startup script conflict
      }
    ];
    plugins.alpha = {
      enable = true;
      theme = null;
      settings = {
        layout = [
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
          { type = "padding"; val = 3; }
          {
            type = "text";
            val = "Base16 - Everbox Dark";
            opts = { 
              postion = "center"; 
              hl = "Comment"; 
            };
          }
          {
            type = "text";
            #val = " ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██ ";
            val = "            ██   ██   ██   ██   ██   ██   ██   ██               ";
    
            opts = {
              position = "center";
              hl = [
                #[ "Stylixbase01" 2 3 ]
                #[ "Stylixbase02" 6 7 ]
                #[ "Stylixbase03" 10 11 ]
                #[ "Stylixbase04" 14 15 ]
                #[ "Stylixbase05" 18 19 ]
                #[ "Stylixbase06" 22 23 ]
                #[ "Stylixbase07" 26 27 ]
                [ "${base08}" 12 13 ]
                [ "${base09}" 17 18 ]
                [ "${base0A}" 22 23 ]
                [ "${base0B}" 27 28 ]
                [ "${base0C}" 32 33 ]
                [ "${base0D}" 37 38 ]
                [ "${base0E}" 42 43 ]
                [ "${base0F}" 47 48 ]
              ];
            };
          }
          { type = "padding"; val = 3; }
          (button "n" " New File" "ene | startinsert")
          (button "s" " Restore Session" "SessionRestore")
          (button "r" "󰄉 Recent Files" "Telescope oldfiles")
          (button "d" "󰉓 Find Directory" "Telescope zoxide list")
          (button "f" "󰱼 Find File" "Telescope find_files")
          (button "g" "󰍉 Find Text" "Telescope live_grep")
          (button "q" "󰈆 Quit" "qa")
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
