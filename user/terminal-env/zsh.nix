{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    history = {
      size = 10000;
    };

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "alias-finder"
	    "common-aliases"
	    "colored-man-pages"
	    "fzf"
	    "kitty"
	    "vscode"
      ];
    };
  };
}
