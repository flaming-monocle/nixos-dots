# nixvim/plugins.nix
{ config, pkgs, lib, ... }:
let
  base16 = config.lib.stylix.colors.withHashtag;
in
{
  # Remember, extraPackages are declared on nixvim.nix
  programs = {
    nixvim.plugins = {
      # One liners
      lz-n.enable = true;
      lspkind.enable = true;
      tiny-inline-diagnostic.enable = true;
      cursorline.enable = false;
      fzf-nerdfont.enable = true;
      web-devicons.enable = true;
  
      auto-session = { # Automatically save/restore splits & buffers
        enable = true;
        settings = {
          autoRestore.enabled = true;
          autoSave.enabled = true;
          autoSessionSuppressDirs = [ "~/" "/tmp" ];
        };
      };
  
      # Testing ground / todo list
      # lualine?
      # barbecue?
      # treesitter?
      # render-markdown?
      # neoscroll?

      # 1. THE SIDEBAR: Neo-tree
      # Provides a visual folder tree. 
      neo-tree = {
        enable = true;
        loseIfLastWindow = true;
        filesystem = {
          follow_current_file.enabled = true;
          filtered_items.hide_dotfiles = false;
        };
      };
  
      # 2. THE TABS: Bufferline
      # Shows open files at the top of the screen.
      bufferline = {
        enable = true;
        settings.options = {
          # Keeps the tabs from shifting when Neo-tree opens
          offsets = [{
            filetype = "neo-tree";
            text = "Explorer";
            text_align = "left";
            separator = true;
          }];
        };
      };
  
      # 3. THE FILE EDITOR: Oil
      # Lets you edit directories like text buffers (rename, move, etc).
      oil = {
        enable = true;
        # Overrides nixpkgs to delete conflicting doc file "recipes.md"
        package = pkgs.vimPlugins.oil-nvim.overrideAttrs (oldAttrs: {
          postInstall = ''
            rm -f $out/doc/recipes.md
          '';
        });
        settings = {
          defaultFileExplorer = true; # Replaces the clunky netrw
          viewOptions.showHidden = true;
        };
      };
  
      # 4. THE CONTEXT MANAGER: Project.nvim
      # Automatically detects project roots (looks for .git).
      project-nvim = {
        enable = true;
        enableTelescope = true; # Integrates with Telescope for <leader>fp
      };
  
      # 5. THE BRAIN: Obsidian
      # Markdown-specific logic for your vault.
      obsidian = {
        enable = true;
        settings = {
          workspaces = [
            {
              name = "vault";
              path = "~/Documents/'Second Brain'"; # Adjust this to your vault path
            }
          ];
          completion = {
            nvim_cmp = false;
            min_chars = 2;
          };
          # Optional: Makes links look cleaner
          ui.enable = true;
        };
      };
    };
  };

  imports = [
    ./blink-cmp.nix
    ./grug-far.nix
    ./lsp.nix
    ./telescope.nix
    ./alpha.nix
    #./plugins/.nix
  ];
}
