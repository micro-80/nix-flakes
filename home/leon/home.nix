{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/cli/linux.nix
    ../common/linux.nix
    ../common/packages.nix
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["Hack Nerd Font Mono"];
      sansSerif = ["Noto Sans"];
      serif = ["Noto Serif"];
    };
  };

  home.packages = with pkgs; [
    bottles
    evince
    htop
    mate.caja
    mate.eom
    mpv
    rpcs3
    obs-studio
    pavucontrol
    prismlauncher
    seahorse
    unzip
    wireguard-tools
    wl-clipboard
  ];

  programs = {
    i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [
            {
              block = "music";
              format = "{ $combo.str(max_w:50,rot_interval:0.5) |}";
            }
            {
              block = "sound";
              device_kind = "source";
            }
            {
              block = "sound";
            }
            {
              block = "time";
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              interval = 60;
            }
          ];
        };
      };
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = ./catppuccin-macchiato.rasi;
      extraConfig = {
        show-icons = true;
        drun-display-format = "{icon} {name}";
      };
    };
  };

  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = {
      menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      modifier = "Mod4";
      terminal = "alacritty";

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
      };
      output = {
        DP-3 = {
          allow_tearing = "yes";
          adaptive_sync = "on";
        };
      };
      startup = [
        {command = "${pkgs.autotiling-rs}/bin/autotiling-rs";}
      ];
      window.commands = [
        {
          command = "floating enable, sticky enable";
          criteria = {
            app_id = "firefox";
            title = "^Picture-in-Picture$";
          };
        }
      ];

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        rofi = "${pkgs.rofi-wayland}/bin/rofi";
        wireplumber = "${pkgs.wireplumber}/bin/wpctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in
        lib.mkOptionDefault {
          # TODO: fix below, not working
          #"${modifier}+c" = "exec ${rofi} -show calc -modi calc -no-show-match -no-sort";
          "${modifier}+e" = "exec ${pkgs.rofimoji}/bin/rofimoji";
          "${modifier}+p" = "exec ${rofi} -show p -modi p:'${pkgs.rofi-power-menu}/bin/rofi-power-menu'";
          "${modifier}+Shift+s" = "sticky toggle";
          "Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
          #"XF86MonBrightnessDown" = "exec 'light -U 15'";
          #"XF86MonBrightnessUp" = "exec 'light -A 15'";
          "XF86AudioRaiseVolume" = "exec '${wireplumber} set-volume @DEFAULT_AUDIO_SINK@ 5%+'";
          "XF86AudioLowerVolume" = "exec '${wireplumber} set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
          "XF86AudioMute" = "exec '${wireplumber} set-mute @DEFAULT_AUDIO_SINK@ toggle'";
          "XF86AudioPlay" = "exec '${playerctl} play-pause'";
          "XF86AudioNext" = "exec '${playerctl} next'";
          "XF86AudioPrev" = "exec '${playerctl} previous'";
        };
    };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1

      eval $(gnome-keyring-daemon --start)
      export SSH_AUTH_SOCK
    '';
  };

  # TODO: remove duplication
  xdg.desktopEntries = {
    cider = {
      name = "Cider";
      genericName = "Apple Music Client";
      exec = "${pkgs.appimage-run}/bin/appimage-run /mnt/Secondary/Programs/Cider.AppImage %U";
      terminal = false;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
