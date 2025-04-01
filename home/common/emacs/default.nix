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
	evil
	evil-org
        magit
	marginalia
        lsp-mode
	vertico
      ]) ++ (with epkgs.manualPackages; [
        treesit-grammars.with-all-grammars
      ]);
    extraConfig = builtins.readFile ./init.el;
  };
}
