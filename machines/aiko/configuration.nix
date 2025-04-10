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

  security.pam.services.swaylock = {};
  security.polkit.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  services.syncthing = {
    enable = true;
    dataDir = "/home/user/Documents";
    configDir = "/home/user/.config/syncthing";
    user = "user";
    group = "users";
    guiAddress = "0.0.0.0:8384";
  };
}
