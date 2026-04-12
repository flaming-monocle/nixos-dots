# nixvim/plugins/default.nix
{ config, pkgs, lib, ... }:
let
  base16 = config.lib.stylix.colors.withHashtag;
  vaultDir = "~/Documents/secondBrain/";
in
{
  # Remember, extraPackages are declared on nixvim.nix
  config.programs = {
    nixvim.plugins = {
      # One liners
      lz-n.enable = true;
      fzf-nerdfont.enable = true;
      web-devicons.enable = true;
      persistence.enable = true;

      #cursorline = {
      #  enable = true;
      #  settings = {
      #    cursorline = {
      #      enable = true;
      #      timeout = 0;
      #    };
      #    cursorword = {
      #      enable = true;
      #      hl = { underline = true; };
      #      min_length = 3;
      #    };
      #  };
      #};

      # Testing ground / todo list
      # lualine?
      # barbecue?
      # treesitter?
      # render-markdown?
      # neoscroll?
    };
  };

  imports = [
    ./blink-cmp.nix
    ./grug-far.nix
    (import ./lsp.nix vaultDir)
    ./telescope.nix
    (import ./alpha.nix base16 vaultDir)
    ./tiny-inline-diagnostic.nix
    ./lspkind.nix
    ./neo-tree.nix
    ./bufferline.nix
    ./oil.nix
    ./project-nvim.nix
    (import ./obsidian.nix vaultDir)
    ./highlight-colors.nix
  ];
}
