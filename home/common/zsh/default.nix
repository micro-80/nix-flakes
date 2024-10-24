{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python312
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      osUpdate = "sudo nixos-rebuild switch --flake .#";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = builtins.readFile ./config.zsh;

    plugins = [
      {
        name = pkgs.zsh-git-prompt.pname;
        src = pkgs.zsh-git-prompt.src;
	file = "zshrc.sh";
      }
      {
        name = pkgs.zsh-nix-shell.pname;
        src = pkgs.zsh-nix-shell.src;
	file = "nix-shell.plugin.zsh";
      }
    ];
  };
}
