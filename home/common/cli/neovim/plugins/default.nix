{pkgs, ...}: {
  imports = [
    ./bufferline.nix
    ./catppuccin.nix
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
