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

  home.packages = with pkgs; [man-pages xquartz];

  home.activation.copyPicardRemote = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/Applications"
    chmod -R u+w "$HOME/Applications/PicardRemote.app" || true
    rm -rf "$HOME/Applications/PicardRemote.app"
    cp -R "${./PicardRemote.app}" "$HOME/Applications/PicardRemote.app"
  '';

  programs.aerospace = {
    userSettings.workspace-to-monitor-force-assignment = {
      "10" = "Built-in Retina Display";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      aiko-server = {
        hostname = "192.168.0.100";
        user = "user";
        forwardX11 = true;
      };
      tunnel = {
        hostname = "178.128.167.42";
        user = "user";
      };
    };
  };
}
