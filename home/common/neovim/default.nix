{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fd
    gcc
    go
    nodejs_22
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    withNodeJs = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim;
}
