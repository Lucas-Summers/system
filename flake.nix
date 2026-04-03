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
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      ...
    }:
    {
      darwinConfigurations."m5" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.home-manager.darwinModules.default
          inputs.agenix.darwinModules.default
          ./modules/m5.nix
          ./modules/nix.nix
          ./modules/user.nix
          ./modules/wm.nix
          ./modules/brew.nix
        ];
      };
      darwinConfigurations."m1" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.home-manager.darwinModules.default
          inputs.agenix.darwinModules.default
          ./modules/m1.nix
          ./modules/nix.nix
          ./modules/user.nix
          ./modules/wm.nix
          ./modules/brew.nix
        ];
      };
    };
}
