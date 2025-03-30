{...}: {
  programs.nixvim.plugins.bufferline = {
    enable = true;
  };
  programs.nixvim.keymaps = [
    {
      key = "<A-w>";
      action = ":lua require('bufferline.commands').unpin_and_close()";
      options.silent = true;
    }
    {
      key = "<A-m-j>";
      action = ":BufferLineMoveNext";
      options.silent = true;
    }
    {
      key = "<A-m-k>";
      action = ":BufferLineMovePrev";
      options.silent = true;
    }
    {
      key = "<A-p>";
      action = ":BufferLineTogglePin";
      options.silent = true;
    }

    {
      key = "<A-1>";
      action = ":BufferLineGoToBuffer 1<CR>";
      options.silent = true;
    }
    {
      key = "<A-2>";
      action = ":BufferLineGoToBuffer 2<CR>";
      options.silent = true;
    }
    {
      key = "<A-3>";
      action = ":BufferLineGoToBuffer 3<CR>";
      options.silent = true;
    }
    {
      key = "<A-4>";
      action = ":BufferLineGoToBuffer 4<CR>";
      options.silent = true;
    }
    {
      key = "<A-5>";
      action = ":BufferLineGoToBuffer 5<CR>";
      options.silent = true;
    }
    {
      key = "<A-6>";
      action = ":BufferLineGoToBuffer 6<CR>";
      options.silent = true;
    }
    {
      key = "<A-7>";
      action = ":BufferLineGoToBuffer 7<CR>";
      options.silent = true;
    }
    {
      key = "<A-8>";
      action = ":BufferLineGoToBuffer 8<CR>";
      options.silent = true;
    }
    {
      key = "<A-9>";
      action = ":BufferLineGoToBuffer 9<CR>";
      options.silent = true;
    }
    {
      key = "<A-0>";
      action = ":BufferLineGoToBuffer -1<CR>";
      options.silent = true;
    }
  ];
}
