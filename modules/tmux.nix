{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    baseIndex = 1;
    newSession = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.nord
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

        # Nord theme configuration
  set -g status-style bg=colour235,fg=colour255
  set -g message-style bg=colour235,fg=colour4
  set -g pane-border-style fg=colour235
  set -g pane-active-border-style fg=colour6
  set -g status-left-length 100
  set -g status-right-length 100
  set -g status-interval 5

  set -g status-left "#[fg=colour255,bg=colour235,bold] #S #[fg=colour235,bg=colour236,nobold,nounderscore,noitalics]"
  set -g status-right "#[fg=colour236,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour236] %H:%M  %d %b #[fg=colour240,bg=colour236,nobold,nounderscore,noitalics]#[fg=colour230,bg=colour240] #h "
  set -g status-justify centre
  set -g status-left-style none
  set -g status-right-style none
  set -g status-style none

  set-window-option -g window-status-current-format "#[fg=colour255,bg=colour236,bold] #I #[fg=colour255,bg=colour236,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour235] #W #[fg=colour236,bg=colour235,nobold,nounderscore,noitalics]"
  set-window-option -g window-status-format "#[fg=colour255,bg=colour235] #I #[fg=colour255,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour235] #W #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]"

      set -g mouse on
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
