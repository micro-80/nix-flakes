{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
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
          program = "${pkgs.bash}/bin/bash";
          args = [
            "-c"
            "${pkgs.tmux}/bin/tmux attach || ${pkgs.tmux}/bin/tmux"
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
      # enableFishIntegration = true;
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
      shell = "${pkgs.fish}/bin/fish";
      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.sensible
        tmuxPlugins.catppuccin
      ];
      extraConfig = ''
        set-option -sa terminal-overrides ",alacritty*:Tc"
        set -g @catppuccin_flavor 'macchiato'

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
