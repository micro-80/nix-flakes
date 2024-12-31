# home.nix

{ config, pkgs, ... }:

{
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;
}

