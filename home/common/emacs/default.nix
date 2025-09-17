{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hunspell
    hunspellDicts.en_GB-ise
    nerd-fonts.jetbrains-mono
  ];

  home.file.".emacs.d/early-init.el".source = ./early-init.el;
  home.file.".emacs.d/init.el".source = ./init.el;
  home.file.".emacs.d/snippets".source = ./snippets;

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;

    extraConfig = ''
      (setenv "DICPATH" (expand-file-name "${pkgs.hunspellDicts.en_GB-ise}/share/hunspell"))
    '';

    extraPackages = epkgs:
      with epkgs; [
        doom-themes
        olivetti

        nix-mode
        nix-ts-mode
        svelte-mode
        treesit-grammars.with-all-grammars
        treesit-auto

        cape
        consult
        corfu
        envrc
        exec-path-from-shell
        git-auto-commit-mode
        magit
        marginalia
        multiple-cursors
        nov
        pdf-tools
        orderless
        vterm
        which-key
        yasnippet
        yasnippet-capf
        vertico
      ];
  };
}
