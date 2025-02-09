{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/cli/linux.nix
    ../common/linux.nix
    ../common/packages.nix

    ./kde.nix
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    bottles
    htop
    mpv
    rpcs3
    obs-studio
    pavucontrol
    unzip
    wl-clipboard
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
