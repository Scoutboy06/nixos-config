{ pkgs, config, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    baseIndex = 1;
    newSession = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.tokyo-night-tmux
      # tmuxPlugins.nord
      # tmuxPlugins.catppuccin
      # tmuxPlugins.sensible
      # tmuxPlugins.vim-tmux-navigator
      # tmuxPlugins.continuum
      # tmuxPlugins.resurrect
    ];

    extraConfig = ''
      # set -g default-terminal "xterm-256color"
      # set -ga terminal-overrides ",*256col*:Tc"
      # set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Transparent background
      set -g pane-active-border-style bg=color0
      set -g pane-border-style bg=color0
      set-window-option -g window-active-style bg=terminal
      set-window-option -g window-style bg=color0

      # Configure Tokyo Night theme
      set -g @tokyo-night-tmux_theme storm
      set -g @tokyo-night-tmux_transparent 1
      set -g @tokyo-night-tmux_show_datetime 1
      set -g @tokyo-night-tmux_date_format YMD
      set -g @tokyo-night-tmux_time_format 12H

      set -g mouse on
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      # bind c new-window -c "#{pane_current_path}"
    '';
  };
}
