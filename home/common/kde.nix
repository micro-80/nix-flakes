{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fish.interactiveShellInit = ''
    export SSH_ASKPASS_REQUIRE=prefer
    export SSH_ASKPASS=${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass
  '';

  programs.plasma = {
    enable = true;

    input.mice = [
      {
        accelerationProfile = "none";
        name = "Logitech G203 LIGHTSYNC Gaming Mouse";
        productId = "c092";
        vendorId = "046d";
      }
    ];

    kscreenlocker = {
      autoLock = false;
      passwordRequiredDelay = 0;
      timeout = 0;
    };

    kwin = {
      effects.desktopSwitching.animation = "off";
      virtualDesktops.number = 4;

      nightLight = {
        enable = true;
        location = {
          latitude = "53.58";
          longitude = "-0.69";
        };
        mode = "location";
	temperature.night = 3000;
      };
    };

    panels = [
      {
        location = "bottom";
        height = 44;
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake";
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            iconTasks = {
              launchers = [];
              appearance = {
                showTooltips = true;
                highlightWindows = true;
                indicateAudioStreams = true;
                fill = true;
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.pager"
          "org.kde.plasma.marginsseparator"
          {
            systemTray = {
              icons.scaleToFit = true;
              items = {
                shown = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.networkmanagement"
                ];
                hidden = [
                  "org.kde.plasma.clipboard"
                ];
              };
            };
          }
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    shortcuts = {
      "org.kde.krunner.desktop" = {
        "_launch" = "Meta+D";
      };
      "org.kde.spectacle.desktop" = {
        "_launch" = "none";
        "RectangularRegionScreenShot" = "Print";
      };
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";

        # remapped to launch krunner
        "Show Desktop" = "none";
      };
      plasmashell = {
        # remapped to "switch to desktop"
        "activate task manager entry 1" = "none";
        "activate task manager entry 2" = "none";
        "activate task manager entry 3" = "none";
        "activate task manager entry 4" = "none";
      };
    };
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
  };
}
