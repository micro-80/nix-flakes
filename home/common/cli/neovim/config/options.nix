{...}: {
  programs.nixvim.opts = {
    incsearch = true;
    number = true;
    relativenumber = true;
    showcmd = true;

    signcolumn = "number";
    cmdheight = 1;
    wildmenu = true;

    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
  };
}
