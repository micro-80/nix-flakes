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

    prismlauncher
    obsidian
    vesktop
  ];

  programs = {
    firefox.enable = true;
  };

  xdg.desktopEntries = {
    cider = {
      name = "Cider";
      genericName = "Apple Music Client";
      exec = "${pkgs.appimage-run}/bin/appimage-run /home/user/.local/bin/Cider.AppImage %U";
      terminal = false;
    };
  };
}
