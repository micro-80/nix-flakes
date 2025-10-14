{
  description = "micro80 NixOS flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # TODO: clean up duplication
    nixosConfigurations = {
      aiko-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./machines/aiko-server/configuration.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel

          {
            nix.nixPath = ["nixpkgs=${nixpkgs}"];
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./home/aiko-server/home.nix;
          }
        ];
      };
    };
  };
}
