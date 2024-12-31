# home.nix

{ config, lib, pkgs, ... }:

{
  imports = [
    ../common/cli
    ../common/packages.nix
  ];
  home.username = "MGN25";
  home.homeDirectory = "/Users/MGN25";

  home.packages = with pkgs; [
    bruno
    colima
  ];

  programs.ssh.includes = [
    "/Users/MGN25/.colima/ssh_config"
  ];

  home.stateVersion = "24.05"; 
  programs.home-manager.enable = true;
}

