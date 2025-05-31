{pkgs, ...}: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings.theme = "catppuccin";
  };
}
