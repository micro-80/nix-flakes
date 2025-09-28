{pkgs, ...}: {
  environment.packages = with pkgs; [
    emacs
    git
  ];
  system.stateVersion = "24.05";

  android-integration = {
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };

  terminal.font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/JetBrainsMonoNerdFontMono-Regular.ttf";

  # catppuccin latte
  terminal.colors = {
    background = "#eff1f5"; # Base (latte)
    foreground = "#4c4f69"; # Text

    color0 = "#ccd0da"; # Surface0
    color8 = "#9ca0b0"; # Overlay0

    color1 = "#d20f39"; # Red
    color9 = "#e64553"; # Maroon

    color2 = "#40a02b"; # Green
    color10 = "#40a02b"; # (bright green same)

    color3 = "#df8e1d"; # Yellow
    color11 = "#df8e1d"; # (bright yellow same)

    color4 = "#1e66f5"; # Blue
    color12 = "#1e66f5"; # (bright blue same)

    color5 = "#ea76cb"; # Pink
    color13 = "#ea76cb"; # (bright pink same)

    color6 = "#179299"; # Teal
    color14 = "#179299"; # (bright teal same)

    color7 = "#5c5f77"; # Subtext1
    color15 = "#6c6f85"; # Subtext0
  };
}
