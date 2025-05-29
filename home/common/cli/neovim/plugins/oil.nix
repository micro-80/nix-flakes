{...}: {
  programs.nixvim.plugins.oil = {
    enable = true;
    settings = {
      defaultFileExplorer = true;
      bufOptions = {
        buflisted = false;
        bufhidden = "hide";
      };
    };
  };
}
