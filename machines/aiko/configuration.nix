{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [
    "resume=LABEL=swap"
    "quiet"
    "splash"
  ];
  hardware.cpu.intel.updateMicrocode = true;

  services.logind.lidSwitch = "suspend-then-hibernate";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=45min
  '';

  networking.hostName = "aiko";

  # framework laptop-specific stuff
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = ["lvfs-testing"];
  services.fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;

  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.tlp.enable = true;

  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-maps
    gnome-music
    gnome-tour
    gnome-connections
  ];
}
