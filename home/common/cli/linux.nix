{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
  ];

  programs = {
    git = {
      enable = true;
      userName = "prophetarmed";
      userEmail = "me@prophetarmed.com";
    };
  };
}
