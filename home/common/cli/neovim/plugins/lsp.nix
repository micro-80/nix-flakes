{...}: {
  programs.nixvim.plugins.lsp = {
    enable = true;
    keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
        "<leader>A" = "code_action";
      };
      diagnostic = {
        "<leader>k" = "goto_prev";
        "<leader>j" = "goto_next";
      };
    };
    servers = {
      bashls = {
        enable = true;
      };
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };
}
