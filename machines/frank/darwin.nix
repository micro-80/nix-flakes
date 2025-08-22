{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/mac
  ];

  environment.darwinConfig = "$HOME/.flakes/machines/frank";

  homebrew = {
    enable = true;
    global = {autoUpdate = false;};
    onActivation = {
      autoUpdate = false;
      upgrade = false;
    };

    casks = [
      "bitwig-studio"
      "pocket-casts"
      "obs"
    ];
  };

  system.primaryUser = "user";
  users.users.user = {
    name = "user";
    home = "/Users/user";
    shell = pkgs.zsh;
  };
}
