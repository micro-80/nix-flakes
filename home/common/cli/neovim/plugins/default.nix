{pkgs, ...}: {
  imports = [
    ./bufferline.nix
    ./catppuccin.nix
    ./cmp.nix
    ./gitsigns.nix
    ./lsp.nix
    ./lualine.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
