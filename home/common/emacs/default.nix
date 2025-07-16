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
    extraConfig = builtins.readFile ./init.el;

    extraPackages = epkgs: [
      epkgs.corfu
      epkgs.envrc
      epkgs.evil
      epkgs.evil-collection
      epkgs.exec-path-from-shell
      epkgs.flymake
      epkgs.go-mode
      epkgs.magit
      epkgs.orderless
      epkgs.vertico
      epkgs.which-key
    ];
  };
}
