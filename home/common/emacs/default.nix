{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inconsolata
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraConfig = builtins.readFile ./init.el;

    extraPackages = epkgs: [
      epkgs.consult
      epkgs.corfu
      epkgs.envrc
      epkgs.evil
      epkgs.evil-collection
      epkgs.exec-path-from-shell
      epkgs.flymake
      epkgs.gruvbox-theme
      epkgs.go-mode
      epkgs.magit
      epkgs.marginalia
      epkgs.olivetti
      epkgs.orderless
      epkgs.pdf-tools
      epkgs.tree-sitter-langs
      epkgs.treesit-auto
      epkgs.vertico
      epkgs.vterm
      epkgs.which-key
    ];
  };
}
