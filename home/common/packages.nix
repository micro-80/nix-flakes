{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    fastfetch
    spotify
  ];
}
