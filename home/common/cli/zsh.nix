{
  config,
  pkgs,
  ...
}: {
  programs.nix-your-shell.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      darwinRebuild = "sudo darwin-rebuild switch --flake .#";
      nixosRebuild = "sudo nixos-rebuild switch --flake .#";
      nixosUpdate = "sudo nixos-rebuild switch --recreate-lock-file --flake .";
    };

    initContent = ''
      ${builtins.readFile ./p10k.zsh}

      # History settings
      HISTSIZE=5000
      SAVEHIST=5000
      setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE NO_HIST_VERIFY

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
}
