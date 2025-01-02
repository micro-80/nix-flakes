{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/cli
    ../common/packages.nix
  ];
  home.username = "mgn25";
  home.homeDirectory = "/Users/mgn25";

  home.packages = with pkgs; [
    bruno
    colima
    gauge
    kubectl
    kubectx
    maven
    sbt
    scala_2_13
  ];

  programs.ssh = {
    matchBlocks = {
      "github-work-test" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
        user = "Myles-Gordon-5nm_nbcuni";
      };
      "github-work" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
        user = "Myles-Gordon-5nm_nbcuni";
      };
      "github-personal" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519-prophetarmed";
        user = "prophetarmed";
      };
    };
    includes = [
      "/Users/mgn25/.colima/ssh_config"
    ];
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
