{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/emacs
  ];
  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";
  home.stateVersion = "24.05";
}
