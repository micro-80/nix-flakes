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
    git
    gauge
    kubectl
    kubectx
    maven
    sbt
    scala_2_13
  ];

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

  programs.vscode.profiles.default = {
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "sql-developer";
        publisher = "Oracle";
        version = "25.1.1";
        sha256 = "1piqsg56glhg87zj8f7il13p73f4djkvr8gvni80ym5xpvky1ks9";
      }
    ];

    userSettings = {
      sqldeveloper.sqlHistory.historyLimit = 1000;
      sqldeveloper.connections.tnsConfiguration.path = "/Users/mgn25/Code";
    };
  };

  programs.zsh = {
    shellAliases = {
      kubeShowVersions = "kubectl get deployment -o json | jq '.items[].metadata.labels | .\"app.kubernetes.io/instance\" + \" - \" + .\"app.kubernetes.io/version\"'";
    };
  };
}
