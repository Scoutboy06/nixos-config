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

  home.packages = with pkgs; [
    htop
    tree
    direnv
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
