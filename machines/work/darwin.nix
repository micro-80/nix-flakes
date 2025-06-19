{
  config,
  pkgs,
  ...
}: {
  environment.darwinConfig = "$HOME/.flakes/machines/work";

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
      "keepassxc"
      "linearmouse"
      "nikitabobko/tap/aerospace"
      "intellij-idea"
      "postman"
      "temurin@11"
    ];
    taps = [
    ];
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.fish.enable = true;

  system.primaryUser = "mgn25";
  users.users.mgn25 = {
    name = "mgn25";
    home = "/Users/mgn25";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
