{
  config,
  pkgs,
  ...
}: {
  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      (with epkgs.elpaPackages; [
        use-package
      ])
      ++ (with epkgs.melpaPackages; [
        catppuccin-theme
        consult
        magit
        marginalia
        lsp-mode
        orderless
        org-bullets
        treesit-auto
        vertico
        vterm
      ])
      ++ (with epkgs.manualPackages; [
        treesit-grammars.with-all-grammars
      ]);
    extraConfig = builtins.readFile ./init.el;
  };
}
