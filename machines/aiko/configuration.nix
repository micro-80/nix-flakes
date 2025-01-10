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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
}
