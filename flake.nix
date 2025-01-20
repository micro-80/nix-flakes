{
  description = "prophetarmed NixOS flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    home-manager,
    nix-darwin,
    plasma-manager,
    ...
  }: {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # TODO: clean up duplication
    nixosConfigurations = {
      aiko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./machines/aiko/configuration.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel

          {
            nix.nixPath = ["nixpkgs=${nixpkgs}"];
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
            home-manager.users.user = import ./home/aiko/home.nix;
          }
        ];
      };
      leon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./machines/leon/configuration.nix

          {
            nix.nixPath = ["nixpkgs=${nixpkgs}"];
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./home/leon/home.nix;
          }
        ];
      };
    };

    darwinConfigurations = {
      "UKR4C7RQ747H" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {inherit inputs;};
        modules = [
          ./machines/work/darwin.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mgn25 = import ./home/work/home.nix;
          }
        ];
      };
    };
  };
}
