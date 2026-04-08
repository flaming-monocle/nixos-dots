# nixvim/plugins.nix
{ config, pkgs, lib, ... }:
let
  base16 = config.lib.stylix.colors.withHashtag;in
{


  # Remember, extraPackages are declared on nixvim.nix

  programs.nixvim.plugins = {
    # One liners
    lz-n.enable = true;
    lspkind.enable = true;
    tiny-inline-diagnostic.enable = true;
    cursorline.enable = true;
    fzf-nerdfont.enable = true;
    web-devicons.enable = true;
    #neoscroll.enable = true;

    # Testing ground / todo list
    # lualine?
    # bufferline?
    # barbecue?
    # treesitter?
    # chadtree?
    # project-nvim?
    # render-markdown?
    # neoscroll?
  };

  imports = [
    ./plugins/blink-cmp.nix
    ./plugins/grug-far.nix
    ./plugins/lsp.nix
    ./plugins/telescope.nix
    ./plugins/alpha.nix
    #./plugins/.nix
  ];
}
