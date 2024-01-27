{ pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;

    disableConfirmationPrompt = true;

    escapeTime = 150;

    extraConfig = ''
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      set -s copy-command 'wl-copy'

      # when destroying a session switch to another one (don't exit)
      set -g detach-on-destroy off

      # in copy-mode press v to start highlighting
      bind -T copy-mode-vi v send -X begin-selection

      # in copy-mode press y to yank 
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'



      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      set-option -g status-position top
      # Nvim recommends this option
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ',xterm-kitty:RGB'

    '';

    historyLimit = 50000;

    keyMode = "vi";

    mouse = true;

    plugins =  with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        # Doesn't seem to work properly (But it's usable)
        extraConfig = ''
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "

          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "session"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
        '';
      }
    ];
  };
}
