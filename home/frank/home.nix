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

  home.activation.copyPicardRemote = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Applications"
    rm -rf "$HOME/Applications/PicardRemote.app"
    cp -R "${./PicardRemote.app}" "$HOME/Applications/PicardRemote.app"
  '';

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
