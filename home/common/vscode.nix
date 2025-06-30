{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "sql-developer";
          publisher = "Oracle";
          version = "25.1.1";
          sha256 = "1piqsg56glhg87zj8f7il13p73f4djkvr8gvni80ym5xpvky1ks9";
        }
      ];

      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "sqldeveloper.sqlHistory.historyLimit" = 1000;
      };
    };
  };
}
