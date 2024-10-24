{ config, pkgs, ... }:

{
  imports = [ 
    ../common/neovim 
    ../common/zsh
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Hack Nerd Font Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  home.packages = with pkgs; [
    # fonts
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    # sway
    grim
    slurp
    wl-clipboard
    mako
    
    # misc
    fastfetch
    pavucontrol
    seahorse
    unzip
    vesktop
  ];

  programs = {
    firefox.enable = true;
    alacritty = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "prophetarmed";
      userEmail = "me@prophetarmed.com";
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    zsh = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier =  "Mod4";
      terminal = "alacritty";

      output = {
        DP-3 = {
	  # NOTE: uncomment when Sway 1.10 released
	  #allow_tearing = "yes";
	  adaptive_sync = "on";
	};
      };
    };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1

      eval $(gnome-keyring-daemon --start)
      export SSH_AUTH_SOCK
    '';
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
