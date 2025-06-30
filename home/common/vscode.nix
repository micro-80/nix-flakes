{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      nix-vscode-extensions.Oracle.sql-developer
    ];
  };
}
