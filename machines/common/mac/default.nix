{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = ["nix-command" "flakes"];
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
      static-only = true;
    };
    NSGlobalDomain = {
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.swipescrolldirection" = false;
    };
  };

  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
