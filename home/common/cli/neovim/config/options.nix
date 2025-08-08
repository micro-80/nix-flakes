{...}: {
  programs.nixvim.opts = {
    clipboard = "unnamedplus";
    incsearch = true;
    number = true;
    showcmd = true;
    termguicolors = true;

    signcolumn = "number";
    cmdheight = 1;
    wildmenu = true;

    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };
}
