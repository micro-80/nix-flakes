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
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  # TODO: remove duplication
  xdg.desktopEntries = {
    cider = {
      name = "Cider";
      genericName = "Apple Music Client";
      exec = "${pkgs.appimage-run}/bin/appimage-run /home/user/.local/bin/Cider.AppImage %U";
      terminal = false;
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
