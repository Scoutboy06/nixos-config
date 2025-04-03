{ pkgs, username, nix-index-database,
# FIXME: uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
# secrets,
... }:
let
  unstable-packages = with pkgs.unstable; [
    # FIXME: select your core binaries that you walways want on the bleeding-edge
    coreutils
    curl
    git
    htop
    tree
    tree
    unzip
    vim
    wget
    zip
  ];

  stable-packages = with pkgs; [
    # key tools
    gh
    just

    # core languages
    rustup
    gcc
    nodePackages_latest.nodejs
    python3Minimal
    go

    # rust stuff
    cargo-cache
    cargo-expand

    # local dev stuff

    # treesitter
    tree-sitter

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra # nix formatter
    deadnix # nix dead code finder
    nodePackages.prettier # js formatter
    shellcheck # bash/sh static analyzer
    shfmt # shell formatter
    statix # nix linting and suggestions
  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/helix.nix
    ./modules/tmux.nix
    ./modules/starship.nix
    # (builtins.path { path = ./modules/fish.nix; })
    # (builtins.path { path = ./modules/git.nix; })
    # (builtins.path { path = ./modules/helix.nix; })
    # (builtins.path { path = ./modules/tmux.nix; })
    # (builtins.path { path = ./modules/starship.nix; })
  ];

  home.stateVersion = "24.11"; # Please read the documentation before changing.

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "hx";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";
  };

  home.packages = stable-packages ++ unstable-packages ++ [
    # pkgs.some-package
    # pkgs.unstable.some-other-package
  ];

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;

    fzf.enable = true;
    fzf.enableFishIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    zoxide.options = [ "--cmd cd" ];
    broot.enable = true;
    broot.enableFishIntegration = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
