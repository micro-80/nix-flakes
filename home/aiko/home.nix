{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/cli/linux.nix
    ../common/emacs
    ../common/linux.nix
    ../common/packages.nix
  ];
  home.username = "user";
  home.homeDirectory = "/home/user";

  programs.fish.shellAliases = {
    syncthing-gui = "${pkgs.firefox}/bin/firefox -private-window http://localhost:8384";
  };

  programs.swaylock.enable = true;
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 0.2";
      }
    ];
  };

  home.packages = with pkgs; [brightnessctl];
  services.gnome-keyring.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        {command = "${pkgs.avizo}/bin/avizo-service";}
        {command = "emacs";}
      ];
      assigns = {
        "1" = [{app_id = "alacritty";}];
        "2" = [{app_id = "firefox";}];
        "3" = [{app_id = "emacs";}];
      };
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "XF86MonBrightnessUp" = "exec ${pkgs.avizo}/bin/lightctl up";
          "XF86MonBrightnessDown" = "exec ${pkgs.avizo}/bin/lightctl down";
          "XF86AudioRaiseVolume" = "exec ${pkgs.avizo}/bin/volumectl -u up";
          "XF86AudioLowerVolume" = "exec ${pkgs.avizo}/bin/volumectl -u down";
          "XF86AudioMute" = "exec ${pkgs.avizo}/bin/volumectl toggle-mute";
        };
      input = {
        "type:touchpad" = {
          tap = "enabled";
        };
      };
      output = {
        eDP-1 = {
          scale = "1.0";
        };
      };
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
