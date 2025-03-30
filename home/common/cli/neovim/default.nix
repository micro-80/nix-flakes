{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
