{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        golang.go
        mkhl.direnv
        vscodevim.vim
      ];
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      userSettings = {
        workbench.colorTheme = "Catppuccin Macchiato";
        workbench.iconTheme = "catppuccin-macchiato";
      };
    };
  };
}
