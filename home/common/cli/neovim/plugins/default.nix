{pkgs, ...}: {
  imports = [
    ./bufferline.nix
    ./catppuccin.nix
    ./cmp.nix
    ./lsp.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
