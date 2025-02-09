{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];
  boot.kernelParams = ["quiet" "splash"];
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/mnt/Secondary" = {
    device = "/dev/disk/by-uuid/8c90e68f-97a2-4c14-beae-5336580091a8";
    fsType = "ext4";
  };

  fileSystems."/mnt/Others" = {
    device = "/dev/disk/by-uuid/46f52cad-7ff3-41aa-ae67-f1fd344784b7";
    fsType = "ext4";
  };

  networking.hostName = "leon";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # VSCode wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system.stateVersion = "24.11";
}
