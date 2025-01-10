{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    obsidian
    vesktop
  ];

  programs = {
    firefox.enable = true;
  };
}
