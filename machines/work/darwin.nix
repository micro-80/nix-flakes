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

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    # gnupg.agent.enable = true;
    zsh.enable = true; # default shell on catalina
  };

  system.defaults = {
    dock = {
      autohide = true;
      orientation = "right";
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

    brews = [];
    casks = [
      "linearmouse"
      "nikitabobko/tap/aerospace"
      "intellij-idea"
    ];
  };

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.MGN25 = {
    name = "MGN25";
    home = "/Users/MGN25";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
