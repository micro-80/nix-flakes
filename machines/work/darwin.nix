{
  config,
  pkgs,
  ...
}: {
  environment.darwinConfig = "$HOME/.flakes/machines/work";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
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
  };

  homebrew = {
    enable = true;
    global = {autoUpdate = false;};
    onActivation = {
      autoUpdate = false;
      upgrade = false;
    };

    brews = [
    ];
    casks = [
      "alacritty"
      "bruno"
      "linearmouse"
      "nikitabobko/tap/aerospace"
      "intellij-idea"
      "temurin@11"
    ];
    taps = [
    ];
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.fish.enable = true;

  users.users.mgn25 = {
    name = "mgn25";
    home = "/Users/mgn25";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
