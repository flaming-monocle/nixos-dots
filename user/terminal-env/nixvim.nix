# nixvim.nix
{ inputs, pkgs, ... }:
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
      #bashls
      #pyright
      #jsonls
    ];

    globals.mapleader = " ";
    globals.maplocalleader = " ";

  	plugins = {
  	  # Lazy loading
	    plugins.lz-n.enable = true;

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
          #nixd.enable = true; 
            # slower
            # better at custom-command autofills
            # worse at condensing messy format
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
      #coq-nvim.enable = true; # Disabled in favor of blink-cmp
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
            accept.auto_brackets.enable = true;
            ghost_text.enabled = true;
            trigger = {
              prefetch_on_insert = true;
              show_on_backspace = true;
            };
          };
        };
      };

	    # Languages
      #flutter-tools = {
	    # 	enable = true;
		  #  lazyload.settings.ft = "flutter";
	    #};
      #nix = {
		  #  enable = true;
		  #  lazyload.settings.ft = "nix";
	    #};
      #hmts = {
		  #  enable = true;
	    #  lazyload.settings.ft = "nix";
	    #};
	    #render-markdown = {
	    #  enable = true;
		  #  lazyload.settings.ft = "markdown";
	    #};
			
	    # Navigation
	    #treesitter.enable = true;
      #grug-far = {
		  #  enable = true;
		  #  lazyload.settings.cmd = "GrugFar";
	    #};
	    #telescope.enable = true;
	    #chadtree.enable = true;
	    #project-nvim.enable = true;

	    # UI
	    #lspkind = { # gives a lil icon preview of word-matching type
		  #  enable = true;
	    #};
	    #barbecue.enable = true;
	    #lualine = {
		  #enable = true;
	    #};
	    #bufferline.enable = true;
	    #cursorline.enable = true;
	    #dashboard.enable = true;
	    #neoscroll.enable = true;

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
      { # Copy to system clipboard
        action = "\"+y"; 
        key = "y"; 
      }       
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>";
        key = "<left>"; 
      }
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; key = "<down>"; 
      }
      { 
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; key = "<up>";
      }
      {
        mode = "n"; 
        action = "<cmd>echo 'Use h to move!!'<CR>"; key = "<right>"; 
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
  };
}
