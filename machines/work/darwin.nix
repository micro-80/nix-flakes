{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/mac
  ];

  environment.darwinConfig = "$HOME/.flakes/machines/work";

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

  system.primaryUser = "mgn25";
  users.users.mgn25 = {
    name = "mgn25";
    home = "/Users/mgn25";
  };
}
