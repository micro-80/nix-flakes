{pkgs, ...}: {
  imports = [
    ./bufferline.nix
    ./catppuccin.nix
    ./cmp.nix
    ./lsp.nix
    ./orgmode.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
