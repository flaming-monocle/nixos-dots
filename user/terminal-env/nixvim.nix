# nixvim.nix
{ config, inputs, pkgs, ... }:
let 
  base16 = config.lib.stylix.colors.withHashtag;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nixvim/plugins.nix
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
  };
}
