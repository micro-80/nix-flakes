{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      # Looks
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Languages
      fill-labs.dependi
      rust-lang.rust-analyzer
      tamasfe.even-better-toml

      yzhang.markdown-all-in-one

      jnoortheen.nix-ide

      # Misc
      mkhl.direnv
      vscodevim.vim
    ];

    userSettings = {
      "nix.formatterPath" = "alejandra";
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "Catppuccin Macchiato";
    };
  };
}
