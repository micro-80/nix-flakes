{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../cli
    ../emacs
    ../packages.nix
    ../vscode.nix
  ];

  home.packages = with pkgs; [obsidian];

  home.activation.symlinkNixApps = lib.hm.dag.entryAfter ["writeBoundary"] (
    builtins.readFile ./symlinkNixApps.sh
  );

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
