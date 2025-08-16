{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./neovim
  ];

  home.packages = with pkgs; [
    git
    gh
    jq
    nerd-fonts.inconsolata
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {TERM = "xterm-256color";};
        font = {
          size = 16.0;

          normal.family = "Inconsolata Nerd Font Mono";
          bold.family = "Inconsolata Nerd Font Mono";
          italic.family = "Inconsolata Nerd Font Mono";
        };
        general.import = [
          "${pkgs.alacritty-theme}/share/alacritty-theme/catppuccin_macchiato.toml"
        ];
        terminal.shell = {
          program = "${pkgs.tmux}/bin/tmux";
          args = [
            "new-session"
          ];
        };
        window = {
          option_as_alt = "OnlyLeft";
          startup_mode = "Maximized";
        };
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      baseIndex = 1;
      escapeTime = 10;
      historyLimit = 100000;
      mouse = true;
      prefix = "C-a";

      extraConfig = ''
               set-environment -g PATH "${pkgs.tmux}/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/user/bin:/run/current-system/sw/bin"

               set -as terminal-overrides ',xterm-256color:Tc'
               set -as terminal-overrides ',tmux-256color:Tc'
               set -g @catppuccin_flavor 'macchiato'
        set -g @catppuccin_window_text " #{pane_current_command}"
               set -g @catppuccin_window_current_text " #{pane_current_command}"

        run-shell "${pkgs.tmuxPlugins.better-mouse-mode}/share/tmux-plugins/better-mouse-mode/scroll_copy_mode.tmux"
               run-shell "${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux"
        source-file "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_options_tmux.conf"
               source-file "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_tmux.conf"

               set-option -g set-clipboard on
               set-window-option -g mode-keys vi
               bind-key -T copy-mode-vi v send-keys -X begin-selection
               bind-key -T copy-mode-vi h send-keys -X cursor-left
               bind-key -T copy-mode-vi j send-keys -X cursor-down
               bind-key -T copy-mode-vi k send-keys -X cursor-up
               bind-key -T copy-mode-vi l send-keys -X cursor-right
               bind-key -T copy-mode-vi y send-keys -X copy-selection

               bind-key -n M-! select-window -t 1
               bind-key -n M-@ select-window -t 2
               bind-key -n M-# select-window -t 3
               bind-key -n M-$ select-window -t 4
               bind-key -n M-% select-window -t 5
               bind-key -n M-^ select-window -t 6
               bind-key -n M-& select-window -t 7
               bind-key -n M-* select-window -t 8
               bind-key -n M-( select-window -t 9
               bind-key -n M-) select-window -t 0
      '';
    };
  };
}
