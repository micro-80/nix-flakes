{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/mac
  ];
  home.username = "user";
  home.homeDirectory = "/Users/user";

  home.packages = with pkgs; [whatsapp-for-mac];
}
