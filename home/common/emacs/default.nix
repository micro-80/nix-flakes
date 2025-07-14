{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile ./init.el;

    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-collection
      epkgs.orderless
      epkgs.vertico
      epkgs.which-key
    ];
  };
}
