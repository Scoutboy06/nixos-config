{ config, pkgs, ... }: {
  programs.fish = {
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
      cl = "clear";
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
}
