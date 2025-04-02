{ pkgs, username, nix-index-database,
# FIXME: uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
# secrets,
... }:
let
  unstable-packages = with pkgs.unstable; [
    # FIXME: select your core binaries that you walways want on the bleeding-edge
    # bar
    # bottom
    coreutils
    curl
    # du-dust
    # fd
    # findutils
    # fx
    git
    # git-crypt
    htop
    tree
    # jq
    # killall
    # mosh
    # procs
    # ripgrep
    # sd
    # tmux
    tree
    unzip
    vim
    wget
    zip
  ];

  stable-packages = with pkgs; [
    # FIXME: customize these stable packages to your liking for the languages you use

    # key tools
    gh
    just

    # core languages
    rustup
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
    # ./modules/tmux.nix
  ];

  home.stateVersion = "24.11"; # Please read the documentation before changing.

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "hx";
    # FIXME: set your preferred $SHELL
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/fish";
  };

  home.packages = stable-packages ++ unstable-packages ++
    # FIXME: you can add anything else that doesn't fit into the above two lists in here
    [
      # pkgs.some-package
      # pkgs.unstable.some-other-package
    ];

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;

    # FIXME: disable this if you don't want to use the starship prompt
    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = true;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      # python.disabled = true;
      # ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };

    tmux = {
      enable = true;
      clock24 = true;

      extraConfig = ''
        # remap prefix from 'C-b' to 'C-a'
        unbind C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # reload config file (change file location to the tmux.conf you want to use)
        bind r source-file ~/.tmux.conf

        # switch panes using vim mappings
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r l select-pane -R
        bind -r j select-pane -L

        # Enable mouse control (clickable windows, panes, resizable panes)
        set -g mouse on

        # don't rename windows automatically
        # set-option -g allow-rename off

        # DESIGN TWEAKS

        # enable 256 color support
        set -g default-terminal 'screen-256color'

        # enable true color supoort
        set -ga terminal-orverrides ',xterm-256color:Tc'

        # don't do anything when a 'bell' rings
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        # clock mode
        setw -g clock-mode-colour yellow

        # copy mode
        setw -g mode-style 'fg=black bg=red bold'

        # panes
        set -g pane-border-style 'fg=red'
        set -g pane-active-border-style 'fg=yellow'

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'fg=red'

        set -g status-left '\'
        set -g status-left-length 10

        set -g status-right-style 'fg=black bg=yellow'
        set -g status-right '%Y-%m-%d %H:%M '
        set -g status-right-length 50

        setw -g window-status-current-style 'fg=black bg=red'
        setw -g window-status-current-format ' #I #W #F '

        setw -g window-status-style 'fg=red bg=black'
        setw -g window-status-format " #I #[fg=white]#W #[fg=yellow]#F "

        setw -g window-status-bell-style 'fg=yellow bg=red bold'

        # messages
        set -g message-style 'fg=yellow bg=red bold'
      '';
    };

    # FIXME: disable whatever you don't want
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

    helix = {
      enable = true;
      settings = {
        # theme = "tokyonight";
        theme = "base16_terminal";
        editor.line-number = "relative";
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
      themes.base16_terminal = {
        "ui.background" = { fg = "foreground"; };
        "ui.cursor" = {
          fg = "background";
          bg = "blue";
          modifiers = [ "dim" ];
        };
        "ui.cursor.match" = {
          fg = "green";
          modifiers = [ "underlined" ];
        };
        "ui.selection" = { bg = "secondary_highlight"; };
      };
    };

    git = {
      enable = true;
      package = pkgs.unstable.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "elias06wennerlund@gmail.com";
      userName = "Elias Wennerlund";
      extraConfig = {
        # FIXME: uncomment the next lines if you wantt o be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@github.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = { conflictstyle = "diff3"; };
        diff = { colorMoved = "default"; };
      };
    };

    # FIXME: This is my fish config - you can fiddle with it if you want
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

        ${pkgs.lib.strings.fileContents (pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92";
          sha256 = "sha256-f/CUR0vhMJ1sZgztmVTPvmsAgp0kjFov843Mabdzvqo=";
        } + "/extras/kanagawa.fish")}

        set -U fish_greeting

        set -Ux COLORTERM truecolor

        # FIXME: run 'scoop install win32yank' on Windows, then add this line with your Windows username to the bottom of interactiveShellInit
        # FIXME: update windows username
        fish_add_path --append /mnt/c/Users/elias/scoop/apps/win32yank/0.1.1
      '';
      functions = {
        refresh = "source $HOME/.config/fish/config.fish";
        take = ''mkdir -p -- "$1" && cd -- "$1"'';
        ttake = "cd $(mktemp -d)";
        # show_path = "echo $PATH | tr ' '\n'";
        posix-source = ''
          for i in (cat $argv)
            set arr (echo $i |tr = \n)
            set -gx $arr[1] $arr[2]
          end
        '';
      };
      shellAbbrs = {
        gc = "nix-collect-garbage --delete-old";
      }
      # navigation shortcuts
        // {
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
        }
        # git shortcuts
        // {
          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";
          gsp = "git stash push -m";
          gsa = "git stash apply stash^{/";
          gsl = "git stash list";
        };
      shellAliases = {
        explorer = "/mnt/c/Windows/explorer.exe";

        # To use code as the command, uncomment the line below. Be sure to replace [my-user] with your username.
        # If your code binary is located elsewhere, adjust the path as needed.
        # code = "/mnt/c/Users/[my-user]/AppData/Local/Programs/'Microsoft VS Code'/bin/code";
      };
      plugins = [
        {
          inherit (pkgs.fishPlugins.autopair) src;
          name = "autopair";
        }
        {
          inherit (pkgs.fishPlugins.done) src;
          name = "done";
        }
        {
          inherit (pkgs.fishPlugins.sponge) src;
          name = "sponge";
        }
      ];
    };
  };
}
