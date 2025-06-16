{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices."luks-44652c72-7e31-4b04-8095-5bdd8add98c3".device = "/dev/disk/by-uuid/44652c72-7e31-4b04-8095-5bdd8add98c3";
    resumeDevice = "/dev/disk/by-uuid/0f13a5dd-2a0e-4574-babe-571bab7b55b7";
    kernelParams = [
      "resume=UUID=0f13a5dd-2a0e-4574-babe-571bab7b55b7"
      "quiet"
      "splash"
    ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/0f13a5dd-2a0e-4574-babe-571bab7b55b7";
    }
  ];

  hardware.bluetooth.enable = false;
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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
