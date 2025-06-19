{
  programs.nixvim = {
    extraFiles = {
      "lua/work-note.lua".text = builtins.readFile ./lua/work-note.lua;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>wn";
        action = ":lua require('work-note').create_work_note()<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fwn"; # notes find files
        action = ":lua require('work-note').find_notes_files()<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gwn"; # notes live grep
        action = ":lua require('work-note').grep_notes_files()<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
