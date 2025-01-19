{ config, pkgs, nixos-wsl, ... }:

{
  imports = [
  ];

  wsl.enable = true;
  wsl.defaultUser = "elias";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    wget
    tmux
    neovim
    cargo
    nodejs
    fzf
    starship
    home-manager
  ];
  environment.variables.EDITOR = "nvim";
}
