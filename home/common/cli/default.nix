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
    gh
    jq
    nerd-fonts.hack
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        env = {TERM = "xterm-256color";};
        font = {
          size = 12.0;

          normal.family = "Hack Nerd Font Mono";
          bold.family = "Hack Nerd Font Mono";
          italic.family = "Hack Nerd Font Mono";
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
      terminal = "tmux-256color";
      baseIndex = 1;
      historyLimit = 100000;
      mouse = true;
      prefix = "C-a";

      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.catppuccin
        tmuxPlugins.yank
      ];

      extraConfig = ''
               set -gu default-command
               set -g default-shell "${pkgs.zsh}/bin/zsh"
               set -g allow-rename on

               set -as terminal-overrides ',xterm-256color:Tc'
               set -as terminal-overrides ',tmux-256color:Tc'
               set -g @catppuccin_flavor 'macchiato'

               set-option -g set-clipboard on
        set-window-option -g mode-keys vi
               # scroll up/down with j/k
               bind-key -T copy-mode-vi j send-keys -X page-up
               bind-key -T copy-mode-vi k send-keys -X page-down
               # v for selection y for yanking
               bind-key -T copy-mode-vi v send-keys -X begin-selection
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
