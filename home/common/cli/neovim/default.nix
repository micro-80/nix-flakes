{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    stylua

    # plugin dependencies
    fd
    gcc
    nodejs_22
    ripgrep

    # lsp dependencies
    lua-language-server
    nodePackages.bash-language-server
    pyright
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
