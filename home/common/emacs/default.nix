{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  home.file.".emacs.d/early-init.el".source = ./early-init.el;
  home.file.".emacs.d/init.el".source = ./init.el;

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;

    extraPackages = epkgs: with epkgs; [
      nix-mode
      nix-ts-mode
      svelte-mode
      
      treesit-grammars.with-all-grammars
      treesit-auto
      
      which-key
    ];
  };
}
