{pkgs, ...}: {
  environment.packages = [pkgs.cowsay];
  system.stateVersion = "25.11";
}
