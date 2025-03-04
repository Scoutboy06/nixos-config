{ config, pkgs, ... }:

{
  imports = [
    ./modules/tmux.nix
  ];

  home.username = "elias";
  home.homeDirectory = "/home/elias";
  home.stateVersion = "24.11"; # Please read the documentation before changing.

  programs.starship = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      la = "ls -a";
      ll = "ls -al";
      cl = "clear";
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumt_night_transparent";
      editor.cursor-shape = {
        normal = "block";
	insert = "bar";
	select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumt_night";
	"ui.background" = { };
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    htop
    tree
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
