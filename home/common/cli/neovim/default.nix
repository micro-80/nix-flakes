{
  config,
  pkgs,
  ...
}: {
  home.file.".config/nvim".source = ./config;
  home.packages = with pkgs; [ripgrep];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      catppuccin-nvim
      gitsigns-nvim
      mini-nvim
      nvim-cmp
      oil-nvim
      telescope-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
