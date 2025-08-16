{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
