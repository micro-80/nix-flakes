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
      bullets-vim
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      catppuccin-nvim
      gitsigns-nvim
      mini-nvim
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      render-markdown-nvim
      oil-nvim
      telescope-nvim
      vim-sleuth
      zen-mode-nvim
    ];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
  };
}
