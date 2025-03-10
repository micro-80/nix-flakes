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

      golang.go
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide

      # Misc
      mkhl.direnv
      vscodevim.vim
    ];

    userSettings = {
      "workbench.startupEditor" = "none";
      "chat.commandCenter.enabled" = false;

      # catpuccin
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "native";
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "Catppuccin Macchiato";

      # vim
      "vim.handleKeys" = {
        "<C-p>" = false;
        "<C-w>" = false;
      };

      # nix
      "nix.formatterPath" = "alejandra";
      "search.exclude" = {"**/.direnv" = true;};
    };
  };
}
