{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/cli/linux.nix
    ../common/code.nix
    ../common/kde.nix
    ../common/linux.nix
    ../common/packages.nix
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
    prismlauncher
    ungoogled-chromium
    unzip
    wl-clipboard
    vesktop
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
