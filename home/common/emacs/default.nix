{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tree-sitter
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        cape
        catppuccin-theme
        consult
        corfu
        evil
        evil-collection
        evil-surround
        evil-commentary
        flycheck
        git-auto-commit-mode
        magit
        marginalia
        orderless
        treesit-auto
        treesit-grammars.with-all-grammars
        which-key
        vertico
        vterm
      ];
  };

  xdg.configFile."emacs/init.el".source = ./init.el;
}
