# nixvim.nix
{ config, inputs, pkgs, ... }:
let 
  base16 = config.lib.stylix.colors.withHashtag;
  button = key: desc: action: {
    type = "button";
    val = desc;
    on_press = { __raw = "function() vim.cmd([[${action}]]) end"; };
    opts = {
      shortcut = key;
      width = 30;
      align_shortcut = "right";
      hl_shortcut = "Keyword";
    };
  };
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    extraPackages = with pkgs; [
      nil
      markdown-oxide
      ripgrep
      fd
      nixfmt
    ];

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    plugins = {
      # Lazy loading
      lz-n.enable = true;
  
      # LSP
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls.enable = true;
          markdown-oxide = {
            enable = true;
            filetypes = [ "markdown" ];
          };
          obsidian = {
            enable = true;
            workspaces = [
              {
                name = "secondbrain";
                path = "~/Documents/'Second Brain'";
              }
            ];
            completion = { # wikilink syntax consistency with Obsidian, according to Gemini
              nvim_cmp = false; # conflicts with blink-cmp
              min_chars = 2;
            };
            # map 'gd' to follow links in plugin logic:
            follow_url_func.__raw = ''
              function(url)
                vim.fn.jobstart({"xdg-open", url})
              end
            '';
          };
          pyright = {
            enable = true;
            filetypes = [ "python" ];
          };
          jsonls = {
            enable = true;
            filetypes = [ "json" ];
          };
          nil_ls = {
            enable = true;
            filetypes = [ "nix" ];
          };
        };
        keymaps = {
          silent = true;
          lspbuf = {
            "K" = "hover";
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gI" = "implementation";
            "gy" = "type_definition";
            "<leader>rn" = "rename";
          };
          diagnostic = {
            "[" = "goto_prev";
            "]" = "goto_next";
          };
        };
      };
  
      # Troubleshooting
      tiny-inline-diagnostic.enable = true;
  
      # Completion
      blink-cmp = {
        enable = true;
        settings = {
          #appearance.nerd_font_variant = "mono";
          keymap.preset = "super-tab"; # Everything through tab, baby
          sources.default = [ "lsp" "path" "snippets" "buffer" ];
          fuzzy = {
            implementation = "lua";
          };
          cmdline = {
            completion = {
              list.selection.preselect = false;
              menu.auto_show = true;
            };
            keymap.preset = "super-tab";
          };
          completion = {
            list.selection.preselect = false;
            accept.auto_brackets.enabled = true;
            ghost_text.enabled = true;
            trigger = {
              prefetch_on_insert = true;
              show_on_backspace = false;
            };
          };
        };
      };
      
      # Languages
      #flutter-tools = {
      #  enable = true;
      #  lazyload.settings.ft = "flutter";
      #};
      #nix = {
      
      #  enable = true;
      #  lazyload.settings.ft = "nix";
      #};
      #render-markdown = {
      #  enable = true;
      #  lazyload.settings.ft = "markdown";
      #};
			
      # Navigation
      #treesitter.enable = true;
      grug-far = {
        enable = true;
        lazyload.settings.cmd = "GrugFar";
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true; # Improves sorting performance significantly
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fr" = "oldfiles"; # Recent files
        };
        settings = {
          defaults = {
            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.55;
              };
            };
            sorting_strategy = "ascending";
            file_ignore_patterns = [
              "^.git/"
              "^node_modules/"
              "^target/"
            ];
          };
        };
      };
      #chadtree.enable = true;
      #project-nvim.enable = true;

      # UI
      lspkind = { # gives a lil icon preview of word-matching type
        enable = true;
      };
      #barbecue.enable = true;
      #lualine = {
        #enable = true;
      #};
      #bufferline.enable = true;
      cursorline.enable = true;

      alpha = {
        enable = true;
        theme = null;
        layout = [
          # Header
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
            opts = { hl = "Type"; position = "center"; };
          }

          # Palette
          { type = "padding"; val = 3; }
          {
            type = "text";
            val = "Base16 - Everbox Dark";
            opts = { hl = "Comment"; postion = "center"; };
          }
          {
            type = "text";
            #val = " ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██  ██ ";
            val = "           ██   ██   ██   ██   ██   ██   ██   ██   ██           "
;
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
                [ "Stylixbase08" 12 13 ]
                [ "Stylixbase09" 17 18 ]
                [ "Stylixbase0A" 22 23 ]
                [ "Stylixbase0B" 27 28 ]
                [ "Stylixbase0C" 32 33 ]
                [ "Stylixbase0D" 37 38 ]
                [ "Stylixbase0E" 42 43 ]
                [ "Stylixbase0F" 47 48 ]
                [ "Stylixbase0G" 52 53 ]
              ];
            };
          }
          { type = "padding"; val = 3; }

          # Buttons
          {
            type = "group";
            val = [
              (button "n" "  New File" "ene | startinsert")
              (button "s" "  Restore Session" "SessionRestore")
              (button "r" "󰄉  Recent Files" "Telescope oldfiles")
              (button "d" "󰉓  Find Directory" "Telescope zoxide list")
              (button "f" "󰱼  Find File" "Telescope find_files")
              (button "g" "󰍉  Find Text" "Telescope live_grep")
              (button "q" "󰈆  Quit" "qa")
            ];
          }
          { type = "padding"; val = 3; }

          # Date and Time
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
      neoscroll.enable = true;

      # Utilities
      #obsidian.enable = true;
      #sniprun.enable = true;
      #dap.enable = true;
      #lasplace.enable = true;
      #todo-comments.enable = true;
      #neoformat.enable = true;
      #persistence.enable = true;
      #origami.enable = true;
      #fidget.enable = true;

      # Icons
      fzf-nerdfont.enable = true;
      web-devicons.enable = true;
    };

    keymaps = [
      #TODO add a leave-insert-mode analog for <esc>
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>";
        key = "<left>"; 
      }
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; 
	      key = "<down>"; 
      }
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; 
	      key = "<up>";
      }
      {
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; 
	      key = "<right>"; 
      }
    ];

    opts = {
      # Performance
      updatetime = 100;

      # UI & Appearance
      termguicolors = true;
      
      #number = true;
      relativenumber = true;
      cursorline = true;
      scrolloff = 8;
      
      # Windows & Splits
      splitbelow = true;
      splitright = true;

      # Search
      ignorecase = true;
      
      # Files & Buffers
      undofile = true;
      fileencoding = "utf-8";
      encoding = "utf-8";

      # Indentation & Formatting
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      breakindent = true;
      preserveindent = true;
      wrap = true;

      # Completion & Popups
      pumheight = 5;
      infercase = true;

      # Command Line & Messages
      cmdheight = 0;
      history = 100;
    };
    #colorscheme = "everforest";
    
    extraConfigLua = ''
      local colors = {
        base08 = "${base16.base08}", base09 = "${base16.base09}",
        base0A = "${base16.base0A}", base0B = "${base16.base0B}",
        base0C = "${base16.base0C}", base0D = "${base16.base0D}",
        base0E = "${base16.base0E}", base0F = "${base16.base0F}",
      }
      for name, hex in pairs(colors) do
        vim.api.nvim_set_hl(0, "Stylix" .. name, { fg = hex })
      end
    '';
  };
}
