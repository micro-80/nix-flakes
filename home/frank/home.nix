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

  home.packages = with pkgs; [man-pages whatsapp-for-mac xquartz];

  home.file."Applications/PicardRemote.app".source = ./PicardRemote.app;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      aiko-server = {
        hostname = "192.168.0.100";
        user = "user";
        forwardX11 = true;
      };
    };
  };
}
