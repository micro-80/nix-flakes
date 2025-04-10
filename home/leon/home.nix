{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../kde.nix
    ../common/cli
    ../common/cli/linux.nix
    ../common/emacs
    ../common/linux.nix
    ../common/packages.nix
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  home.packages = with pkgs; [
    bottles
    eddie
    firefox
    htop
    mpv
    nicotine-plus
    rpcs3
    obs-studio
    pavucontrol
    picard
    prismlauncher
    protontricks
    qbittorrent
    steamtinkerlaunch
    ungoogled-chromium
    unrar
    unzip
    wl-clipboard
    vesktop
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
