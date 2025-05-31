{...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    keymaps = [
      {
        key = "<A-w>";
        action = ":bd<CR>";
        options.silent = true;
      }
    ];
  };
}
