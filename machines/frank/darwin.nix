{
  config,
  pkgs,
  ...
}: {
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
    ];
  };

  system.primaryUser = "user";
  users.users.user = {
    name = "user";
    home = "/Users/user";
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    yabai
    skhd
  ];

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      external_bar = "all:off";
      layout = "bsp";
    };
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa
    '';
  };

  services.skhd.enable = true;
  services.skhd.skhdConfig = ''
    # Switch to space with Ctrl + Number (1-9, 0 for 10)
    ctrl - 1 : yabai -m space --focus 1
    ctrl - 2 : yabai -m space --focus 2
    ctrl - 3 : yabai -m space --focus 3
    ctrl - 4 : yabai -m space --focus 4
    ctrl - 5 : yabai -m space --focus 5
    ctrl - 6 : yabai -m space --focus 6
    ctrl - 7 : yabai -m space --focus 7
    ctrl - 8 : yabai -m space --focus 8
    ctrl - 9 : yabai -m space --focus 9
    ctrl - 0 : yabai -m space --focus 10

    # Move focused window with Ctrl + Shift + Number (1-9, 0 for 10)
    ctrl + shift - 1 : yabai -m window --space 1
    ctrl + shift - 2 : yabai -m window --space 2
    ctrl + shift - 3 : yabai -m window --space 3
    ctrl + shift - 4 : yabai -m window --space 4
    ctrl + shift - 5 : yabai -m window --space 5
    ctrl + shift - 6 : yabai -m window --space 6
    ctrl + shift - 7 : yabai -m window --space 7
    ctrl + shift - 8 : yabai -m window --space 8
    ctrl + shift - 9 : yabai -m window --space 9
    ctrl + shift - 0 : yabai -m window --space 10

    # TIP:
    # Restart yabai and skhd after updating config:
    #   brew services restart yabai
    #   brew services restart skhd
    #
    # Alternatively, kill and start them manually.
  '';
}
