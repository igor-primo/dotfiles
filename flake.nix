{
  description = "NixOS flake for managing my installations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."igor-iso" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration-iso.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.igor = import ./home.nix;
        }
      ];
    };

    nixosConfigurations."igor-nix" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.igor = import ./home.nix;
        }
      ];
    };
  };
}
