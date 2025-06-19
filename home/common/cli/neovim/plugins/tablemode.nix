{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-table-mode
    ];

    # extraConfigVim = ''
    #   " Optional VimL config for table-mode
    #   let g:table_mode_corner = '|'
    # '';
  };
}
