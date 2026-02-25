{
  description = "Home Manager config (Fedora + flakes)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim.url = "github:igor-primo/nixvim";
    llm-agents.url = "github:numtide/llm-agents.nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, llm-agents, ... }:
    let
      system = "x86_64-linux"; # change if needed
      username = "igor";
    in
    {
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};

          modules = [
            ./home.nix
          ];

          extraSpecialArgs = {
            inherit inputs;
          };
        };
    };
}
