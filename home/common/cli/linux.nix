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
      userName = "micro-80";
      userEmail = "me@micro80.com";
    };
  };
}
