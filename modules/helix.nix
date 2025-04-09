{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "custom_blue";
      editor = {
        line-number = "relative";
        end-of-line-diagnostics = "warning";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        clipboard-provider = "win32-yank";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }
      {
        name = "html";
        scope = "text.html.basic";
        file-types = [ "html" "erb" ];
        auto-format = true;
        language-servers = [
          "vscode-langservers-extracted"
          "emmet-ls"
          "tailwindcss-language-server"
        ];
      }
      {
        name = "ruby";
        scope = "source.ruby";
        file-types = [ "rb" "rake" "ru" ];
        language-servers = [ "ruby-lsp" ];
        formatter = {
          command = "${pkgs.rufo}/bin/rufo";
          args = [ ];
        };
        auto-format = true;
      }
      {
        name = "erb";
        scope = "text.html.erb";
        file-types = [ "erb" ];
        injection-regex = ".*\\.erb";
        roots = [ "Gemfile" ];
        auto-format = true;
        language-servers = [
          "ruby-lsp"
          "vscode-langservers-extracted"
          "emmet-ls"
          "tailwindcss-language-server"
        ];
        formatter = {
          command = "${pkgs.rubyPackages.erb-formatter}/bin&/erb-format";
          args = [ "--stdin" ];
        };
      }
    ];
    languages.language-server = {
      ruby-lsp = {
        command = "ruby-lsp";
        args = [ ];
      };
      tailwindcss-language-server = {
        command = "tailwindcss-language-server";
        args = [ "--stdio" ];
      };
      emmet-ls = {
        command = "emmet-ls";
        args = [ ];
      };
    };
    themes = {
      custom_blue = let
        # colors gathered from wallpaper
        blue1 = "#11326A";
        blue2 = "#102967";
        blue3 = "#0D255C";
        blue4 = "#3F6BAB";
        blue5 = "#02051A";
        blue6 = "#06123A";
      in {
        inherits = "tokyonight";
        "ui.background" = { fg = "fg"; };
        "ui.selection" = { bg = "bg_highlight"; };
        "ui.text" = { fg = "fg"; };
        comment = {
          fg = "comment";
          modifiers = [ ];
        };
        "diagnostic.warning" = {
          underline = {
            style = "curl";
            color = "orange";
          };
        };
        "ui.statusline" = {
          bg = blue5;
          fg = "#d1d7fc";
        };
        "ui.statusline.inactive" = {
          bg = blue5;
          fg = "#a9b1d6";
        };
        "ui.linenr" = { fg = "#6f8b9b"; };
        "ui.linenr.selected" = { fg = "#add6ed"; };
        "ui.menu" = {
          fg = "#d1d7fc";
          bg = blue5;
        };
      };
    };
  };
}
