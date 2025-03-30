{...}: {
  programs.nixvim = {
    extraConfigLua = ''
           function InsertDailyNoteTemplate()
             local current_date = os.date("%Y-%m-%d")
             local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local text = string.format("* Daily Note - <%s>", current_date)
             vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {text})
      vim.api.nvim_buf_set_lines(0, row, row, false, {"", ""})  -- Inserts 2 blank lines
             vim.api.nvim_input("<Esc>")
           end
    '';
    keymaps = [
      {
        key = "<leader>td";
        action = ":lua InsertDailyNoteTemplate()<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>od";
        action = ":e ~/Documents/Org/daily.org<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>on";
        action = ":e ~/Documents/Org/notes.org<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
    ];

    plugins.orgmode = {
      enable = true;
      settings = {
        org_agenda_files = "~/Documents/Org/**/*";
        org_default_notes_file = "~/Documents/Org/daily.org";
      };
    };
  };
}
