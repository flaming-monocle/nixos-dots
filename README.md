# Kobi's NixOS Dotfiles
*Well, maybe dotfiles isn't quite spot on.*

NixOS configured across multiple hosts, including a gruv-dark-hard rice. 
Pretty modular, pretty simple, pretty pretty. 

- *Modular*: One git repo, multiple hosts. Fully extensible. 
- *Simple*: I'm not particularly good at Nix, and this still looks clean and follows a unified format. Everything "just works". 
- *Pretty*: Comes with a gruv-dark-hard rice. I'll add more, and modularize the options, when I want more. 

Does require imperative instruction of home-manager channel, a tweak to a zsh alias, and declaring a hostname if installing from bare metal. 

- Set up home-manager with `sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz` and `sudo nix-channel --update`. Everything else works through the host-specific `flake.nix`, `configuration.nix`, and `home.nix` files. 
- In the host-specific `zsh-aliases.nix`, update `nixrs = "sudo nixos-rebuild switch --flake /path/to/flake/dir/` to reflect that host's flake directory. 
- Each host's `flake.nix` requires the declared hostname to match the machine's hostname.
