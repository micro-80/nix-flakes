{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # for generating PDFs from Markdown
    pandoc
    tectonic
  ];

  programs = {
    git = {
      enable = true;
      userName = "prophetarmed";
      userEmail = "me@prophetarmed.com";
    };
  };
}
