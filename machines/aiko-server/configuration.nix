# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aiko-server"; # Define your hostname.
  networking.networkmanager.enable = true;
  systemd.network.wait-online.enable = true;

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = ["docker" "networkmanager" "wheel"];
    packages = with pkgs; [picard];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--metrics-addr 127.0.0.1:9323 --experimental";

  networking.firewall.enable = false;

  hardware.intel-gpu-tools.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel # Intel VA-API driver
      vulkan-loader
      libva-utils
    ];
  };

  # ZFS
  boot.supportedFilesystems = ["zfs"];
  boot.zfs = {
    extraPools = ["pool"];
    forceImportAll = true;
    devNodes = "/dev/disk/by-id";
  };
  networking.hostId = "6285cbaa";
  services.zfs.autoScrub.enable = true;

  # Pangolin
  services.newt = {
    enable = true;
    environmentFile = "/home/user/newt-env";
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "0.0.0.0";
        # and Port
        http_port = 9000;
        # Grafana needs to know on which domain and URL it's running
        # domain = "your.domain";
        # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
        # serve_from_sub_path = true;
      };
    };
  };

  services.prometheus = {
    enable = true;
    port = 9001;
    globalConfig.scrape_interval = "10s"; # "1m"
    scrapeConfigs = [
      {
        job_name = "docker";
        static_configs = [
        {targets = ["localhost:9323"];}
        ];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
    ];

    exporters = {
      node = {
        enable = true;
        # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
        enabledCollectors = ["systemd"];
        # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
        #extraFlags = [ "--collector.ethtool" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
