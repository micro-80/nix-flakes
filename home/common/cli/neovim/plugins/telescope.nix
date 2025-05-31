{pkgs, ...}: {
  home.packages = with pkgs; [ripgrep];
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    telescope = {
      enable = true;
      settings.defaults.mappings = {
        i = {
          "<esc>".__raw = "require('telescope.actions').close";
          "<C-j>".__raw = "require('telescope.actions').move_selection_next";
          "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
        };
      };
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
      };
    };
  };
}
