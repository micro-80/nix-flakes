{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../cli
    ../vscode.nix
  ];

  home.packages = with pkgs; [];

  home.activation.symlinkNixApps = lib.hm.dag.entryAfter ["writeBoundary"] (
    builtins.readFile ./symlinkNixApps.sh
  );

  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;

      mode.main.binding = {
        ctrl-h = "focus left";
        ctrl-j = "focus down";
        ctrl-k = "focus up";
        ctrl-l = "focus right";

        ctrl-shift-h = "move left";
        ctrl-shift-j = "move down";
        ctrl-shift-k = "move up";
        ctrl-shift-l = "move right";

        # ctrl-comma = "split horizontal";
        # ctrl-period = "split vertical";

        ctrl-shift-space = "layout floating tiling";

        ctrl-1 = "workspace 1";
        ctrl-2 = "workspace 2";
        ctrl-3 = "workspace 3";
        ctrl-4 = "workspace 4";
        ctrl-5 = "workspace 5";
        ctrl-6 = "workspace 6";
        ctrl-7 = "workspace 7";
        ctrl-8 = "workspace 8";
        ctrl-9 = "workspace 9";
        ctrl-0 = "workspace 10";

        ctrl-shift-1 = "move-node-to-workspace 1";
        ctrl-shift-2 = "move-node-to-workspace 2";
        ctrl-shift-3 = "move-node-to-workspace 3";
        ctrl-shift-4 = "move-node-to-workspace 4";
        ctrl-shift-5 = "move-node-to-workspace 5";
        ctrl-shift-6 = "move-node-to-workspace 6";
        ctrl-shift-7 = "move-node-to-workspace 7";
        ctrl-shift-8 = "move-node-to-workspace 8";
        ctrl-shift-9 = "move-node-to-workspace 9";
        ctrl-shift-0 = "move-node-to-workspace 10";

        ctrl-shift-c = "reload-config";

        ctrl-r = "mode resize";
      };
      mode.resize.binding = {
        h = "resize width -50";
        j = "resize height +50";
        k = "resize height -50";
        l = "resize width +50";
        enter = "mode main";
        esc = "mode main";
      };
      workspace-to-monitor-force-assignment = {
        "9" = "^DELL U2422H \\(1\\)$";
        "10" = ["^DELL U2422H \\(2\\)$" "^DELL U2422H$"];
      };
    };
  };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
