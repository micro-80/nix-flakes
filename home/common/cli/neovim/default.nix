{config, pkgs, ...}: {
  imports = [
    ./config
    ./plugins
    ./templates
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
