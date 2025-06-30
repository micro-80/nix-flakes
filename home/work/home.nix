{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common/mac
  ];

  home.sessionPath = [
    "$HOME/bin"
  ];

  home.packages = with pkgs; [
    bash
    colima
    crane
    docker
    gauge
    kubectl
    kubectx
    maven
    sbt
    scala_2_13
  ];

  programs.fish = {
    plugins = [
      {
        name = "fish-kube-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "aluxian";
          repo = "fish-kube-prompt";
          rev = "bbb2c4bc511970b60df51bfbfb2289f6161b489b";
          sha256 = "sha256-/ZdG0oAA6MUCjsFv+CeqCZQJq0AIS02+H2dliykn71s=";
        };
      }
    ];
  };

  programs.ssh = {
    matchBlocks = {
      "github-work" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
        user = "mylesgordon";
      };
      "github-personal" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_prophetarmed";
        user = "prophetarmed";
      };
    };
    includes = [
      "/Users/mgn25/.colima/ssh_config"
    ];
  };

  programs.vscode.profiles.default.userSettings = {
    "sqldeveloper.connections.tnsConfiguration.path" = "/Users/mgn25/Code";
  };

  programs.zsh = {
    shellAliases = {
      kubeShowVersions = "kubectl get deployment -o json | jq '.items[].metadata.labels | .\"app.kubernetes.io/instance\" + \" - \" + .\"app.kubernetes.io/version\"'";
    };
  };
}
