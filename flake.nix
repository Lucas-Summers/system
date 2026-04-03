{
  description = "Lucas's nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      ...
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#m5
      darwinConfigurations."m5" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.home-manager.darwinModules.default
          inputs.agenix.darwinModules.default
          ./modules/mac.nix
          ./modules/nix.nix
          ./modules/user.nix
          ./modules/wm.nix
          ./modules/brew.nix
        ];
      };
    };
}
