{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./lsp.nix
  ];

  services.emacs.enable = true;

  home.packages = with pkgs; [hunspell hunspellDicts.en_GB-ise];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs:
      (with epkgs.elpaPackages; [
        use-package
      ])
      ++ (with epkgs.melpaPackages; [
        cape
        catppuccin-theme
        consult
        corfu
        envrc
        evil
        evil-collection
        flycheck
        jinx
        magit
        marginalia
        lsp-java
        lsp-mode
        lsp-ui
        orderless
        org-bullets
        org-pdftools
        pdf-tools
        pdf-view-restore
        treesit-auto
        vertico
        vterm
      ])
      ++ (with epkgs; [
        treesit-grammars.with-all-grammars
      ]);
    extraConfig = builtins.readFile ./init.el;
  };
}
