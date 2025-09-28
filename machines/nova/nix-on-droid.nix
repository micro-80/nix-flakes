{pkgs, ...}: {
  environment.packages = [pkgs.cowsay];
  system.stateVersion = "24.05";
}
