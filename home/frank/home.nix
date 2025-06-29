{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/emacs
    ../common/packages.nix
  ];
  home.username = "user";
  home.homeDirectory = "/Users/user";

  home.packages = with pkgs; [obsidian whatsapp-for-mac];

  home.activation.symlinkNixApps = lib.hm.dag.entryAfter ["writeBoundary"] (
    builtins.readFile ./symlinkNixApps.sh
  );

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
