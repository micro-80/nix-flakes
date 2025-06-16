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

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/wm/preferences".num-workspaces = 4;

      "org/gnome/shell/keybindings" = {
        "toggle-application-view" = [];
      };
      "org/gnome/desktop/wm/keybindings" = {
        "switch-to-workspace-1" = ["<Super>1"];
        "switch-to-workspace-2" = ["<Super>2"];
        "switch-to-workspace-3" = ["<Super>3"];
        "switch-to-workspace-4" = ["<Super>4"];
        "switch-to-workspace-5" = ["<Super>5"];
        "switch-to-workspace-6" = ["<Super>6"];
        "switch-to-workspace-7" = ["<Super>7"];
        "switch-to-workspace-8" = ["<Super>8"];
        "switch-to-workspace-9" = ["<Super>9"];

        "move-to-workspace-1" = ["<Super><Shift>1"];
        "move-to-workspace-2" = ["<Super><Shift>2"];
        "move-to-workspace-3" = ["<Super><Shift>3"];
        "move-to-workspace-4" = ["<Super><Shift>4"];
        "move-to-workspace-5" = ["<Super><Shift>5"];
        "move-to-workspace-6" = ["<Super><Shift>6"];
        "move-to-workspace-7" = ["<Super><Shift>7"];
        "move-to-workspace-8" = ["<Super><Shift>8"];
        "move-to-workspace-9" = ["<Super><Shift>9"];
      };

      "org/gnome/desktop/wm/preferences" = {
        "dynamic-workspaces" = false;
      };

      "org/gnome/desktop/interface" = {
        "enable-hot-corners" = false;
      };

      "org/gnome/settings-daemon/peripherals/keyboard" = {
        "ambient-light-sensor-enabled" = false;
      };
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
